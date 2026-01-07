-- Inserting Values in Warehouse Schema

USE fleximart_dw;

/* =====================================================
   DIM_DATE (30 dates: Jan–Feb 2024)
   ===================================================== */

INSERT INTO dim_date VALUES
(20240101,'2024-01-01','Monday',1,1,'January','Q1',2024,false),
(20240102,'2024-01-02','Tuesday',2,1,'January','Q1',2024,false),
(20240103,'2024-01-03','Wednesday',3,1,'January','Q1',2024,false),
(20240104,'2024-01-04','Thursday',4,1,'January','Q1',2024,false),
(20240105,'2024-01-05','Friday',5,1,'January','Q1',2024,false),
(20240106,'2024-01-06','Saturday',6,1,'January','Q1',2024,true),
(20240107,'2024-01-07','Sunday',7,1,'January','Q1',2024,true),
(20240108,'2024-01-08','Monday',8,1,'January','Q1',2024,false),
(20240109,'2024-01-09','Tuesday',9,1,'January','Q1',2024,false),
(20240110,'2024-01-10','Wednesday',10,1,'January','Q1',2024,false),
(20240111,'2024-01-11','Thursday',11,1,'January','Q1',2024,false),
(20240112,'2024-01-12','Friday',12,1,'January','Q1',2024,false),
(20240113,'2024-01-13','Saturday',13,1,'January','Q1',2024,true),
(20240114,'2024-01-14','Sunday',14,1,'January','Q1',2024,true),
(20240115,'2024-01-15','Monday',15,1,'January','Q1',2024,false),
(20240201,'2024-02-01','Thursday',1,2,'February','Q1',2024,false),
(20240202,'2024-02-02','Friday',2,2,'February','Q1',2024,false),
(20240203,'2024-02-03','Saturday',3,2,'February','Q1',2024,true),
(20240204,'2024-02-04','Sunday',4,2,'February','Q1',2024,true),
(20240205,'2024-02-05','Monday',5,2,'February','Q1',2024,false),
(20240206,'2024-02-06','Tuesday',6,2,'February','Q1',2024,false),
(20240207,'2024-02-07','Wednesday',7,2,'February','Q1',2024,false),
(20240208,'2024-02-08','Thursday',8,2,'February','Q1',2024,false),
(20240209,'2024-02-09','Friday',9,2,'February','Q1',2024,false),
(20240210,'2024-02-10','Saturday',10,2,'February','Q1',2024,true),
(20240211,'2024-02-11','Sunday',11,2,'February','Q1',2024,true),
(20240212,'2024-02-12','Monday',12,2,'February','Q1',2024,false),
(20240213,'2024-02-13','Tuesday',13,2,'February','Q1',2024,false),
(20240214,'2024-02-14','Wednesday',14,2,'February','Q1',2024,false),
(20240215,'2024-02-15','Thursday',15,2,'February','Q1',2024,false);

/* =====================================================
   DIM_PRODUCT (15 products, 3 categories)
   ===================================================== */

INSERT INTO dim_product (product_id, product_name, category, subcategory, unit_price) VALUES
('ELEC001','Laptop Pro','Electronics','Computers',75000),
('ELEC002','Smartphone X','Electronics','Mobiles',45000),
('ELEC003','Bluetooth Headphones','Electronics','Accessories',5000),
('ELEC004','Smart TV','Electronics','TV',65000),
('ELEC005','Tablet','Electronics','Tablets',30000),

('CLOT001','Men T-Shirt','Clothing','Topwear',999),
('CLOT002','Women Jeans','Clothing','Bottomwear',1999),
('CLOT003','Jacket','Clothing','Outerwear',4999),
('CLOT004','Sneakers','Clothing','Footwear',3999),
('CLOT005','Formal Shirt','Clothing','Topwear',1499),

('HOME001','Mixer Grinder','Home Appliances','Kitchen',4500),
('HOME002','Refrigerator','Home Appliances','Large Appliance',55000),
('HOME003','Microwave Oven','Home Appliances','Kitchen',12000),
('HOME004','Air Conditioner','Home Appliances','Cooling',70000),
('HOME005','Vacuum Cleaner','Home Appliances','Cleaning',8000);

/* =====================================================
   DIM_CUSTOMER (12 customers, 4 cities)
   ===================================================== */

INSERT INTO dim_customer (customer_id, customer_name, city, state, customer_segment) VALUES
('C001','John Doe','Mumbai','Maharashtra','Retail'),
('C002','Anita Sharma','Delhi','Delhi','Retail'),
('C003','Rohit Verma','Bangalore','Karnataka','Premium'),
('C004','Neha Gupta','Pune','Maharashtra','Retail'),
('C005','Amit Singh','Mumbai','Maharashtra','Wholesale'),
('C006','Priya Mehta','Delhi','Delhi','Premium'),
('C007','Karan Malhotra','Bangalore','Karnataka','Retail'),
('C008','Sneha Iyer','Pune','Maharashtra','Retail'),
('C009','Vikas Jain','Mumbai','Maharashtra','Premium'),
('C010','Pooja Kapoor','Delhi','Delhi','Retail'),
('C011','Rahul Nair','Bangalore','Karnataka','Wholesale'),
('C012','Meena Das','Pune','Maharashtra','Retail');

/* =====================================================
   FACT_SALES (40 transactions)
   ===================================================== */

INSERT INTO fact_sales
(date_key, product_key, customer_key, quantity_sold, unit_price, discount_amount, total_amount) VALUES
(20240106,1,1,1,75000,5000,70000),
(20240106,2,2,2,45000,0,90000),
(20240107,4,3,1,65000,3000,62000),
(20240113,14,4,1,70000,5000,65000),
(20240114,12,5,1,55000,0,55000),

(20240115,6,6,3,999,0,2997),
(20240115,7,7,2,1999,0,3998),
(20240115,10,8,1,1499,0,1499),
(20240203,3,9,2,5000,500,9500),
(20240203,11,10,1,4500,0,4500),

(20240204,15,11,1,8000,1000,7000),
(20240210,9,12,1,3999,0,3999),
(20240210,5,1,2,30000,2000,58000),
(20240211,8,2,1,4999,0,4999),
(20240211,13,3,1,12000,1000,11000),

(20240212,6,4,4,999,0,3996),
(20240212,7,5,3,1999,500,5497),
(20240213,1,6,1,75000,10000,65000),
(20240213,2,7,1,45000,5000,40000),
(20240214,4,8,1,65000,0,65000),

(20240102,11,9,2,4500,0,9000),
(20240103,12,10,1,55000,5000,50000),
(20240104,3,11,3,5000,0,15000),
(20240105,6,12,2,999,0,1998),
(20240108,9,1,1,3999,0,3999),

(20240109,14,2,1,70000,7000,63000),
(20240110,15,3,1,8000,0,8000),
(20240111,5,4,1,30000,3000,27000),
(20240112,10,5,2,1499,0,2998),
(20240113,7,6,2,1999,0,3998),

(20240201,8,7,1,4999,0,4999),
(20240202,11,8,1,4500,0,4500),
(20240203,2,9,1,45000,0,45000),
(20240204,1,10,1,75000,8000,67000),
(20240205,6,11,3,999,0,2997),

(20240206,9,12,1,3999,0,3999),
(20240207,13,1,1,12000,1000,11000),
(20240208,14,2,1,70000,5000,65000),
(20240209,4,3,1,65000,0,65000);