-- =========================================================
-- WINDOW VALUE FUNCTIONS (ANALYTICAL FUNCTIONS)
-- =========================================================
-- Value functions retrieve data from another row
-- within the same window partition.
--
-- Unlike aggregate window functions, these functions
-- do not summarize data. Instead, they allow you to
-- access values from previous, next, first, or last rows.
--
-- Common Value Functions:
-- • LEAD()
-- • LAG()
-- • FIRST_VALUE()
-- • LAST_VALUE()
--
-- Common Use Cases:
-- • Time Series Analysis
-- • Month-over-Month (MoM) Analysis
-- • Year-over-Year (YoY) Analysis
-- • Customer Retention Analysis
-- • Trend Analysis
-- • Gap Analysis
-- • Benchmark Comparisons


-- =========================================================
-- LEAD() / LAG()
-- =========================================================
-- LEAD() accesses data from a future row.
-- LAG() accesses data from a previous row.
--
-- Syntax:
--
-- LEAD(
--      expression,
--      offset,
--      default_value
-- ) OVER (
--      PARTITION BY column
--      ORDER BY column
-- )
--
-- Example:
--
-- LEAD(sales, 2, 10)
-- OVER (
--      PARTITION BY productid
--      ORDER BY orderdate
-- )
--
-- Meaning:
-- • sales      -> value to retrieve (required)
-- • 2          -> move forward 2 rows
-- • 10         -> return 10 if row does not exist
--
--
-- Rules:
--
-- 1. ORDER BY is usually required because the concept
--    of previous/next row depends on row ordering.
--
-- 2. PARTITION BY is optional.
--
-- 3. Offset defaults to 1 if omitted.
--
-- 4. Default value is NULL if omitted.
--
-- 5. Frame clauses are not supported.


-- =========================================================
-- MONTH-OVER-MONTH (MoM) ANALYSIS
-- =========================================================
-- Analyze monthly sales performance by comparing
-- each month's sales with the previous month.
--
-- Formula:
--
-- (Current Month Sales - Previous Month Sales)
-- -------------------------------------------- × 100
-- Previous Month Sales
SELECT
    *,
    
    current_month_sales - previous_month_sales
    AS mom_change,

    ROUND(
        (
            current_month_sales - previous_month_sales
        ) * 100.0
        / NULLIF(previous_month_sales, 0),
        2
    ) AS mom_percentage_change

FROM (
    SELECT
        DATE_TRUNC('month', orderdate) AS month,

        SUM(sales) AS current_month_sales,

        LAG(SUM(sales)) OVER (
            ORDER BY DATE_TRUNC('month', orderdate)
        ) AS previous_month_sales

    FROM sales.orders

    GROUP BY month
) t;


-- =========================================================
-- CUSTOMER RETENTION ANALYSIS
-- =========================================================
-- Analyze customer loyalty by measuring the average
-- number of days between orders.
--
-- Customers with shorter gaps between orders
-- generally place orders more frequently.
SELECT
    customerid,

    AVG(days_until_next_order)::integer
    AS avg_days_between_orders,

    RANK() OVER (
        ORDER BY ROUND(
            AVG(days_until_next_order),
            0
        )
    ) AS customer_rank

FROM (
    SELECT
        orderid,
        customerid,

        orderdate AS current_order,

        LEAD(orderdate) OVER (
            PARTITION BY customerid
            ORDER BY orderdate
        ) AS next_order,

        LEAD(orderdate) OVER (
            PARTITION BY customerid
            ORDER BY orderdate
        ) - orderdate
        AS days_until_next_order

    FROM sales.orders
) t

GROUP BY customerid;


-- =========================================================
-- FIRST_VALUE()
-- =========================================================
-- Returns the first value in the window.
--
-- Usually used with ORDER BY to define
-- what "first" means.
--
--
-- LAST_VALUE()
-- =========================================================
-- Returns the last value in the window.
--
-- Important:
-- LAST_VALUE() is one of the most commonly
-- misunderstood window functions.
--
-- By default, LAST_VALUE() only sees rows
-- up to the current row.
--
-- Therefore, to retrieve the true last value
-- in the partition, a frame clause is usually
-- required.
--
-- Correct Frame:
--
-- ROWS BETWEEN CURRENT ROW
-- AND UNBOUNDED FOLLOWING


-- =========================================================
-- FIND LOWEST AND HIGHEST SALES PER PRODUCT
-- =========================================================
SELECT
    orderid,
    productid,
    sales,

    FIRST_VALUE(sales) OVER (
        PARTITION BY productid
        ORDER BY sales
    ) AS lowest_sales,

    LAST_VALUE(sales) OVER (
        PARTITION BY productid
        ORDER BY sales
        ROWS BETWEEN CURRENT ROW
        AND UNBOUNDED FOLLOWING
    ) AS highest_sales,

    -- Alternative approach
    FIRST_VALUE(sales) OVER (
        PARTITION BY productid
        ORDER BY sales DESC
    ) AS highest_sales_alternative,

    -- Aggregate window function approach
    MIN(sales) OVER (
        PARTITION BY productid
    ) AS minimum_sales,

    MAX(sales) OVER (
        PARTITION BY productid
    ) AS maximum_sales

FROM sales.orders;


-- =========================================================
-- SALES DIFFERENCE ANALYSIS
-- =========================================================
-- Compare each order's sales against
-- the lowest sales value for that product.
SELECT
    orderid,
    productid,
    sales,

    FIRST_VALUE(sales) OVER (
        PARTITION BY productid
        ORDER BY sales
    ) AS lowest_sales,

    LAST_VALUE(sales) OVER (
        PARTITION BY productid
        ORDER BY sales
        ROWS BETWEEN CURRENT ROW
        AND UNBOUNDED FOLLOWING
    ) AS highest_sales,

    sales
    - FIRST_VALUE(sales) OVER (
        PARTITION BY productid
        ORDER BY sales
    ) AS sales_difference

FROM sales.orders;


-- =========================================================
-- WHEN TO USE WHICH VALUE FUNCTION?
-- =========================================================
--
-- LAG()
-- • Previous month sales
-- • Previous transaction
-- • Trend analysis
-- • Growth calculations
--
--
-- LEAD()
-- • Next order date
-- • Future event analysis
-- • Gap calculations
-- • Retention analysis
--
--
-- FIRST_VALUE()
-- • Lowest value
-- • Earliest value
-- • Baseline comparison
-- • Starting point analysis
--
--
-- LAST_VALUE()
-- • Highest value
-- • Latest value
-- • Ending point analysis
-- • Current vs Final comparison