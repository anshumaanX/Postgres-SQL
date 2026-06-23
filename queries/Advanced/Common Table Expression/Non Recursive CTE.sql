-- Common Table Expression CTE
-- explain

-- non recursive cte
-- Stand alone CTE	

-- 1 STEP:- Find the total sales per customers
WITH CTE_Total_Sales AS
(
SELECT
	customerid,
	SUM(sales) AS total_sales
FROM sales.orders
GROUP BY customerid
-- order by is not allowed
),
-- 2 STEP:- Find the last orderdate per customer
CTE_Last_Ordered_Date AS
(
SELECT
	customerid,
	MAX(orderdate) AS last_order_date
FROM sales.orders
GROUP BY customerid
),
-- 3 STEP:- Rank the customers based on their total sales
-- NESTED CTE
-- now this cte is been dependent on the another cte
CTE_Rank AS
(
SELECT
	customerid,
	total_sales,
	RANK () OVER (ORDER BY total_sales DESC) AS rnk
FROM CTE_Total_Sales
),
-- 4 STEP:- Segment the customers based on their total sales
CTE_category AS
(
SELECT
	customerid,
	CASE
		WHEN c = 1 THEN 'Low'
		WHEN c = 2 THEN 'Medium'
		ELSE 'High'
	END AS category
FROM(
SELECT
	customerid,
	NTILE(3) OVER(ORDER BY total_sales) AS c
FROM CTE_Total_Sales
	)t
)
-- Main Query
SELECT
	c.customerid,
	c.firstname,
	c.lastname,
	cts.total_sales,
	lod.last_order_date,
	r.rnk,
	cat.category
FROM sales.customers AS c
LEFT JOIN CTE_Total_Sales cts
ON c.customerid = cts.customerid
LEFT JOIN CTE_Last_Ordered_Date AS lod
ON c.customerid = lod.customerid
LEFT JOIN CTE_Rank AS r
ON c.customerid = r.customerid
LEFT JOIN CTE_category AS cat
ON c.customerid = cat.customerid
ORDER BY total_sales DESC NULLS LAST;
