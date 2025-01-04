-- KPIs 

-- 1. Total Revenue
SELECT SUM(total_price) AS "Total Revenue"
FROM public.pizza_sales;

-- 2. Average Order Value
SELECT (SUM(total_price) / COUNT(DISTINCT order_id)) AS "Average Order Value"
FROM public.pizza_sales;

-- 3. Total Pizzas Sold
SELECT SUM(quantity) AS "Total Pizzas Sold"
FROM public.pizza_sales;

-- 4. Total Orders
SELECT COUNT(DISTINCT order_id) AS "Total Orders"
FROM public.pizza_sales;

-- 5. Average Pizzas per Order
SELECT CAST(CAST(SUM (quantity) AS DECIMAL(10, 2)) / 
		CAST(COUNT(DISTINCT order_id) AS DECIMAL(10, 2)) AS DECIMAL(10, 2)) AS "Average Pizzas per Order"
FROM public.pizza_sales;


-- DAILY TREND FOR TOTAL ORDERS
SELECT TO_CHAR(order_date, 'Day') AS "Order Day", 
		COUNT(DISTINCT order_id) AS "Total Orders"
FROM public.pizza_sales
GROUP BY TO_CHAR(order_date, 'Day')
ORDER BY COUNT(DISTINCT order_id) DESC;


-- MONTHLY TREND FOR TOTAL ORDERS
SELECT TO_CHAR(order_date, 'Month') AS "Order Month", 
		COUNT(DISTINCT order_id) AS "Total Orders"
FROM public.pizza_sales
GROUP BY TO_CHAR(order_date, 'Month')
ORDER BY COUNT(DISTINCT order_id) DESC;


-- PERCENTAGE OF SALES BY PIZZA CATEGORY
SELECT pizza_category AS "Pizza Category", 
		SUM(total_price) AS "Total Revenue", 
		CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) 
		FROM public.pizza_sales) AS DECIMAL(10, 2)) AS "Sales (%)"
FROM public.pizza_sales
GROUP BY pizza_category
ORDER BY "Sales (%)" DESC;


-- PERCENTAGE OF SALES BY PIZZA SIZE
SELECT pizza_size AS "Pizza Size",
		SUM(total_price) AS "Total Revenue",
		CAST(SUM(total_price) * 100 / (SELECT SUM(total_price)
		FROM public.pizza_sales) AS DECIMAL(10, 2)) AS "Sales (%)"
FROM public.pizza_sales
GROUP BY pizza_size
ORDER BY "Sales (%)" DESC;


-- TOTAL PIZZAS SOLD BY PIZZA CATEGORY
SELECT pizza_category AS "Pizza Category", 
		SUM(quantity) AS "Total Pizzas Sold"
FROM public.pizza_sales
GROUP BY pizza_category
ORDER BY "Total Pizzas Sold" DESC;


--TOP 5 (BEST) SELLERS BY REVENUE
SELECT pizza_name AS "Pizza Name",
		SUM(total_price) AS "Total Revenue"
FROM public.pizza_sales
GROUP BY pizza_name
ORDER BY "Total Revenue" DESC
LIMIT 5;


-- TOP 5 (BEST) SELLERS BY TOTAL QUANTITY
SELECT pizza_name AS "Pizza Name",
		SUM(quantity) AS "Total Pizzas Sold"
FROM public.pizza_sales
GROUP BY pizza_name
ORDER BY "Total Pizzas Sold" DESC
LIMIT 5;


-- TOP 5 (BEST) SELLERS BY TOTAL ORDERS
SELECT pizza_name AS "Pizza Name",
		COUNT(DISTINCT order_id) AS "Total Orders"
FROM public.pizza_sales
GROUP BY pizza_name
ORDER BY "Total Orders" DESC
LIMIT 5;


-- TOP 5 (BEST) SELLERS BY REVENUE, TOTAL QUANTITY, AND TOTAL ORDERS COMBINED
SELECT pizza_name AS "Pizza Name",
		SUM(total_price) AS "Total Revenue",
		SUM(quantity) AS "Total Pizzas Sold",
		COUNT(DISTINCT order_id) AS "Total Orders"
FROM public.pizza_sales
GROUP BY pizza_name
ORDER BY "Total Revenue" DESC, "Total Pizzas Sold" DESC, "Total Orders" DESC
LIMIT 5;


-- BOTTOM 5 (WORST) SELLERS BY REVENUE
SELECT pizza_name AS "Pizza Name",
		SUM(total_price) AS "Total Revenue"
FROM public.pizza_sales
GROUP BY pizza_name
ORDER BY "Total Revenue" ASC
LIMIT 5;


-- BOTTOM 5 (WORST) SELLERS BY TOTAL QUANTITY
SELECT pizza_name AS "Pizza Name",
		SUM(quantity) AS "Total Pizzas Sold"
FROM public.pizza_sales
GROUP BY pizza_name
ORDER BY "Total Pizzas Sold" ASC
LIMIT 5;


-- BOTTOM 5 (WORST) SELLERS BY TOTAL ORDERS
SELECT pizza_name AS "Pizza Name",
		COUNT(DISTINCT order_id) AS "Total Orders"
FROM public.pizza_sales
GROUP BY pizza_name
ORDER BY "Total Orders" ASC
LIMIT 5;


-- BOTTOM 5 (WORST) SELLERS BY REVENUE, TOTAL QUANTITY, AND TOTAL ORDERS COMBINED
SELECT pizza_name AS "Pizza Name",
		SUM(total_price) AS "Total Revenue",
		SUM(quantity) AS "Total Pizzas Sold",
		COUNT(DISTINCT order_id) AS "Total Orders"
FROM public.pizza_sales
GROUP BY pizza_name
ORDER BY "Total Revenue" ASC, "Total Pizzas Sold" DESC, "Total Orders" DESC
LIMIT 5;