-- =========================================================
-- SUBQUERIES
-- =========================================================
-- A subquery is a query written inside another query.
--
-- The inner query executes first and its result is passed
-- to the outer (main) query.
--
-- Subqueries can be used in:
-- • SELECT clause
-- • FROM clause
-- • WHERE clause
-- • HAVING clause
--
-- =========================================================
-- TYPES OF SUBQUERIES
-- =========================================================
--
-- 1. SCALAR SUBQUERY
-- Returns exactly one value (1 row, 1 column)
--
-- Example:
-- SELECT AVG(price) FROM sales.products;
--
--
-- 2. ROW SUBQUERY
-- Returns a single row with multiple columns
--
-- Example:
-- SELECT productid, product
-- FROM sales.products
-- WHERE (productid, price) =
-- (
--     SELECT productid, price
--     FROM sales.products
--     WHERE productid = 101
-- );
--
--
-- 3. COLUMN SUBQUERY
-- Returns one column with multiple rows
--
-- Example:
-- SELECT customerid
-- FROM sales.orders
-- WHERE customerid IN
-- (
--     SELECT customerid
--     FROM sales.customers
--     WHERE country = 'Germany'
-- );
--
--
-- 4. TABLE SUBQUERY
-- Returns a complete table (multiple rows and columns)
--
-- Example:
-- SELECT *
-- FROM
-- (
--     SELECT *
--     FROM sales.products
-- ) t;
--
--
-- 5. CORRELATED SUBQUERY
-- Depends on values from the outer query.
-- Executed once for every row processed by the outer query.
--
-- Example:
-- SELECT *
-- FROM sales.customers c
-- WHERE EXISTS
-- (
--     SELECT 1
--     FROM sales.orders o
--     WHERE o.customerid = c.customerid
-- );
--
--
-- 6. NON-CORRELATED SUBQUERY
-- Independent of the outer query.
-- Executes only once.
--
-- Example:
-- SELECT *
-- FROM sales.products
-- WHERE price >
-- (
--     SELECT AVG(price)
--     FROM sales.products
-- );



-- =========================================================
-- TABLE SUBQUERY (FROM CLAUSE)
-- =========================================================
-- Find products whose price is higher than
-- the average product price.
SELECT
    *
FROM
(
    SELECT
        product,
        price,
        AVG(price) OVER () AS avg_price
    FROM sales.products
) t
WHERE price > avg_price;



-- =========================================================
-- TABLE SUBQUERY + WINDOW FUNCTION
-- =========================================================
-- Rank customers based on their total sales.
SELECT
    *,
    RANK() OVER (
        ORDER BY total_sales DESC
    ) AS sales_rank
FROM
(
    SELECT
        customerid,
        SUM(sales) AS total_sales
    FROM sales.orders
    GROUP BY customerid
) t;



-- =========================================================
-- SCALAR SUBQUERY
-- =========================================================
-- Show product details along with the total number
-- of orders in the system.
--
-- The subquery returns a single value, therefore
-- it is called a scalar subquery.
SELECT
    productid,
    product,
    price,
    (
        SELECT COUNT(orderid)
        FROM sales.orders
    ) AS total_orders
FROM sales.products;



-- =========================================================
-- TABLE SUBQUERY + JOIN
-- =========================================================
-- Show customer details along with the total number
-- of orders placed by each customer.
SELECT
    c.*,
    o.total_orders
FROM sales.customers AS c
LEFT JOIN
(
    SELECT
        customerid,
        COUNT(*) AS total_orders
    FROM sales.orders
    GROUP BY customerid
) AS o
ON c.customerid = o.customerid;



-- =========================================================
-- SCALAR SUBQUERY IN WHERE CLAUSE
-- =========================================================
-- Find products priced above the average product price.
SELECT
    productid,
    product,
    price
FROM sales.products
WHERE price >
(
    SELECT ROUND(AVG(price), 0)
    FROM sales.products
);



-- =========================================================
-- COLUMN SUBQUERY
-- =========================================================
-- Show orders placed by customers from Germany.
--
-- The subquery returns a single column containing
-- multiple customer IDs.
SELECT
    *
FROM sales.orders
WHERE customerid IN
(
    SELECT
        customerid
    FROM sales.customers
    WHERE country = 'Germany'
);



-- =========================================================
-- ANY
-- =========================================================
-- ANY means:
-- Compare against at least one value returned
-- by the subquery.
--
-- Find female employees whose salary is greater
-- than at least one male employee salary.
SELECT
    employeeid,
    firstname,
    salary,
    gender
FROM sales.employees
WHERE gender = 'F'
AND salary > ANY
(
    SELECT salary
    FROM sales.employees
    WHERE gender = 'M'
);



-- =========================================================
-- ALL
-- =========================================================
-- ALL means:
-- Compare against every value returned
-- by the subquery.
--
-- Find female employees whose salary is greater
-- than all male employee salaries.
UPDATE sales.employees
SET salary = 91000
WHERE employeeid = 3;

SELECT
    employeeid,
    firstname,
    salary,
    gender
FROM sales.employees
WHERE gender = 'F'
AND salary > ALL
(
    SELECT salary
    FROM sales.employees
    WHERE gender = 'M'
);



-- =========================================================
-- CORRELATED SUBQUERY
-- =========================================================
-- Show all customer details along with
-- the number of orders placed by each customer.
--
-- The inner query references the outer query,
-- therefore it is a correlated subquery.
SELECT
    *,
    (
        SELECT COUNT(*)
        FROM sales.orders AS o
        WHERE c.customerid = o.customerid
    ) AS total_orders
FROM sales.customers AS c;



-- =========================================================
-- EXISTS
-- =========================================================
-- EXISTS checks whether at least one row
-- is returned by the subquery.
--
-- Returns TRUE or FALSE.
--
-- Usually faster than IN when working with
-- large datasets because SQL can stop searching
-- after finding the first match.
--
-- Show orders placed by customers from Germany.
SELECT
    *
FROM sales.orders AS o
WHERE EXISTS
(
    SELECT 1
    FROM sales.customers AS c
    WHERE c.customerid = o.customerid
      AND c.country = 'Germany'
);