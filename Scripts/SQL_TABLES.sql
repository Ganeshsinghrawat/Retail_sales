IF OBJECT_ID('sales.retail_sales_tb','U') is not NULL
DROP TABLE sales.retail_sales_tb;

GO

CREATE TABLE sales.retail_sales_tb(
transactions_id INT PRIMARY KEY ,
sale_date DATE,
sale_time TIME,
customer_id INT,
gender VARCHAR(15),
age INT,
category VARCHAR(15),
quantity INT,
price_per_unit FLOAT,
cogs FLOAT,
total_sale FLOAT
);