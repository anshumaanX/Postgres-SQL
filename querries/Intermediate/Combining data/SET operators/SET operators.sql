-- =========================================================
-- SQL SET OPERATORS
-- Database: PostgreSQL
-- Description:
-- Set operators are used to combine the results of
-- two or more SELECT queries into a single result set.
--
-- Common Set Operators:
-- 1. UNION
-- 2. UNION ALL
-- 3. EXCEPT
-- 4. INTERSECT
-- =========================================================


-- =========================================================
-- RULES FOR SET OPERATORS
-- =========================================================

-- Rule 1:
-- Set operators can be used with queries containing:
-- WHERE, JOIN, GROUP BY, and HAVING clauses.
--
-- However, ORDER BY can only be used once,
-- at the end of the final query.

-- Example:
-- Valid usage of ORDER BY at the end
SELECT
    firstname,
    lastname
FROM sales.customers
WHERE country = 'USA'

UNION

SELECT
    firstname,
    lastname
FROM sales.employees

ORDER BY firstname;


-- ---------------------------------------------------------

-- Rule 2:
-- The number of columns in each SELECT query must be the same.

-- Correct Example:
SELECT firstname, lastname
FROM sales.customers

UNION

SELECT firstname, lastname
FROM sales.employees;

-- Incorrect Example:
-- This will produce an error because the column count differs
/*
SELECT firstname
FROM sales.customers

UNION

SELECT firstname, lastname
FROM sales.employees;
*/


-- ---------------------------------------------------------

-- Rule 3:
-- The data types of corresponding columns must be compatible.

-- Correct Example:
-- Both queries return VARCHAR columns
SELECT firstname
FROM sales.customers

UNION

SELECT lastname
FROM sales.employees;

-- Incorrect Example:
-- Mixing incompatible data types may produce errors
/*
SELECT firstname
FROM sales.customers

UNION

SELECT salary
FROM sales.employees;
*/


-- ---------------------------------------------------------

-- Rule 4:
-- The order of columns must match logically.

-- Correct Example:
SELECT firstname, lastname
FROM sales.customers

UNION

SELECT firstname, lastname
FROM sales.employees;

-- Incorrect Example:
-- Query runs successfully but results become misleading
-- because column meanings are mismatched
/*
SELECT firstname, lastname
FROM sales.customers

UNION

SELECT lastname, firstname
FROM sales.employees;
*/


-- ---------------------------------------------------------

-- Rule 5:
-- Column names in the final result set are determined
-- by the first SELECT query.

SELECT
    firstname AS first_name,
    lastname AS last_name
FROM sales.customers

UNION

SELECT
    firstname,
    lastname
FROM sales.employees;


-- ---------------------------------------------------------

-- Rule 6:
-- Even if SQL syntax is valid, incorrect column selection
-- may still produce inaccurate or misleading results.
--
-- Always ensure:
-- 1. Correct column meaning
-- 2. Correct column order
-- 3. Compatible business logic


-- =========================================================
-- UNION
-- =========================================================
-- Definition:
-- Combines results from multiple queries
-- and removes duplicate rows.
--
-- Meaning:
-- Only unique records appear in the final result.
--
-- Combine employee and customer names into one result set
SELECT
    firstname,
    lastname
FROM sales.employees

UNION

SELECT
    firstname,
    lastname
FROM sales.customers;


-- =========================================================
-- UNION ALL
-- =========================================================
-- Definition:
-- Combines results from multiple queries
-- including duplicate rows.
--
-- Difference from UNION:
-- UNION removes duplicates
-- UNION ALL keeps duplicates
--
-- UNION ALL is generally faster because no duplicate
-- checking is performed.
SELECT
    firstname,
    lastname
FROM sales.employees

UNION ALL

SELECT
    firstname,
    lastname
FROM sales.customers;


-- =========================================================
-- EXCEPT
-- =========================================================
-- Definition:
-- Returns rows from the first query
-- that are NOT present in the second query.
--
-- Important:
-- Query order matters in EXCEPT.
--
-- Meaning:
-- Retrieve employees who are not customers.
SELECT
    firstname,
    lastname
FROM sales.employees

EXCEPT

SELECT
    firstname,
    lastname
FROM sales.customers;


-- =========================================================
-- INTERSECT
-- =========================================================
-- Definition:
-- Returns only rows that exist in both queries.
--
-- Meaning:
-- Retrieve people who are both employees and customers.
SELECT
    firstname,
    lastname
FROM sales.employees

INTERSECT

SELECT
    firstname,
    lastname
FROM sales.customers;


-- =========================================================
-- REAL-WORLD EXAMPLE
-- =========================================================
-- Scenario:
-- Orders are stored in two separate tables:
-- 1. orders
-- 2. ordersArchive
--
-- Objective:
-- Combine both tables into a single report
-- without duplicate rows.
--
-- Why avoid using SELECT * ?
-- 1. Explicit columns improve readability.
-- 2. Safer if table structures change later.
-- 3. Prevents unexpected column order issues.
-- 4. Better practice for production queries.
SELECT
    'Orders' AS source_table,
    orderid,
    productid,
    customerid,
    salespersonid,
    orderdate,
    shipdate,
    orderstatus,
    shipaddress,
    billaddress,
    quantity,
    sales,
    creationtime
FROM sales.orders

UNION

SELECT
    'OrdersArchive' AS source_table,
    orderid,
    productid,
    customerid,
    salespersonid,
    orderdate,
    shipdate,
    orderstatus,
    shipaddress,
    billaddress,
    quantity,
    sales,
    creationtime
FROM sales.ordersArchive

ORDER BY orderid;


-- =========================================================
-- COMMON USE CASES OF EXCEPT
-- =========================================================

-- 1. Delta Detection
-- Identify differences between two datasets
-- or batches of data.

-- Example:
-- Find new customers added in latest dataset.


-- 2. Data Completeness Check
-- Compare tables across systems/databases
-- to detect missing or inconsistent records.

-- Example:
-- Compare production and backup tables
-- to ensure all records exist.