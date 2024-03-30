use [DA Portfolio]
select * from pizza_sales



-- Total Revenue for the Year
select sum(total_price) as Total_Revenue
from pizza_sales



-- Total Orders for the year
select count(distinct order_id) as Total_Orders
from pizza_sales




-- Total Pizza Sold
select sum(quantity) as Total_Pizza_Sold
from pizza_sales




-- Average order value
select sum(total_price) / count(distinct order_id)
from pizza_sales



-- Average pizza per order
select 
	count(distinct order_id) as Number_of_Orders, 
	sum(quantity) as Number_of_Pizza_Sold, 
	cast(sum(quantity) as float) / count(distinct order_id) as AVG_Pizza_Per_Order
from pizza_sales



-- Create view to make top 5 best seller and worst seller pizzas by revenue, quantity and total orders
create view [Sub_Pizza] as
select 
	pizza_name, 
	sum(total_price) as Total_Revevue,
	sum(quantity) as Total_Quantity,
	count(distinct order_id) as Total_Orders
from pizza_sales
group by pizza_name

select * from Sub_Pizza




-- BEST SELLER PIZZAS
-- Top 5 Pizza by Highest Total Revevue
select top 5 pizza_name, Total_Revevue as Highest_Total_Revenue
from Sub_Pizza
order by 2 desc


-- Top 5 Pizza by Highest Quantities
select top 5 pizza_name, Total_Quantity as Highest_Total_Quantity
from Sub_Pizza
order by 2 desc


-- Top 5 Pizza by Highest Total Orders
select top 5 pizza_name, Total_Orders as Highest_Total_Order
from Sub_Pizza
order by 2 desc




-- WORST SELLER PIZZAS
-- Top 5 Pizza by Smallest Total Revenue
select top 5 pizza_name, Total_Revevue as Smallest_Total_Revenue
from Sub_Pizza
order by 2


-- Top 5 Pizza by Smallest Total Quantities
select top 5 pizza_name, Total_Quantity as Smallest_Total_Quantity
from Sub_Pizza
order by 2


-- Top 5 Pizza by Smallest Total Orders
select top 5 pizza_name, Total_Orders as Smallest_Total_Order
from Sub_Pizza
order by 2




-- Daily Trend for Total Orders
select DATENAME(DW, order_date) as Order_day, count(distinct order_id) as Total_Orders
from pizza_sales
group by DATENAME(DW, order_date) 
order by 2 desc


-- Monthly Trend for Total Orders
select DATENAME(month, order_date) as Order_month, count(distinct order_id) as Total_Orders
from pizza_sales
group by DATENAME(month, order_date) 
order by Total_Orders desc




-- Percentage of Sales by Pizza Category
select 
	pizza_category,
	sum(total_price) / (select sum(total_price) from pizza_sales) * 100 as PCT
from pizza_sales
group by pizza_category
order by 2 desc


-- Percentage of Sales by Pizza Size
select 
	pizza_size,
	cast(sum(total_price) as float) / (select sum(total_price) from pizza_sales) * 100 as PCT
from pizza_sales
group by pizza_size
order by PCT desc


-- Total Pizza Sold by Pizza Category
select 
	pizza_size,
	sum(quantity)
from pizza_sales
group by pizza_size
order by 2 desc

