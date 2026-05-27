-- =========================================================
-- ADVANCED SQL JOINS
-- Database: PostgreSQL
-- Description:
-- This file demonstrates advanced join techniques such as
-- anti joins and cross joins.
--
-- Anti joins are commonly used to find unmatched records.
-- =========================================================


-- =========================================================
-- LEFT ANTI JOIN
-- =========================================================
-- Definition:
-- Returns rows from the LEFT table that do NOT have
-- a matching row in the RIGHT table.
--
-- Meaning:
-- Retrieve all customers who have not placed any orders.
--
-- Explanation:
-- 1. LEFT JOIN keeps all customers.
-- 2. Customers without matching orders get NULL values
--    in order-related columns.
-- 3. WHERE o.customer_id IS NULL filters only unmatched rows.
SELECT *
FROM customers AS c
LEFT JOIN orders AS o
ON c.id = o.customer_id
WHERE o.customer_id IS NULL;


-- =========================================================
-- RIGHT ANTI JOIN
-- =========================================================
-- Definition:
-- Returns rows from the RIGHT table that do NOT have
-- a matching row in the LEFT table.
--
-- Meaning:
-- Retrieve orders that do not have a matching customer.
--
-- Possible scenario:
-- An order exists with a customer_id that is missing
-- from the customers table.
SELECT *
FROM customers AS c
RIGHT JOIN orders AS o
ON c.id = o.customer_id
WHERE c.id IS NULL;


-- =========================================================
-- FULL ANTI JOIN
-- =========================================================
-- Definition:
-- Returns all non-matching rows from both tables.
--
-- Meaning:
-- 1. Customers without orders
-- 2. Orders without valid customers
--
-- Explanation:
-- FULL JOIN returns all rows from both tables.
-- The WHERE clause filters only unmatched records.
SELECT *
FROM orders AS o
FULL JOIN customers AS c
ON o.customer_id = c.id
WHERE o.customer_id IS NULL
   OR c.id IS NULL;


-- =========================================================
-- FIND MATCHING RECORDS WITHOUT INNER JOIN
-- =========================================================
-- Retrieve customers who have placed orders
-- without directly using INNER JOIN.
--
-- Logic:
-- 1. LEFT JOIN keeps all customers.
-- 2. Matching orders contain non-NULL customer_id values.
-- 3. WHERE condition removes customers without orders.
--
-- Result:
-- Similar to INNER JOIN behavior.
SELECT *
FROM customers AS c
LEFT JOIN orders AS o
ON c.id = o.customer_id
WHERE o.customer_id IS NOT NULL;


-- =========================================================
-- CROSS JOIN
-- =========================================================
-- Definition:
-- CROSS JOIN returns every possible combination
-- of rows between two tables.
--
-- Formula:
-- Total rows = rows in first table × rows in second table
--
-- Example:
-- If customers has 5 rows
-- and orders has 4 rows,
-- result will contain 20 rows.
--
-- Important:
-- CROSS JOIN does NOT require a matching condition.
--
-- Real-world use cases:
-- 1. Generating all possible combinations
--    (sizes, colors, products, schedules, etc.)
-- 2. Creating test/sample data
-- 3. Calendar and reporting systems
-- 4. Matrix-style comparisons
--
-- Warning:
-- CROSS JOIN can create very large result sets,
-- so it should be used carefully on large tables.
SELECT *
FROM customers
CROSS JOIN orders;