print("ETL script started")
import pandas as pd
import mysql.connector
from datetime import datetime

#connect Python with SQL
db = mysql.connector.connect(
    host="localhost",
    user="root",
    password="arjun1712",
    database="fleximart",
    connection_timeout = 5
)

cursor = db.cursor()


#Data Quality report file
report = open("part1_DB_ETL/data_quality_report.txt", "w")
report.write("DATA QUALITY REPORT\n")
report.write("====================\n\n")


#reading customer data
customers_df = pd.read_csv("data/customers_raw.csv")

#================================================
#CLEANING THE DATA(Customer)
#================================================

#removing Duplicates
before = len(customers_df)
customers_df = customers_df.drop_duplicates(subset="customer_id")
after = len(customers_df)

report.write(f"Customers duplicates removed: {before - after}\n")


#Handle missing emails
before = len(customers_df)
customers_df = customers_df.dropna(subset=["email"])
after = len(customers_df)

report.write(f"Customers removed due to missing email: {before - after}\n")


#Clean phone numbers
def clean_phone(phone):
    if pd.isna(phone):
        return None
    phone = str(phone)
    phone = phone.replace("+91", "")
    phone = phone.replace("-", "")
    phone = phone.lstrip("0")
    return phone

customers_df["phone"] = customers_df["phone"].apply(clean_phone)


#Fix registration dates
customers_df["registration_date"] = pd.to_datetime(
    customers_df["registration_date"],
    errors="coerce",
    dayfirst=True
)


#Standardize city names
customers_df["city"] = customers_df["city"].str.title().str.strip()


#INSERT CUSTOMERS INTO MYSQL (LOAD)
for _, row in customers_df.iterrows():
    cursor.execute(
        """
        INSERT INTO customers (first_name, last_name, email, phone, city, registration_date)
        VALUES (%s, %s, %s, %s, %s, %s)
        """,
        (
            row["first_name"],
            row["last_name"],
            row["email"],
            row["phone"],
            row["city"],
            row["registration_date"]
        )
    )

db.commit()
report.write(f"Customers loaded: {len(customers_df)}\n\n")

print("Customer done")

#================================================
#CLEAN PRODUCTS DATA
#================================================


products_df = pd.read_csv("data/Products_raw.csv")


#Normalize category names
#All variants → Electronics / Fashion / Groceries
products_df["category"] = products_df["category"].str.title().str.strip()


#Handle missing prices

before = len(products_df)
products_df = products_df.dropna(subset=["price"])
after = len(products_df)

report.write(f"Products removed due to missing price: {before - after}\n")


#Handle missing stock

products_df["stock_quantity"] = products_df["stock_quantity"].fillna(0)


#INSERT PRODUCTS


for _, row in products_df.iterrows():
    cursor.execute(
        """
        INSERT INTO products (product_name, category, price, stock_quantity)
        VALUES (%s, %s, %s, %s)
        """,
        (
            row["product_name"].strip(),
            row["category"],
            row["price"],
            int(row["stock_quantity"])
        )
    )

db.commit()
report.write(f"Products loaded: {len(products_df)}\n\n")

#READ SALES DATA
sales_df = pd.read_csv("data/Sales_raw.csv")


#================================================
#CLEAN SALES DATA
#================================================


#Remove duplicate transactions
before = len(sales_df)
sales_df = sales_df.drop_duplicates(subset="transaction_id")
after = len(sales_df)

report.write(f"Sales duplicates removed: {before - after}\n")


#Remove rows with missing customer or product IDs
before = len(sales_df)
sales_df = sales_df.dropna(subset=["customer_id", "product_id"])
after = len(sales_df)

report.write(f"Sales removed due to missing IDs: {before - after}\n")


#Fix transaction dates
sales_df["transaction_date"] = pd.to_datetime(
    sales_df["transaction_date"],
    errors="coerce",
    dayfirst=True
)


#INSERT ORDERS AND ORDER ITEMS
#Assumption:
#One transaction = one order
#quantity × unit_price = subtotal

for _, row in sales_df.iterrows():
    total = row["quantity"] * row["unit_price"]

    #Insert into orders table
    cursor.execute(
        """
        INSERT INTO orders (customer_id, order_date, total_amount, status)
        VALUES (
            (SELECT customer_id FROM customers WHERE email IS NOT NULL LIMIT 1),
            %s, %s, %s
        )
        """,
        (
            row["transaction_date"],
            total,
            row["status"]
        )
    )

    order_id = cursor.lastrowid

    #Insert into order_items table
    cursor.execute(
        """
        INSERT INTO order_items (order_id, product_id, quantity, unit_price, subtotal)
        VALUES (
            %s,
            (SELECT product_id FROM products LIMIT 1),
            %s, %s, %s
        )
        """,
        (
            order_id,
            row["quantity"],
            row["unit_price"],
            total
        )
    )

db.commit()
report.write(f"Orders loaded: {len(sales_df)}\n\n")


#CLOSE EVERYTHING
report.close()
cursor.close()
db.close()
print("ETL Pipeline completed successfully")