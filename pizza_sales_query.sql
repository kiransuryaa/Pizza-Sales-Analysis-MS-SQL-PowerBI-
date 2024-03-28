
---------------------------------Queries----------------------------------------------------------------
USE pizza_db;
--1. Total Revenue
SELECT SUM(total_price) AS Total_Revenue FROM pizza_sales;

--2. Average order value 
SELECT SUM(total_price) / COUNT(DISTINCT(order_id)) AS Avg_order_value FROM pizza_sales;

-- 3. Total pizza sales
SELECT SUM(quantity) AS Total_pizza_sold FROM pizza_sales

--4. Total Orders
SELECT COUNT(DISTINCT(order_id)) AS Total_Orders FROM pizza_sales

--5. Average pizza per order
SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) /
CAST(COUNT(DISTINCT(order_id)) AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS Avg_pizza_sold_per_order FROM pizza_sales;

--6. Daily trend for total order (i.e. Total orders on a daily basis)
SELECT DATENAME(DW,  order_date) AS order_day, COUNT(DISTINCT(order_id)) AS Total_orders
FROM pizza_sales
GROUP BY DATENAME(DW,  order_date)
ORDER BY Total_orders DESC;

--7. Hourly trend 
SELECT DATEPART( HH, order_time) AS Order_hour,  COUNT(DISTINCT(order_id)) AS Total_orders
FROM pizza_sales
GROUP BY DATEPART( HOUR, order_time)
ORDER BY Total_orders DESC;

--8. Monthly trend
SELECT DATENAME(MONTH, order_date) AS month_name, COUNT(DISTINCT(order_id)) AS total_order
FROM pizza_sales
GROUP BY DATENAME(MONTH, order_date)
ORDER BY total_order DESC;

--9. Percentage of sales by pizza category
SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL (10,2)) AS Total_sales, 
CONCAT(CAST(SUM(total_price) *100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)), '%') AS PCT
FROM pizza_sales
GROUP BY pizza_category; 

--10. Percentage of sales by pizza size
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL (10,2)) AS Total_sales, 
CONCAT(CAST(SUM(total_price) *100 / (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)), '%') AS PCT
FROM pizza_sales
GROUP BY pizza_size;

--11. Top 5 best sellers by Revenue
SELECT TOP 5 pizza_name, SUM(total_price) AS Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Revenue DESC;

--Bottom 5
SELECT TOP 5 pizza_name, SUM(total_price) AS Revenue
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Revenue ASC;

--12. Top 5 best sellers by Total_quantity
SELECT TOP 5 pizza_name, SUM(quantity) AS Total_quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_quantity DESC;

--Bottom 5
SELECT TOP 5 pizza_name, SUM(quantity) AS Total_quantity
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_quantity ASC;

--13. Top 5 best sellers by Total_orders
SELECT TOP 5 pizza_name, COUNT(DISTINCT(order_id)) AS Total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_orders DESC;

--bottom 5
SELECT TOP 5 pizza_name, COUNT(DISTINCT(order_id)) AS Total_orders
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_orders ASC;


