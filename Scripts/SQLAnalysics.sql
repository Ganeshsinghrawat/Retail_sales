use RETAIL;
**how many sales we have

select count(*) as total_sale from sales.retail_sales_tb

-- how many customers we have
select count(Distinct customer_id) as total_customers from
sales.retail_sales_tb
--unique category
select count(distinct category) as total_category
from sales.retail_sales_tb

select distinct category from sales.retail_sales_tb;

--- Data Analysis S& Business key problems & Answers
-- q1> Write a sql query to retrieve all columns for sales made on '2022-11-05'
-- q2> write a sql query to retrieve all transactions where the category is clothing and quantity sold is more than 10 in the month of nov-2022
--q3 > Write a sql query to calculate the total sales(total_sale)for each category
-- q4> write a sql query to find the average age of customers who purchased items from the Beauty category
-- q5> Write a sql query to find the total number of transactions (transactions_id) made by each gender in each category

--q1> Write a sql query to retrieve all columns for sales made on '2022-11-05'
select * from sales.retail_sales_tb where sale_date='2022-11-05'
--write a sql query to retrieve all transactions where the category is clothing and quantity sold is more than 10 in the month of nov-2022

select * from sales.retail_sales_tb 
where category='Clothing' 
--and 
--quantity>10 
and
year(sale_date)=2022 and month(sale_date)=11


--q3 > Write a sql query to calculate the total sales(total_sale)for each category
select category,sum(total_sale) as totalsales from sales.retail_sales_tb
group by category

-- q4> write a sql query to find the average age of customers who purchased items from the Beauty category

select round(avg(case when age is not null then age*1.0 end),2) average_age from sales.retail_sales_tb where category='Beauty'

select category,gender,count(transactions_id) as toal_ids from sales.retail_sales_tb group by category,gender

--q6> write a ssql query to find all transactions where the total_sale is greater than1000
--q7> write a sql query to calculate the average sale for each month.Find out best selling month in each year
--q8> Write a SQL query to find the top 5 customers based on the highest total sales
--q9> Write a SQL query to find the number of unique customers who purchased items from each category.
--q10>Write a SQL query to create each shift and number of orders(Example Morning <=12,Afternoon Between 12& 17,Evening>17)

select * from sales.retail_sales_tb
select * from sales.retail_sales_tb where total_sale>1000


select datepart(month,sale_date) as months,
round(avg(total_sale),2) as average_sales from sales.retail_sales_tb
group by datepart(month,sale_date)
order by datepart(month,sale_date)


--Q>7 Find out best selling month in each year
with cte_1 as(
select datepart(year,sale_date) as years,
datepart(month,sale_date) as months,
avg(total_sale) as saless ,
rank() over(partition by datepart(year,sale_date) order by avg(total_sale) desc) as rankk
from sales.retail_sales_tb
group by datepart(year,sale_date),datepart(month,sale_date)

)
select * from cte_1 where rankk=1
--select* from cte_1 where saless in (select max(saless) from cte_1 group by years)

---------------- new approach---------\
with cte_1 as(
select datepart(year,sale_date) as years,datepart(month,sale_date) as months,sum(total_sale) as saless from sales.retail_sales_tb
group by datepart(year,sale_date),datepart(month,sale_date)
)

select  years,months,saless from(
select years,months,saless,
row_number() over(partition by years order by saless desc ) as rk
from cte_1)t
where t.rk=1

--q8>> top 5 customers based on the highest total sales
select * from sales.retail_sales_tb
select top 5 customer_id,sum(total_sale) as total_sale,count(transactions_id) from sales.retail_sales_tb
group by customer_id
having count(transactions_id)>1
order by sum(total_sale)desc

--q9>  the number of unique customers who purchased items from each category
 select category,count(distinct customer_id) as unique_customer from sales.retail_sales_tb
 group by category
-- q10
--Write a SQL query to create each shift and number of orders(Example Morning <=12,Afternoon Between 12& 17,Evening>17)
select case when sale_time<='12:00:00' then 'Morning'
            when sale_time between '12:00:00' and '17:00:00' then 'Afternoon'
            else 'Evening'
        end as Shift,
        count(*) as number_of_orders
from sales.retail_sales_tb
group by case when sale_time<='12:00:00' then 'Morning'
            when sale_time between '12:00:00' and '17:00:00' then 'Afternoon'
            else 'Evening'
        end
