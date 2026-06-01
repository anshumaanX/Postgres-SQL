-- =========================================================
-- WINDOW FUNCTIONS (BASICS)
-- =========================================================
-- Window functions perform calculations across a set of
-- rows while preserving the original row-level detail.
--
-- Unlike GROUP BY, window functions do NOT collapse rows.
--
-- Think of it this way:
--
-- GROUP BY:
-- Many rows -> One summarized row
--
-- WINDOW FUNCTION:
-- Many rows -> Many rows (with additional calculations)
--
--
-- Example:
--
-- Orders Table
--
-- orderid | productid | sales
-- --------+-----------+------
-- 1       | 101       | 100
-- 2       | 101       | 200
-- 3       | 102       | 300
--
-- GROUP BY productid:
--
-- productid | total_sales
-- ----------+------------
-- 101       | 300
-- 102       | 300
--
-- Window Function:
--
-- orderid | productid | sales | total_sales
-- --------+-----------+-------+------------
-- 1       | 101       | 100   | 300
-- 2       | 101       | 200   | 300
-- 3       | 102       | 300   | 300
--
-- Notice:
-- Window functions preserve row-level granularity
-- while adding aggregated information.


-- =========================================================
-- AGGREGATE VS WINDOW FUNCTION
-- =========================================================

-- Total sales across all orders
-- Returns a single row
SELECT
    SUM(sales) AS total_sales
FROM sales.orders;


-- Total sales for each product
-- GROUP BY reduces the result to one row per product
SELECT
    productid,
    SUM(sales) AS total_sales
FROM sales.orders
GROUP BY productid;


-- Total sales for each product
-- while keeping order-level details
SELECT
    orderid,
    productid,
    orderdate,

    SUM(sales) OVER (
        PARTITION BY productid
    ) AS total_sales

FROM sales.orders;


-- =========================================================
-- WINDOW FUNCTION SYNTAX
-- =========================================================
-- function() OVER (
--      PARTITION BY column
--      ORDER BY column
--      frame_clause
-- )
--
-- Components:
--
-- PARTITION BY
-- Splits data into groups.
--
-- ORDER BY
-- Defines the order of rows within each partition.
--
-- FRAME CLAUSE
-- Defines which rows participate in the calculation.
--
--
-- Example:
--
-- AVG(sales) OVER (
--      PARTITION BY category
--      ORDER BY orderdate
--      ROWS UNBOUNDED PRECEDING
-- )
--
-- Meaning:
-- Calculate a running average of sales
-- from the first row in the partition
-- up to the current row.


-- =========================================================
-- WINDOW WITHOUT PARTITION
-- =========================================================
-- Calculate total sales across all orders
-- while keeping order details.
SELECT
    orderid,
    orderdate,
    sales,

    SUM(sales) OVER () AS total_sales

FROM sales.orders;


-- =========================================================
-- PARTITION BY
-- =========================================================
-- Calculate total sales for each product
-- while keeping order details.
SELECT
    orderid,
    orderdate,
    productid,
    sales,

    SUM(sales) OVER (
        PARTITION BY productid
    ) AS total_sales_per_product

FROM sales.orders;


-- =========================================================
-- MULTIPLE PARTITIONS
-- =========================================================
-- Calculate:
-- 1. Total sales across all orders
-- 2. Total sales per product
-- 3. Total sales per product and order status
SELECT
    orderid,
    orderdate,
    productid,
    sales,
    orderstatus,

    SUM(sales) OVER (
        PARTITION BY productid
    ) AS total_sales_per_product,

    SUM(sales) OVER (
        PARTITION BY productid, orderstatus
    ) AS sales_by_product_and_status,

    SUM(sales) OVER () AS total_sales

FROM sales.orders;


-- =========================================================
-- RANK FUNCTION
-- =========================================================
-- Assign a rank based on sales.
--
-- Highest sales receives Rank 1.
--
-- If values tie, they receive the same rank.
--
-- Example:
-- Sales: 100, 100, 90
--
-- RANK:
-- 1, 1, 3
SELECT
    orderid,
    orderdate,
    productid,
    sales,

    RANK() OVER (
        ORDER BY sales DESC
    ) AS sales_rank

FROM sales.orders;


-- =========================================================
-- FRAME CLAUSE
-- =========================================================
-- Frame clause controls which rows are included
-- in the window calculation.
--
-- Rule 1:
-- Frame clause requires ORDER BY.
--
-- Rule 2:
-- The starting boundary must come before
-- the ending boundary.
--
-- Common Keywords:
--
-- CURRENT ROW
-- Current row only
--
-- n PRECEDING
-- n rows before current row
--
-- n FOLLOWING
-- n rows after current row
--
-- UNBOUNDED PRECEDING
-- First row of partition
--
-- UNBOUNDED FOLLOWING
-- Last row of partition


-- =========================================================
-- CURRENT ROW TO 2 FOLLOWING
-- =========================================================
-- Current row + next 2 rows
SELECT
    orderid,
    orderdate,
    orderstatus,
    sales,

    SUM(sales) OVER (
        PARTITION BY orderstatus
        ORDER BY orderdate
        ROWS BETWEEN CURRENT ROW
        AND 2 FOLLOWING
    ) AS total_sales

FROM sales.orders;


-- =========================================================
-- 2 PRECEDING TO CURRENT ROW
-- =========================================================
-- Previous 2 rows + current row
SELECT
    orderid,
    orderdate,
    orderstatus,
    sales,

    SUM(sales) OVER (
        PARTITION BY orderstatus
        ORDER BY orderdate
        ROWS BETWEEN 2 PRECEDING
        AND CURRENT ROW
    ) AS total_sales

FROM sales.orders;


-- =========================================================
-- SHORTCUT SYNTAX
-- =========================================================
-- Equivalent to:
--
-- ROWS BETWEEN 2 PRECEDING
-- AND CURRENT ROW
SELECT
    orderid,
    orderdate,
    orderstatus,
    sales,

    SUM(sales) OVER (
        PARTITION BY orderstatus
        ORDER BY orderdate
        ROWS 2 PRECEDING
    ) AS total_sales

FROM sales.orders;


-- =========================================================
-- OTHER COMMON FRAME EXAMPLES
-- =========================================================

-- Running Total
SELECT
    orderid,
    sales,

    SUM(sales) OVER (
        ORDER BY orderdate
        ROWS UNBOUNDED PRECEDING
    ) AS running_total

FROM sales.orders;


-- Current Row Only
SELECT
    orderid,
    sales,

    SUM(sales) OVER (
        ORDER BY orderdate
        ROWS BETWEEN CURRENT ROW
        AND CURRENT ROW
    ) AS current_row_sales

FROM sales.orders;


-- Entire Partition
SELECT
    orderid,
    sales,

    SUM(sales) OVER (
        PARTITION BY productid
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND UNBOUNDED FOLLOWING
    ) AS total_product_sales

FROM sales.orders;


-- =========================================================
-- IMPORTANT RULES
-- =========================================================
--
-- Rule 1:
-- Window functions can only be used in:
-- SELECT clause
-- ORDER BY clause
--
-- They cannot be used directly in:
-- WHERE
-- GROUP BY
-- HAVING
--
--
-- Rule 2:
-- Window functions cannot be nested.
--
-- Invalid:
--
-- SUM(
--      RANK() OVER(...)
-- )
--
--
-- Rule 3:
-- SQL executes WHERE before window functions.
--
-- Therefore filtering happens first,
-- then window calculations are performed.


-- =========================================================
-- FILTERED WINDOW CALCULATION
-- =========================================================
-- Find total sales for each order status
-- considering only products 101 and 102.
SELECT
    orderid,
    productid,
    orderdate,
    orderstatus,
    sales,

    SUM(sales) OVER (
        PARTITION BY orderstatus
    ) AS sales_by_status

FROM sales.orders

WHERE productid IN (101, 102);


-- =========================================================
-- WINDOW FUNCTIONS + GROUP BY
-- =========================================================
-- Window functions can be used together with
-- GROUP BY.
--
-- GROUP BY executes first.
-- Window functions execute afterward.
--
-- Rank customers based on their total sales.
SELECT
    customerid,

    SUM(sales) AS total_sales,

    RANK() OVER (
        ORDER BY SUM(sales) DESC
    ) AS sales_rank

FROM sales.orders

GROUP BY customerid;