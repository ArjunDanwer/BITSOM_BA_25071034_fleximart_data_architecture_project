# FlexiMart Database Schema Documentation

## 1. Entity–Relationship Description

### **ENTITY: customers**

**Purpose:**
Stores master information about customers registered on the FlexiMart platform.

**Attributes:**

- `customer_id`: Unique identifier for each customer (Primary Key)
- `first_name`: Customer's first name
- `last_name`: Customer's last name
- `email`: Customer's email address (unique, used for communication)
- `phone`: Customer's contact number
- `city`: City where the customer resides
- `registration_date`: Date when the customer registered on the platform

**Relationships:**
- One customer can place many orders
  (1:M relationship with orders table via `customer_id`)

---

### **ENTITY: products**

**Purpose:**
Stores information about products available for sale on FlexiMart.

**Attributes:**

- `product_id`: Unique identifier for each product (Primary Key)
- `product_name`: Name of the product
- `category`: Product category (e.g., Electronics, Fashion, Groceries)
- `price`: Selling price of the product
- `stock_quantity`: Available inventory quantity

**Relationships:**
- One product can appear in many order items
  (1:M relationship with order_items table via `product_id`)

---

### **ENTITY: orders**

**Purpose:**
Represents customer orders placed on the platform.

**Attributes:**

- `order_id`: Unique identifier for each order (Primary Key)
- `customer_id`: Identifier of the customer who placed the order (Foreign Key)
- `order_date`: Date when the order was placed
- `total_amount`: Total monetary value of the order
- `status`: Current order status (e.g., Pending, Completed, Cancelled)

**Relationships:**
- Each order belongs to one customer
- One order can have many order items
  (1:M relationship with order_items)

---

### **ENTITY: order_items**

**Purpose:**
Stores item-level details for each order.

**Attributes:**

- `order_item_id`: Unique identifier for each order item (Primary Key)
- `order_id`: Associated order identifier (Foreign Key)
- `product_id`: Associated product identifier (Foreign Key)
- `quantity`: Number of units purchased
- `unit_price`: Price per unit at the time of purchase
- `subtotal`: Calculated value (quantity × unit_price)

**Relationships:**
- Many order items belong to one order
- Many order items reference one product

---

## 2. Normalization Explanation (3NF)

The FlexiMart database schema is designed following Third Normal Form (3NF) principles to ensure data integrity, eliminate redundancy, and prevent anomalies.

**Functional Dependencies:**

- `customer_id` → `first_name`, `last_name`, `email`, `phone`, `city`, `registration_date`
- `product_id` → `product_name`, `category`, `price`, `stock_quantity`
- `order_id` → `customer_id`, `order_date`, `total_amount`, `status`
- `order_item_id` → `order_id`, `product_id`, `quantity`, `unit_price`, `subtotal`

**Normalization Analysis:**

1. **First Normal Form (1NF):** Each table satisfies 1NF as all attributes contain atomic values and there are no repeating groups.
2. **Second Normal Form (2NF):** The schema satisfies 2NF because all non-key attributes are fully functionally dependent on the entire primary key; partial dependencies do not exist, especially since surrogate keys are used.
3. **Third Normal Form (3NF):** The schema achieves 3NF as there are no transitive dependencies. Non-key attributes depend only on the primary key and not on other non-key attributes. For example, customer details are stored only in the customers table and not duplicated in the orders table.

**Anomaly Prevention:**

- **Update anomalies** are avoided because customer and product details are stored once.
- **Insert anomalies** are prevented since new customers or products can be added independently.
- **Delete anomalies** are avoided as deleting an order does not remove customer or product data.

---

## 3. Sample Data Representation

### **customers (Sample Records)**

| customer_id | first_name | last_name | email                     | phone           | city      | registration_date |
|-------------|------------|-----------|---------------------------|-----------------|-----------|-------------------|
| 1           | Rahul      | Sharma    | rahul.sharma@gmail.com    | +91-9876543210  | Bangalore | 2023-01-15        |
| 2           | Priya      | Patel     | priya.patel@yahoo.com     | +91-9988776655  | Mumbai    | 2023-02-20        |

### **products (Sample Records)**

| product_id | product_name       | category    | price    | stock_quantity |
|------------|--------------------|-------------|----------|----------------|
| 1          | Samsung Galaxy S21 | Electronics | 45999.00 | 150            |
| 2          | Nike Running Shoes | Fashion     | 3499.00  | 80             |

### **orders (Sample Records)**

| order_id | customer_id | order_date | total_amount | status    |
|----------|-------------|------------|--------------|-----------|
| 1        | 1           | 2024-01-15 | 45999.00     | Completed |
| 2        | 2           | 2024-01-16 | 5998.00      | Completed |

### **order_items (Sample Records)**

| order_item_id | order_id | product_id | quantity | unit_price | subtotal |
|---------------|----------|------------|----------|------------|----------|
| 1             | 1        | 1          | 1        | 45999.00   | 45999.00 |
| 2             | 2        | 2          | 2        | 2999.00    | 5998.00  |