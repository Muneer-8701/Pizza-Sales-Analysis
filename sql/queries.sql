-- SQL Pizza Sales Analysis
CREATE DATABASE project.db;


-- Create TABLE
DROP TABLE IF EXISTS pizza_sales;
CREATE TABLE pizza_sales
	(
	   pizza_id INT PRIMARY KEY,
       order_id INT ,
       pizza_name_id VARCHAR(50) ,
	   quantity   INT,
       order_date  DATE,
       order_time  TIME,
       unit_price  FLOAT,
       total_price  FLOAT,
       pizza_size VARCHAR(50),  
       pizza_category VARCHAR(50),
       pizza_ingredients  VARCHAR(200),
       pizza_name   VARCHAR(50),
	);   

SELECT * FROM pizza_sales
LIMIT 10

SELECT COUNT(*) as total_records
FROM pizza_sales

ALTER TABLE pizza_sales
ADD CONSTRAINT pk_pizza_id PRIMARY KEY (pizza_id);

--Data cleaning

SELECT * FROM pizza_sales
WHERE 
    pizza_id IS NULL
    OR
    order_id  IS NULL
    OR 
    pizza_name_id IS NULL
    OR
    quantity IS NULL
    OR
    order_date IS NULL
    OR
    order_time IS NULL
    OR
    unit_price IS NULL
    OR
    total_price  IS NULL
	OR
    pizza_size  IS NULL;

DELETE FROM pizza_sales
WHERE 
	    pizza_id IS NULL
    OR
    order_id  IS NULL
    OR 
    pizza_name_id IS NULL
    OR
    quantity IS NULL
    OR
    order_date IS NULL
    OR
    order_time IS NULL
    OR
    unit_price IS NULL
    OR
    total_price  IS NULL
	OR
    pizza_size  IS NULL;


	
-- Data Analysis & Business Key Problems & Answers

--Q.1 Write a SQL query to find the Total Revenue
--Q.2 Write a SQL query to find the Average Order Value
--Q.3 Write a SQL query to find the Total Pizzas Sold
--Q.4 Write a SQL query to find the Total Orders
--Q.5 Write a SQL query to find the Average Pizzas Per Order
--Q.6 Write a SQL query to find total revenue as per size and category
--Q.7 Write a SQL query to daily Trend for Total Orders
--Q.8 Write a SQL query to Monthly Trend for orders
--Q.9 Write a SQL query Find the percentage of Sales by Pizza Category
--Q.10 Write a SQL query percentage of Sales by Pizza Size  (same as Q9)
--Q.11 Write a SQL query to calculate the cumulative sales per category
--Q.12 Write a SQL query to Best selling pizza(quantity-wise)
--Q.13 Write a SQL query to find the top 5 pizzas by revenue
--Q.14 Write a SQL query to Top 5 Pizzas by Total Orders (same as Q14)




--Q.1 Write a SQL query to find the Total Revenue
--The sum of the total price of all pizza order.

SELECT 
SUM(total_price) AS TOTAL_REVENUE 
FROM pizza_sales;


--Q.2 Write a SQL query to find the Average Order Value
/*The avegage amount spent per order.Calculated by dividing
total revenue by the total number of orders.*/

SELECT 
(SUM(total_price)/COUNT(DISTINCT order_id))AS Avg_order_value
FROM pizza_sales;	


--Q.3 Write a SQL query to find the Total Pizzas Sold
--The sum of the quantities of all pizza sold

SELECT 
SUM(Quantity) AS Total_pizza_sold 
FROM pizza_sales;


--Q.4 Write a SQL query to find the Total Orders
--The total number of orders placed

SELECT 	
COUNT(DISTINCT order_id) AS Total_orders 
FROM pizza_sales


--Q.5 Write a SQL query to find the Average Pizzas Per Order

SELECT 
SUM(Quantity)/COUNT(DISTINCT order_id) AS Avg_Pizza_order 
FROM pizza_sales


--Q.6 Write a SQL query to find total revenue as per size and category

SELECT 
	pizza_size,pizza_category, 
	count(*)AS total_orders,
	SUM(total_price) as total_revenue
from pizza_sales
GROUP BY pizza_size,pizza_category
ORDER BY total_revenue DESC;


--Q.7 Write a SQL query to daily Trend for Total Orders

SELECT 
	TO_CHAR (order_date,'Day') AS order_day, 
	COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales
GROUP BY TO_CHAR (order_date,'Day')


--Q.8 Write a SQL query to Monthly Trend for orders

SELECT 
	TO_CHAR (order_date,'Month') AS order_day, 
	COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales
GROUP BY TO_CHAR (order_date,'Month')


--Q.9  Write a SQL query Find the  % of Sales by Pizza Category

SELECT 
	pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
	CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS Percentage
FROM pizza_sales
GROUP BY pizza_category
ORDER BY total_revenue DESC


--Q.10 Write a SQL query percentage of Sales by Pizza Size  (same as Q9)

SELECT 
	pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
	CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS Percentage
FROM pizza_sales
GROUP BY pizza_size
ORDER BY total_revenue DESC


--Q.11 Write a SQL query to calculate the cumulative sales per category
--using window function

SELECT 
	pizza_category,
	pizza_name,
	SUM(total_price) OVER (PARTITION BY 
	pizza_category ORDER BY pizza_name) AS
cumulative_sales
FROM pizza_sales;


-- Q.12 Write a SQL query to Best selling pizza(quantity-wise)

SELECT 
	pizza_name,
	SUM(quantity) AS total_quantity
from pizza_sales
GROUP BY pizza_name
ORDER BY total_quantity desc
limit 5;


--Q.13 Write a SQL query to find the top 5 pizzas by revenue
--using Common Table expression(CTE)

WITH pizza_sales_summary AS (	
	SELECT  
		pizza_name,
		SUM(total_price) AS total_revenue
	FROM pizza_sales
	GROUP BY pizza_name
)
SELECT *
FROM pizza_sales_summary
ORDER BY total_revenue DESC
Limit 5


--Q.14 Write a SQL query to Top 5 Pizzas by Total Orders (same as Q14)

WITH pizza_sales_summary AS (
	SELECT  
	pizza_name,
	COUNT(DISTINCT order_id) AS Total_Orders
	FROM pizza_sales
	GROUP BY pizza_name
)
SELECT *FROM pizza_sales_summary
ORDER BY Total_Orders DESC
Limit 5


--End of project 













