-- =========================================================
-- WINDOW AGGREGATE FUNCTIONS
-- =========================================================
-- Window aggregate functions combine the power of:
-- 1. Aggregate Functions (COUNT, SUM, AVG, MIN, MAX)
-- 2. Window Functions (OVER)
--
-- Unlike GROUP BY, window aggregates preserve the
-- original row-level detail while performing calculations.
--
-- General Syntax:
--
-- aggregate_function(column)
-- OVER (
--      PARTITION BY column
--      ORDER BY column
-- )
--
-- Example:
--
-- AVG(sales)
-- OVER (
--      PARTITION BY productid
--      ORDER BY sales
-- )
--
-- Notes:
-- 1. Aggregate column must be a valid numeric column
--    for SUM() and AVG().
-- 2. PARTITION BY is optional.
-- 3. ORDER BY is optional.
-- 4. Frame clauses become available when ORDER BY is used.


-- =========================================================
-- COUNT()
-- =========================================================
-- COUNT is commonly used for:
-- 1. Overall row counts
-- 2. Counts per category/group
-- 3. Duplicate detection
-- 4. Data quality checks
-- 5. NULL analysis


-- Find:
-- 1. Total number of orders
-- 2. Total number of orders for each customer
-- while preserving order details.
SELECT
    orderid,
    orderdate,
    customerid,

    COUNT(*) OVER () AS total_orders,

    COUNT(*) OVER (
        PARTITION BY customerid
    ) AS total_orders_by_customer

FROM sales.orders;


-- Find the total number of customers
-- while displaying all customer details.
SELECT
    *,

    COUNT(*) OVER () AS total_customers

FROM sales.customers;


-- COUNT(*) vs COUNT(column)
--
-- COUNT(*)       -> Counts all rows
-- COUNT(column)  -> Counts only non-NULL values
SELECT
    customerid,
    score,

    COUNT(*) OVER () AS total_customer_rows,

    COUNT(score) OVER ()
    AS total_number_of_scores,

    COUNT(country) OVER ()
    AS total_countries

FROM sales.customers;


-- =========================================================
-- DUPLICATE CHECKING
-- =========================================================
-- Verify whether the primary key contains duplicates.
--
-- If check_pk > 1, duplicates exist.
SELECT
    *,

    COUNT(*) OVER (
        PARTITION BY orderid
    ) AS check_pk

FROM sales.orders;


-- Duplicate detection in archived orders.
SELECT
    *
FROM (
    SELECT
        orderid,

        COUNT(*) OVER (
            PARTITION BY orderid
        ) AS check_pk

    FROM sales.ordersarchive
) t

WHERE check_pk > 1;


-- =========================================================
-- SUM()
-- =========================================================
-- SUM is commonly used for:
-- 1. Overall totals
-- 2. Category totals
-- 3. Running totals
-- 4. Rolling totals


-- Find:
-- 1. Total sales across all orders
-- 2. Total sales for each product
-- while preserving order details.
SELECT
    orderid,
    orderdate,
    sales,
    productid,

    SUM(sales) OVER ()
    AS total_sales,

    SUM(sales) OVER (
        PARTITION BY productid
    ) AS sales_by_product

FROM sales.orders;


-- =========================================================
-- COMPARISON USE CASE
-- =========================================================
-- Find each order's contribution
-- to the overall sales.
SELECT
    orderid,
    productid,
    sales,

    SUM(sales) OVER ()
    AS total_sales,

    ROUND(
        sales::numeric
        / SUM(sales) OVER ()
        * 100,
        2
    ) AS percentage_contribution

FROM sales.orders;


-- =========================================================
-- AVG()
-- =========================================================
-- Find:
-- 1. Average sales across all orders
-- 2. Average sales for each product
-- while preserving order details.
SELECT
    orderid,
    orderdate,
    productid,
    sales,

    ROUND(
        AVG(sales) OVER (
            PARTITION BY productid
        ),
        2
    ) AS avg_sales_per_product,

    ROUND(
        AVG(sales) OVER (),
        2
    ) AS avg_sales

FROM sales.orders;


-- Find all orders with sales
-- above the overall average sales.
--
-- Window functions execute after WHERE,
-- therefore a subquery is required.
SELECT
    *
FROM (
    SELECT
        orderid,
        productid,
        sales,

        ROUND(
            AVG(sales) OVER (),
            2
        ) AS avg_sales

    FROM sales.orders
) t

WHERE sales > avg_sales;


-- =========================================================
-- MIN() / MAX()
-- =========================================================
-- Find:
-- 1. Highest and lowest sales overall
-- 2. Highest and lowest sales per product
-- while preserving order details.
SELECT
    orderid,
    orderdate,
    productid,
    sales,

    MAX(sales) OVER ()
    AS max_sales,

    MIN(sales) OVER ()
    AS min_sales,

    MAX(sales) OVER (
        PARTITION BY productid
    ) AS max_sales_by_product,

    MIN(sales) OVER (
        PARTITION BY productid
    ) AS min_sales_by_product

FROM sales.orders;


-- Show employees earning
-- the highest salary.
SELECT
    *
FROM (
    SELECT
        *,

        MAX(salary) OVER ()
        AS highest_salary

    FROM sales.employees
) t

WHERE salary = highest_salary;


-- =========================================================
-- DEVIATION ANALYSIS
-- =========================================================
-- Compare each order's sales
-- against the minimum and maximum sales.
SELECT
    orderid,
    productid,
    sales,

    MAX(sales) OVER ()
    AS max_sales,

    MIN(sales) OVER ()
    AS min_sales,

    sales - MIN(sales) OVER ()
    AS minimum_deviation,

    MAX(sales) OVER () - sales
    AS maximum_deviation

FROM sales.orders;


-- =========================================================
-- RUNNING AVERAGE
-- =========================================================
-- Running calculations are among the most common
-- analytical use cases for window functions.
--
-- Running Average:
-- Includes all previous rows up to
-- the current row.
SELECT
    orderid,
    customerid,
    orderdate,
    productid,
    sales,

    ROUND(
        AVG(sales) OVER (
            PARTITION BY productid
            ORDER BY orderdate
        ),
        2
    ) AS moving_avg

FROM sales.orders;


-- =========================================================
-- ROLLING AVERAGE
-- =========================================================
-- Rolling calculations use a fixed-size window.
--
-- Example:
-- Current row + next row.
SELECT
    orderid,
    customerid,
    orderdate,
    productid,
    sales,

    ROUND(
        AVG(sales) OVER (
            PARTITION BY productid
            ORDER BY orderdate
        ),
        2
    ) AS moving_avg,

    ROUND(
        AVG(sales) OVER (
            PARTITION BY productid
            ORDER BY orderdate
            ROWS BETWEEN CURRENT ROW
            AND 1 FOLLOWING
        ),
        2
    ) AS rolling_avg

FROM sales.orders;


-- =========================================================
-- COMMON USE CASES OF WINDOW AGGREGATES
-- =========================================================
-- COUNT()
-- • Overall row counts
-- • Group counts
-- • Duplicate detection
-- • NULL analysis
--
-- SUM()
-- • Overall totals
-- • Totals per group
-- • Running totals
-- • Rolling totals
-- • Percentage contribution analysis
--
-- AVG()
-- • Overall averages
-- • Group averages
-- • Running averages
-- • Rolling averages
-- • Benchmark comparisons
--
-- MIN() / MAX()
-- • Best/Worst value analysis
-- • Deviation analysis
-- • Range calculations
-- • Threshold comparisons
--
-- Business Analytics Examples:
-- • Sales trend analysis
-- • Customer behavior analysis
-- • Product performance analysis
-- • KPI reporting
-- • Dashboard metrics
-- • Data quality checks