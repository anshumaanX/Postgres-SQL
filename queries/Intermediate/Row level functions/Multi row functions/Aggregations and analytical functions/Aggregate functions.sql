-- =========================================================
-- AGGREGATE FUNCTIONS
-- =========================================================
-- Aggregate functions perform calculations on multiple
-- rows and return a single summarized result.
--
-- Common Aggregate Functions:
-- COUNT() -> Counts rows
-- SUM()   -> Calculates total
-- AVG()   -> Calculates average
-- MAX()   -> Returns highest value
-- MIN()   -> Returns lowest value
--
-- Important:
-- Aggregate functions ignore NULL values
-- except COUNT(*), which counts every row.
--
-- Example:
-- Values: 10, 20, NULL
--
-- COUNT(*)      = 3
-- COUNT(column) = 2
-- SUM(column)   = 30
-- AVG(column)   = 15
--
-- These functions are frequently used in reporting,
-- dashboards, analytics, and business intelligence.


-- =========================================================
-- AGGREGATE SUMMARY REPORT
-- =========================================================
-- Generate a summary report containing:
-- 1. Total number of orders
-- 2. Total sales amount
-- 3. Average sales amount
-- 4. Highest sales value
-- 5. Lowest sales value
SELECT
    COUNT(*) AS total_orders,

    SUM(sales) AS total_sales,

    AVG(sales) AS avg_sales,

    MAX(sales) AS highest_sales,

    MIN(sales) AS lowest_sales

FROM orders;