-- =========================================================
-- RANKING WINDOW FUNCTIONS
-- =========================================================
-- Ranking functions assign an integer rank or sequence
-- number to rows based on a specified ordering.
--
-- Common Ranking Functions:
-- 1. ROW_NUMBER()
-- 2. RANK()
-- 3. DENSE_RANK()
-- 4. NTILE()
--
-- These functions are frequently used for:
-- • Top-N Analysis
-- • Bottom-N Analysis
-- • Leaderboards
-- • Deduplication
-- • Data Segmentation
-- • Workload Distribution
--
--
-- Example Data:
--
-- Sales
-- -----
-- 100
-- 100
-- 90
--
-- ROW_NUMBER()  -> 1, 2, 3
-- RANK()        -> 1, 1, 3
-- DENSE_RANK() -> 1, 1, 2
--
-- Key Difference:
-- ROW_NUMBER()  : Always unique
-- RANK()        : Handles ties but leaves gaps
-- DENSE_RANK()  : Handles ties without gaps


-- =========================================================
-- ROW_NUMBER()
-- =========================================================
-- Assigns a unique sequential number to every row.
--
-- Important:
-- ROW_NUMBER() does NOT handle ties.
--
-- If two rows have the same sales value,
-- they still receive different row numbers.
--
-- Example:
--
-- Sales
-- -----
-- 100
-- 100
-- 90
--
-- ROW_NUMBER()
-- ------------
-- 1
-- 2
-- 3
--
-- Rank orders by sales from highest to lowest.
SELECT
    orderid,
    productid,
    sales,

    ROW_NUMBER() OVER (
        ORDER BY sales DESC
    ) AS sales_rank_row

FROM sales.orders;


-- =========================================================
-- RANK()
-- =========================================================
-- RANK() assigns the same rank to tied values.
--
-- Unlike ROW_NUMBER(), ties receive
-- the same rank.
--
-- Important:
-- RANK() leaves gaps after ties.
--
-- Example:
--
-- Sales
-- -----
-- 100
-- 100
-- 90
--
-- RANK()
-- ------
-- 1
-- 1
-- 3
--
-- Notice rank 2 is skipped.
SELECT
    orderid,
    productid,
    sales,

    ROW_NUMBER() OVER (
        ORDER BY sales DESC
    ) AS sales_rank_row,

    RANK() OVER (
        ORDER BY sales DESC
    ) AS sales_rank

FROM sales.orders;


-- =========================================================
-- DENSE_RANK()
-- =========================================================
-- Similar to RANK().
--
-- Tied values receive the same rank.
--
-- Difference:
-- DENSE_RANK() does NOT leave gaps.
--
-- Example:
--
-- Sales
-- -----
-- 100
-- 100
-- 90
--
-- DENSE_RANK()
-- ------------
-- 1
-- 1
-- 2
SELECT
    orderid,
    productid,
    sales,

    ROW_NUMBER() OVER (
        ORDER BY sales DESC
    ) AS sales_rank_row,

    RANK() OVER (
        ORDER BY sales DESC
    ) AS sales_rank,

    DENSE_RANK() OVER (
        ORDER BY sales DESC
    ) AS sales_rank_dense

FROM sales.orders;


-- =========================================================
-- TOP-N ANALYSIS
-- =========================================================
-- One of the most common ranking use cases.
--
-- Find the highest sales order for each product.
--
-- ROW_NUMBER() guarantees exactly one row
-- per product.
SELECT
    *
FROM (
    SELECT
        orderid,
        productid,
        sales,

        ROW_NUMBER() OVER (
            PARTITION BY productid
            ORDER BY sales DESC
        ) AS product_rank

    FROM sales.orders
) t

WHERE product_rank = 1;


-- =========================================================
-- BOTTOM-N ANALYSIS
-- =========================================================
-- Find the two customers with the lowest
-- total sales.
--
-- Note:
-- Ranking happens after GROUP BY because
-- the ranking is based on aggregated sales.
SELECT *
FROM (
    SELECT
        customerid,
        SUM(sales) AS total_sales,
        ROW_NUMBER() OVER (ORDER BY SUM(sales)) AS customer_rank
    FROM sales.orders
    GROUP BY customerid
) t
WHERE customer_rank <= 2;


-- =========================================================
-- GENERATING UNIQUE IDS
-- =========================================================
-- Assign sequential IDs to result rows.
--
-- Useful for:
-- • Reporting
-- • Exporting data
-- • Temporary identifiers
--
-- Note:
-- ROW_NUMBER() does NOT permanently modify
-- the table.
SELECT
    ROW_NUMBER() OVER (
        ORDER BY orderid, orderdate
    ) AS unique_id,

    *

FROM sales.ordersarchive;


-- =========================================================
-- IDENTIFYING DUPLICATES
-- =========================================================
-- Keep only the most recent record
-- for each order.
--
-- Logic:
-- rn = 1 keeps the newest row.
--
-- rn > 1 identifies duplicates.
SELECT
    *
FROM (
    SELECT
        ROW_NUMBER() OVER (
            PARTITION BY orderid
            ORDER BY creationtime DESC
        ) AS rn,

        *

    FROM sales.ordersarchive
) t

WHERE rn = 1;


-- =========================================================
-- NTILE()
-- =========================================================
-- NTILE divides rows into a specified number
-- of approximately equal buckets.
--
-- Syntax:
--
-- NTILE(number_of_buckets)
-- OVER (...)
--
-- Formula:
--
-- Approximate Bucket Size =
-- Total Rows / Number Of Buckets
--
-- If rows cannot be divided evenly,
-- larger buckets are assigned first.
--
-- Example:
--
-- 10 Rows
-- NTILE(3)
--
-- Bucket 1 -> 4 rows
-- Bucket 2 -> 3 rows
-- Bucket 3 -> 3 rows
SELECT
    orderid,
    sales,

    NTILE(1) OVER (
        ORDER BY sales DESC
    ) AS one_bucket,

    NTILE(2) OVER (
        ORDER BY sales DESC
    ) AS two_buckets,

    NTILE(3) OVER (
        ORDER BY sales DESC
    ) AS three_buckets,

    NTILE(4) OVER (
        ORDER BY sales DESC
    ) AS four_buckets

FROM sales.orders;


-- =========================================================
-- NTILE USE CASE: DATA SEGMENTATION
-- =========================================================
-- Segment orders into:
-- High Sales
-- Medium Sales
-- Low Sales
--
-- NTILE(3) creates three approximately
-- equal-sized groups.
SELECT
    *,

    CASE
        WHEN category_bucket = 1 THEN 'High'
        WHEN category_bucket = 2 THEN 'Medium'
        ELSE 'Low'
    END AS category

FROM (
    SELECT
        orderid,
        sales,

        NTILE(3) OVER (
            ORDER BY sales DESC
        ) AS category_bucket

    FROM sales.orders
) t;


-- =========================================================
-- NTILE USE CASE: LOAD DISTRIBUTION
-- =========================================================
-- Divide orders into two groups.
--
-- Useful for:
-- • Parallel processing
-- • Data exports
-- • Batch jobs
-- • Workload balancing
SELECT
    NTILE(2) OVER (
        ORDER BY orderid
    ) AS table_segment,

    *

FROM sales.orders;


-- =========================================================
-- WHEN TO USE WHICH RANKING FUNCTION?
-- =========================================================
--
-- ROW_NUMBER()
-- • Need unique ranking
-- • Deduplication
-- • Top 1 per group
-- • Generate sequential IDs
--
--
-- RANK()
-- • Leaderboards
-- • Competition rankings
-- • Ties should share the same rank
-- • Rank gaps are acceptable
--
--
-- DENSE_RANK()
-- • Ranking categories
-- • Ranking products
-- • Ties should share the same rank
-- • No rank gaps wanted
--
--
-- NTILE()
-- • Data segmentation
-- • Percentile-style grouping
-- • Workload balancing
-- • Customer/Product categorization