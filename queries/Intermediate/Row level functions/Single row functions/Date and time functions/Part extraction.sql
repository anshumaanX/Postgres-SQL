-- =========================================================
-- DATE AND TIME FUNCTIONS
-- =========================================================


-- =========================================================
-- PART EXTRACTION FUNCTIONS
-- =========================================================
-- PostgreSQL provides multiple ways to extract
-- parts from date/time values.
--
-- Common extracted parts:
-- YEAR, MONTH, DAY, HOUR, WEEK, QUARTER
--
-- Main Functions:
-- 1. EXTRACT()
-- 2. DATE_PART()
--
-- Both functions are very similar and usually return
-- the same numeric result.
--
-- Difference:
-- EXTRACT()   -> SQL standard and more readable
-- DATE_PART() -> PostgreSQL-specific function
--
-- Return Type:
-- Both return numeric values.
-- PostgreSQL internally returns DOUBLE PRECISION,
-- even if the displayed value looks like an integer.


-- =========================================================
-- EXTRACT AND DATE_PART
-- =========================================================
SELECT
    orderid,
    creationtime,

    -- EXTRACT examples
    EXTRACT(YEAR FROM creationtime)    AS year,
    EXTRACT(MONTH FROM creationtime)   AS month,
    EXTRACT(DAY FROM creationtime)     AS day,
    EXTRACT(HOUR FROM creationtime)    AS hour,
    EXTRACT(QUARTER FROM creationtime) AS quarter,
    EXTRACT(WEEK FROM creationtime)    AS week,

    -- DATE_PART examples
    DATE_PART('year', creationtime)  AS year_dp,
    DATE_PART('month', creationtime) AS month_dp,
    DATE_PART('day', creationtime)   AS day_dp,
    DATE_PART('hour', creationtime)  AS hour_dp

FROM sales.orders;


-- =========================================================
-- TO_CHAR FUNCTION
-- =========================================================
-- TO_CHAR converts date/time values into formatted text.
--
-- Syntax:
-- TO_CHAR(date_or_time, format_pattern)
--
-- Important:
-- TO_CHAR returns STRING/TEXT values,
-- not numeric values.
--
-- Commonly used for:
-- 1. Reporting
-- 2. User-friendly display
-- 3. Formatting dates/times
--
-- Common format patterns:
-- YYYY -> 4-digit year
-- Month -> Full month name
-- Mon -> Short month name
-- Day -> Full day name
-- Dy -> Short day name
-- HH24 -> 24-hour format
SELECT
    orderid,
    creationtime,

    TO_CHAR(creationtime, 'Month') AS full_month,
    TO_CHAR(creationtime, 'Mon')   AS short_month,

    TO_CHAR(creationtime, 'Day')   AS full_day,
    TO_CHAR(creationtime, 'Dy')    AS short_day,

    TO_CHAR(creationtime, 'YYYY')  AS year,

    TO_CHAR(creationtime, 'HH24')  AS hour

FROM sales.orders;


-- =========================================================
-- DATE_TRUNC FUNCTION
-- =========================================================
-- DATE_TRUNC truncates a date/time value
-- to a specified precision.
--
-- Syntax:
-- DATE_TRUNC('part', timestamp)
--
-- Meaning:
-- Smaller units are reset to zero/default values.
--
-- Example:
-- DATE_TRUNC('month', '2026-05-15 10:45:20')
-- Result:
-- 2026-05-01 00:00:00
--
-- Common truncation levels:
-- year, month, day, hour, minute
SELECT
    orderid,
    creationtime,

    DATE_TRUNC('year', creationtime)  AS truncated_year,

    DATE_TRUNC('month', creationtime) AS truncated_month,

    DATE_TRUNC('day', creationtime)   AS truncated_day,

    DATE_TRUNC('hour', creationtime)  AS truncated_hour

FROM sales.orders;


-- =========================================================
-- DATE_TRUNC USE CASE
-- =========================================================
-- Group orders by month.
--
-- DATE_TRUNC is useful for:
-- 1. Monthly reports
-- 2. Yearly summaries
-- 3. Time-based aggregation
SELECT
    DATE_TRUNC('month', creationtime) AS month,
    COUNT(*) AS total_orders

FROM sales.orders

GROUP BY month
ORDER BY month;


-- =========================================================
-- BETTER REPORTING FORMAT
-- =========================================================
-- This approach displays readable month names
-- while sorting correctly using month numbers.
--
-- Why month_number?
-- Because sorting alphabetically by month name
-- gives incorrect order:
-- April, August, December...
SELECT
    TO_CHAR(creationtime, 'Month') AS month,

    EXTRACT(MONTH FROM creationtime) AS month_number,

    COUNT(*) AS total_orders

FROM sales.orders

GROUP BY month, month_number
ORDER BY month_number;


-- =========================================================
-- END OF MONTH CALCULATION
-- =========================================================
-- PostgreSQL does not have a direct EOMONTH()
-- function like SQL Server.
--
-- Common PostgreSQL approach:
-- 1. Move to first day of current month
-- 2. Add 1 month
-- 3. Subtract 1 day
--
-- Result:
-- Last day of the month
SELECT
    orderid,
    creationtime,

    DATE_TRUNC('month', creationtime)
        + INTERVAL '1 month'
        - INTERVAL '1 day'
    AS end_of_month

FROM sales.orders;


-- =========================================================
-- YEARLY ORDER REPORT
-- =========================================================
-- Count total orders placed each year
SELECT
    EXTRACT(YEAR FROM creationtime) AS year,

    COUNT(*) AS total_orders

FROM sales.orders

GROUP BY year
ORDER BY year;


-- =========================================================
-- MONTHLY ORDER REPORT
-- =========================================================
-- Count total orders placed each month
SELECT
    TO_CHAR(creationtime, 'Month') AS month,

    COUNT(*) AS total_orders

FROM sales.orders

GROUP BY month
ORDER BY month;


-- =========================================================
-- DATE FILTERING USING EXTRACT
-- =========================================================
-- Retrieve orders placed during February.
--
-- Why use numbers instead of strings?
-- Numeric comparisons are generally faster and simpler
-- than comparing formatted text values.
SELECT
    *
FROM sales.orders

WHERE EXTRACT(MONTH FROM creationtime) = 2;