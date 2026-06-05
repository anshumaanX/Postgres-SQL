-- =========================================================
-- PERCENTAGE-BASED RANKING FUNCTIONS
-- =========================================================
-- Unlike ROW_NUMBER(), RANK(), and DENSE_RANK(),
-- these functions return a value between 0 and 1.
--
-- Common Functions:
-- 1. CUME_DIST()
-- 2. PERCENT_RANK()
--
-- These functions are commonly used for:
-- • Percentile Analysis
-- • Top X% Analysis
-- • Customer Segmentation
-- • Product Segmentation
-- • Benchmarking


-- =========================================================
-- CUME_DIST()
-- =========================================================
-- Cumulative Distribution
--
-- Formula:
--
-- Number of rows with values greater than or equal
-- to the current row
-- -----------------------------------------------
-- Total number of rows
--
-- (When using DESC ordering)
--
-- Returns values between 0 and 1.
--
-- Important:
-- If duplicate values exist, CUME_DIST()
-- uses the position of the LAST occurrence.
--
-- Example:
--
-- Prices (DESC)
-- 100
-- 100
-- 80
-- 60
--
-- Row Position:
-- 1
-- 2
-- 3
-- 4
--
-- CUME_DIST():
-- 2/4 = 0.50
-- 2/4 = 0.50
-- 3/4 = 0.75
-- 4/4 = 1.00
--
-- Find products that belong to the highest
-- 40% of product prices.
SELECT
    *
FROM (
    SELECT
        product,
        price,

        CUME_DIST() OVER (
            ORDER BY price DESC
        ) AS dist_rank

    FROM sales.products
) t

WHERE dist_rank <= 0.40;


-- =========================================================
-- PERCENT_RANK()
-- =========================================================
-- Relative Percentile Ranking
--
-- Formula:
--
-- Rank - 1
-- -------------------
-- Total Rows - 1
--
-- Returns values between 0 and 1.
--
-- Important:
-- If duplicate values exist, PERCENT_RANK()
-- uses the rank of the FIRST occurrence.
--
-- Example:
--
-- Prices (DESC)
-- 100
-- 100
-- 80
-- 60
--
-- RANK():
-- 1
-- 1
-- 3
-- 4
--
-- PERCENT_RANK():
-- (1-1)/(4-1) = 0.00
-- (1-1)/(4-1) = 0.00
-- (3-1)/(4-1) = 0.67
-- (4-1)/(4-1) = 1.00
--
-- Find products that belong to the highest
-- 40% of product prices.
SELECT
    *
FROM (
    SELECT
        product,
        price,

        PERCENT_RANK() OVER (
            ORDER BY price DESC
        ) AS dist_rank

    FROM sales.products
) t

WHERE dist_rank <= 0.40;


-- =========================================================
-- CUME_DIST() vs PERCENT_RANK()
-- =========================================================
--
-- CUME_DIST()
-- • Uses position of last tied row
-- • Measures cumulative distribution
-- • Better for percentile grouping
--
--
-- PERCENT_RANK()
-- • Uses rank of first tied row
-- • Measures relative ranking position
-- • Better for ranking comparisons
--
--
-- Example:
--
-- Values:
-- 100, 100, 80, 60
--
-- CUME_DIST():
-- 0.50, 0.50, 0.75, 1.00
--
-- PERCENT_RANK():
-- 0.00, 0.00, 0.67, 1.00