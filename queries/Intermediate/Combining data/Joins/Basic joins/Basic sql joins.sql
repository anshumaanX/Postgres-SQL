-- =========================================================
-- BASIC SQL JOINS
-- Database: PostgreSQL
-- Description:
-- Joins are used to combine data from multiple tables
-- based on a related column between them.
--
-- In this example:
-- customers.id           -> Primary Key
-- orders.customer_id     -> Foreign Key
--
-- These columns create the relationship between
-- the customers and orders tables.
-- =========================================================


-- =========================================================
-- WITHOUT USING JOIN
-- =========================================================
-- Retrieve data from both tables separately.
-- Since no JOIN is used, the results are displayed
-- as two independent result sets.
SELECT *
FROM customers;

SELECT *
FROM orders;


-- =========================================================
-- INNER JOIN
-- =========================================================
-- Definition:
-- Returns only matching records from both tables.
--
-- Meaning:
-- Only customers who have placed at least one order
-- will appear in the result.
--
-- Explanation of query:
-- c  -> Alias for customers table
-- o  -> Alias for orders table
-- ON -> Defines the relationship between tables
--       using customers.id = orders.customer_id
SELECT
    c.id,
    c.first_name,
    o.order_id,
    o.sales
FROM customers AS c
INNER JOIN orders AS o
ON c.id = o.customer_id;


-- =========================================================
-- LEFT JOIN
-- =========================================================
-- Definition:
-- Returns all rows from the LEFT table
-- and matching rows from the RIGHT table.
--
-- Meaning:
-- All customers will appear in the result,
-- even if they have not placed any orders.
--
-- If no matching order exists,
-- order-related columns will contain NULL values.
SELECT *
FROM customers AS c
LEFT JOIN orders AS o
ON c.id = o.customer_id;


-- =========================================================
-- RIGHT JOIN
-- =========================================================
-- Definition:
-- Returns all rows from the RIGHT table
-- and matching rows from the LEFT table.
--
-- Meaning:
-- All orders will appear in the result,
-- even if there is no matching customer record.
--
-- If no matching customer exists,
-- customer-related columns will contain NULL values.
SELECT *
FROM customers AS c
RIGHT JOIN orders AS o
ON c.id = o.customer_id;


-- =========================================================
-- FULL JOIN
-- =========================================================
-- Definition:
-- Returns all rows from both tables.
--
-- Meaning:
-- Includes:
-- 1. Matching records from both tables
-- 2. Customers without orders
-- 3. Orders without matching customers
--
-- Non-matching columns are filled with NULL values.
SELECT *
FROM customers
FULL JOIN orders
ON customers.id = orders.customer_id;