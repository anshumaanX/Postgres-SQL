-- =========================================================
-- CASE STATEMENT
-- =========================================================
-- CASE is used to apply conditional logic in SQL.
--
-- Main Purpose:
-- Transform data based on one or more conditions.
--
-- Think of CASE as SQL's equivalent of:
-- IF / ELSE IF / ELSE
--
-- CASE statements can be used almost anywhere:
-- 1. SELECT
-- 2. WHERE
-- 3. ORDER BY
-- 4. GROUP BY
-- 5. HAVING
-- 6. Aggregate Functions
--
-- Important Rule:
-- The values returned by THEN and ELSE should be
-- compatible data types.
--
-- Good Example:
-- CASE
--     WHEN score > 50 THEN 'High'
--     ELSE 'Low'
-- END
--
-- Bad Example:
-- CASE
--     WHEN score > 50 THEN 'High'
--     ELSE 0
-- END
--
-- Mixing text and numeric values can cause errors
-- or implicit type conversions.


-- =========================================================
-- USE CASE 1: CATEGORIZING DATA
-- =========================================================
-- Group data into categories based on conditions.
--
-- Generate a report showing total sales by category:
-- High   : Sales > 50
-- Medium : Sales between 21 and 50
-- Low    : Sales <= 20
--
-- Note:
-- The subquery is used to create the category first.
-- Subqueries will be covered in detail later.
SELECT
    category,
    SUM(sales) AS total_sales
FROM (
    SELECT
        orderid,
        sales,

        CASE
            WHEN sales > 50 THEN 'High'
            WHEN sales > 20 THEN 'Medium'
            ELSE 'Low'
        END AS category

    FROM sales.orders
) AS categorized_orders

GROUP BY category
ORDER BY total_sales DESC;


-- =========================================================
-- USE CASE 2: MAPPING VALUES
-- =========================================================
-- Convert coded values into more meaningful text.
--
-- Example:
-- M -> Male
-- F -> Female
SELECT
    employeeid,
    firstname,
    lastname,
    department,
    gender,

    CASE
        WHEN gender = 'M' THEN 'Male'
        ELSE 'Female'
    END AS full_gender_text

FROM sales.employees;


-- =========================================================
-- SIMPLE CASE STATEMENT
-- =========================================================
-- Use when comparing one column against
-- multiple possible values.
--
-- Syntax:
-- CASE column_name
--     WHEN value1 THEN result1
--     WHEN value2 THEN result2
--     ELSE default_result
-- END
SELECT
    customerid,
    firstname,
    lastname,
    country,

    CASE country
        WHEN 'Germany' THEN 'DE'
        WHEN 'USA' THEN 'US'
        ELSE country
    END AS country_abbr

FROM sales.customers;


-- =========================================================
-- USE CASE 3: HANDLING NULL VALUES
-- =========================================================
-- NULL values can be replaced using either:
-- 1. COALESCE()
-- 2. CASE
--
-- Recommendation:
-- Use COALESCE() when simply replacing NULL values.
-- Use CASE when more complex business logic is required.
--
-- Example:
-- COALESCE(score, 0)
--
-- is generally preferred over:
--
-- CASE
--     WHEN score IS NULL THEN 0
--     ELSE score
-- END
--
-- Window functions (OVER()) are used here only
-- for demonstration purposes and will be covered later.
SELECT
    customerid,
    firstname,
    lastname,
    score,

    COALESCE(score, 0) AS score_without_null,

    -- AVG ignores NULL values by default
    AVG(score) OVER () AS avg_with_nulls,

    -- Method 1: Using COALESCE
    ROUND(
        AVG(COALESCE(score, 0)) OVER ()
    ) AS avg_score_method1,

    -- Method 2: Using CASE
    AVG(
        CASE
            WHEN score IS NULL THEN 0
            ELSE score
        END
    ) OVER () AS avg_score_method2

FROM sales.customers;


-- =========================================================
-- USE CASE 4: CONDITIONAL AGGREGATION
-- =========================================================
-- One of the most common uses of CASE.
--
-- Count how many orders each customer has placed
-- with sales greater than 30.
--
-- Logic:
-- CASE returns:
-- 1 -> Condition is true
-- 0 -> Condition is false
--
-- SUM then counts the total matches.
SELECT
    customerid,

    SUM(
        CASE
            WHEN sales > 30 THEN 1
            ELSE 0
        END
    ) AS total_orders_high_sales,

    COUNT(*) AS total_orders

FROM sales.orders

GROUP BY customerid
ORDER BY customerid;