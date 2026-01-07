# Star Schema Design – FlexiMart Data Warehouse

## Section 1: Schema Overview

### **FACT TABLE: fact_sales**

**Grain:** One row per product per order line item  
**Business Process:** Sales transactions

**Measures (Numeric Facts):**
- `quantity_sold`: Number of units sold for the product in the order
- `unit_price`: Price per unit at the time of sale
- `discount_amount`: Discount applied on the line item
- `total_amount`: Final sales amount  
  `(quantity_sold × unit_price − discount_amount)`

**Foreign Keys:**
- `date_key` → `dim_date`
- `product_key` → `dim_product`
- `customer_key` → `dim_customer`

---

### **DIMENSION TABLE: dim_date**

**Purpose:** Enables time-based analysis such as daily, monthly, quarterly, and yearly trends  
**Type:** Conformed dimension

**Attributes:**
- `date_key` (PK): Surrogate key in YYYYMMDD format
- `full_date`: Actual calendar date
- `day_of_week`: Monday, Tuesday, etc.
- `month`: Numeric month (1–12)
- `month_name`: January, February, etc.
- `quarter`: Q1, Q2, Q3, Q4
- `year`: Calendar year
- `is_weekend`: Boolean flag

---

### **DIMENSION TABLE: dim_product**

**Purpose:** Stores descriptive information about products

**Attributes:**
- `product_key` (PK): Surrogate key
- `product_id`: Source system product identifier
- `product_name`: Name of the product
- `category`: Product category (Electronics, Clothing, etc.)
- `brand`: Manufacturer or brand name
- `price_band`: Low / Medium / High (derived attribute)

---

### **DIMENSION TABLE: dim_customer**

**Purpose:** Stores customer-related descriptive data

**Attributes:**
- `customer_key` (PK): Surrogate key
- `customer_id`: Source system customer identifier
- `customer_name`: Full customer name
- `email`: Customer email address
- `city`: City of residence
- `state`: State
- `country`: Country
- `customer_segment`: Retail / Premium / Wholesale

---

## Section 2: Design Decisions

The star schema is designed at the transaction line-item level, meaning each record in the fact table represents one product within an order. This granularity was chosen because it provides maximum analytical flexibility, allowing the business to analyze sales at detailed levels such as product, customer, or day, while still supporting aggregation to higher levels like monthly or yearly sales.

Surrogate keys are used instead of natural keys to improve performance and maintain historical accuracy. Natural keys from source systems can change over time, whereas surrogate keys remain stable and allow for efficient joins between fact and dimension tables.

This design supports drill-down and roll-up operations by separating numeric measures in the fact table from descriptive attributes in dimension tables. Analysts can roll up sales data from daily to monthly or yearly levels and drill down from category-level sales to individual product performance easily.

---

## Section 3: Sample Data Flow

### **Source Transaction**
Order:#101
Customer: John Doe
Product: Laptop
Quantity: 2
Unit Price: 50,000
Order Date: 2024-01-15

### **Data Warehouse Representation**

**fact_sales**
```json
{
  "date_key": 20240115,
  "product_key": 5,
  "customer_key": 12,
  "quantity_sold": 2,
  "unit_price": 50000,
  "discount_amount": 0,
  "total_amount": 100000
}

dim_date
{
  "date_key": 20240115,
  "full_date": "2024-01-15",
  "day_of_week": "Monday",
  "month": 1,
  "month_name": "January",
  "quarter": "Q1",
  "year": 2024,
  "is_weekend": false
}

dim_product
{
  "product_key": 5,
  "product_id": "PROD005",
  "product_name": "Laptop",
  "category": "Electronics",
  "brand": "Dell",
  "price_band": "High"
}

dim_customer
{
  "customer_key": 12,
  "customer_id": "CUST012",
  "customer_name": "John Doe",
  "email": "john.doe@example.com",
  "city": "Mumbai",
  "state": "Maharashtra",
  "country": "India",
  "customer_segment": "Retail"
}