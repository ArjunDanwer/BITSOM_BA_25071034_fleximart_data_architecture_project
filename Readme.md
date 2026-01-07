# FlexiMart Data Architecture Project

## Project Overview

This project demonstrates an end-to-end data architecture implementation for an e-commerce platform called FlexiMart.

The objective was to handle:
- Raw, inconsistent operational data
- Flexible product catalog data with nested attributes
- Analytical reporting using a data warehouse

The project is divided into three major phases:
1. ETL pipeline using MySQL for cleaned operational data
2. NoSQL implementation using MongoDB for product catalogs
3. Star-schema based data warehouse for analytics


## Tech Stack

- Python: Data cleaning and ETL pipeline
- MySQL: Relational database and data warehouse
- MongoDB: NoSQL document database
- Pandas: CSV processing and transformation
- VS Code: Development environment


## Dataset Description

The project uses four datasets:

1. customers_raw.csv  
   Contains customer details with issues such as missing emails, duplicate records, inconsistent phone formats, and inconsistent date formats.

2. products_raw.csv  
   Contains product information with missing prices, inconsistent category naming, and null stock values.

3. sales_raw.csv  
   Contains transaction data with missing customer/product IDs, duplicate transactions, and inconsistent date formats.

4. products_catalog.json  
   Contains semi-structured product catalog data including specifications, reviews, and tags used for the MongoDB implementation.


## Phase 1: ETL Pipeline (MySQL)

An ETL pipeline was built using Python to clean and load raw CSV data into a normalized MySQL database.

Key steps:
- Removed duplicate records
- Handled missing values
- Standardized phone numbers and date formats
- Normalized data into relational tables
- Generated a data quality report

The final schema follows normalization principles to reduce redundancy and ensure data integrity.


## Phase 2: NoSQL Database (MongoDB)

MongoDB was used to store the product catalog due to its flexible schema requirements.

Each product is stored as a document containing:
- Nested specifications
- Embedded customer reviews
- Tags and metadata

MongoDB aggregation pipelines were used to:
- Calculate average ratings
- Analyze products by category and price
- Dynamically update reviews without schema changes


## Phase 3: Data Warehouse & Analytics

A separate MySQL data warehouse was created using a star schema design.

Components:
- One fact table (fact_sales)
- Four dimension tables (date, customer, product, city)

This design enables fast analytical queries such as:
- Monthly sales trends
- Revenue by city
- Best-selling product categories
- Average order value


## How to Run the Project

1. Install Python, MySQL, MongoDB, and required Python libraries
2. Place raw datasets inside the `data/` folder
3. Run the ETL pipeline:
   ```bash
   python part1-database-etl/etl_pipeline.py


## Key Learnings

- Importance of data quality before analysis
- Practical differences between SQL and NoSQL databases
- Designing star schemas for analytical workloads
- Writing business-focused SQL analytics queries
- Structuring an end-to-end data architecture project

## Future Improvements

- Automate data warehouse loading using scheduled ETL jobs
- Add indexes for performance optimization
- Visualize analytics using Power BI or Tableau
- Implement Slowly Changing Dimensions (SCD)