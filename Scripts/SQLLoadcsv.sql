TRUNCATE TABLE sales.retail_sales_tb;
BULK INSERT sales.retail_sales_tb
from 'E:\choose right\SQL PROJECTS\Project of retail sales by GS\Retail.csv'
WITH(
     FIRSTROW=2,
     FIELDTERMINATOR=',',
     TABLOCK
     );


Select top 100* from sales.retail_sales_tb;