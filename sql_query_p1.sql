-- SQL Retail Sales Analysis
use  sql_project_p1;
drop table if exists retail_sales;
create table retail_sales(
							transactions_id	int primary key,
							sale_date	date,
							sale_time	time,
							customer_id	int,
							gender	varchar(20),
							age	     int,
							category	varchar(20),
							quantiy	     int,
							price_per_unit	int,
							cogs	float,
							total_sale float
                         )
select * from retail_sales ;

select 
count(*)
 from retail_sales

select * from retail_sales where transactions_id is null;

select * from retail_sales where sale_date is null;

select * from retail_sales where sale_time is null;

select * from retail_sales where customer_id is null;

select * from retail_sales where gender is null;

select * from retail_sales where age  is null;

select * from retail_sales where gender is null;

select * from retail_sales where category is null;

select * from retail_sales where quantity is null;

select * from retail_sales where price_per_unit  is null;

select * from retail_sales where cogs  is null;

select * from retail_sales where total_sale is null;

select * from retail_sales 
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
quantiy is null
or
price_per_unit is null
or
cogs is null
or
total_sale is null;

-- data exploration

-- how many sales we have?
select count(*)  as total_sales from retail_sales; 

-- how many unique customers we have?
select count(distinct customer_id)  as total_sales from retail_sales; 

-- how many unique category we have?
select distinct category  from retail_sales; 

-- Data Analysis & Business problems --
--  1) write a sql query to retrive all columns for sales made on '2022-11-05'
select * from retail_sales where sale_date = '2022-11-05' ;

-- 2) write a sql query to retrive all transactions where the category id 'clothing' and quantity sold is more than 10 in the month of nov-'2022'
select * from retail_sales 
where category ='clothing' 
and month(sale_date ) = 11
and year(sale_date)=2022
and quantiy >=3
;

-- 3) write a sql query to calculate the tota_sales(total_sale) for each category
select category,sum(total_sale) as total,
count(*) as total_sales
 from retail_sales group by 1;
--  4) we add group by 1 because it groups by first added column that is category ant it includes names on category
select sum(total_sale) as total from retail_sales group by category;
-- this doesn't take name of the category

-- 5) write a sql query to find a avg age of customers who purchased items from the beauty category
select round(avg(age),2)  as avg_age from retail_sales where category='beauty';

-- 6) write a sql query to find all transactions where the total sales is greater than 1000
select count(transactions_id) from  retail_sales where total_sale>1000;
select count(*) from  retail_sales where total_sale>1000;
select * from  retail_sales where total_sale>1000;

-- 7) write a query to find the total_number of transactions (transactions_id) made by each gender in each category
select category, gender, count(transactions_id) from retail_sales group by 1,2 order by  1, 2 ;


-- 8) write a sql query to calculate the avg sale for each month, find out the best selling month in each year
-- select * from
-- (
-- select
-- 	extract(year from sale_date) as year,
-- 	extract(month from sale_date) as month,
-- 	avg(total_sale) as avg_sale,
-- 	rank() over(partition by extract(year from sale_date) order by avg(total_sale) desc)  as rank
--     from retail_sales
-- group by 1,2

-- ) t1

-- 8) write a sql query to find the top 5 customers based on heighest total_sales
select customer_id,
sum(total_sale) as total
from retail_sales
group by 1 
order by 2 desc limit 5;

-- 9) wrrite a sql query to find the number of unique customers who purchased items from each catogery
select category, count(distinct customer_id) as customer from retail_sales group by 1;

-- 10) write a sql query to create each shift and number od orders example(morning <=12, afternoon between 12 & 17, evening >17)
with hourly_sale
as(
select *,
 case 
    when extract(hour from sale_time) < 12 then 'morning'
    when extract(hour from sale_time) between 12 and 17 then 'afternoon'
    else 'evening'
end as shift
from retail_sales
)
select shift,
count(*) as total_orders
from hourly_sale
group by shift



 

