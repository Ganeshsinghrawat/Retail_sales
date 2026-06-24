--select * from sales.retail_sales_tb
select * from sales.retail_sales_tb
where 
transactions_id is null
or
sale_date is null 
or
sale_time is null
or
customer_id is null
or
gender is null
or
age is null
or
category is null
or
quantity is null
or
price_per_unit is null
or 
cogs is null
or 
total_sale is null;

SELECT
    SUM(CASE WHEN age IS NULL THEN 1 ELSE 0 END) AS age_nulls,
    SUM(CASE WHEN quantity IS NULL THEN 1 ELSE 0 END) AS quantity_nulls,
    SUM(CASE WHEN price_per_unit IS NULL THEN 1 ELSE 0 END) AS price_nulls,
    SUM(CASE WHEN cogs IS NULL THEN 1 ELSE 0 END) AS cogs_nulls,
    SUM(CASE WHEN total_sale IS NULL THEN 1 ELSE 0 END) AS sales_nulls
FROM  sales.retail_sales_tb;


Begin transaction;
DELETE FROM SALES.RETAIL_SALES_TB
WHERE quantity is null or 
      price_per_unit is null or
      cogs is null or
      total_sale is null

--rollback;
commit;
