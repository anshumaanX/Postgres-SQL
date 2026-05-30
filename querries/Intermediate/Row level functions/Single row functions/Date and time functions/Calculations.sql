-- =========================================================
-- DATE/TIME CALCULATIONS
-- =========================================================


-- =========================================================
-- INTERVAL
-- =========================================================
-- INTERVAL represents a duration of time.
--
-- It can be used to:
-- 1. Add time to a date/timestamp
-- 2. Subtract time from a date/timestamp
-- 3. Perform date calculations
--
-- Syntax:
-- INTERVAL 'value unit'
--
-- Examples:
-- INTERVAL '10 days'
-- INTERVAL '2 months'
-- INTERVAL '1 year'
-- INTERVAL '5 hours'


-- Add 10 days to the current date
SELECT
    CURRENT_DATE + INTERVAL '10 days' AS plus_10_days;


-- Add 2 months to the current date
SELECT
    CURRENT_DATE + INTERVAL '2 months' AS plus_2_months;


-- Add 2 years to the current date
SELECT
    CURRENT_DATE + INTERVAL '2 years' AS plus_2_years;


-- =========================================================
-- SUBTRACTING AN INTERVAL
-- =========================================================
-- Retrieve the timestamp 5 days before creationtime
SELECT
    orderid,
    creationtime,

    creationtime - INTERVAL '5 days'
    AS five_days_before_creation

FROM sales.orders;


-- =========================================================
-- DATE DIFFERENCE CALCULATIONS
-- =========================================================
-- PostgreSQL can directly subtract two dates.
--
-- Result:
-- Number of days between the dates.
--
-- AGE() provides a more detailed interval
-- (years, months, days).
SELECT
    orderid,

    orderdate,
    shipdate,

    -- Returns total days as an integer
    shipdate - orderdate
    AS days_for_shipping,

    -- Returns an interval
    AGE(shipdate, orderdate)
    AS shipping_duration

FROM sales.orders;


-- =========================================================
-- AGE FUNCTION
-- =========================================================
-- AGE(end_date, start_date)
--
-- Calculates the difference between two dates
-- as an interval.
--
-- Example Result:
-- 25 years 3 mons 12 days
--
-- Common use:
-- Age calculation
SELECT
    AGE(CURRENT_DATE, birthdate) AS employee_age,

    -- Extract only the year portion
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, birthdate))
    AS age_in_years

FROM sales.employees;


-- =========================================================
-- AVERAGE SHIPPING DURATION BY MONTH
-- =========================================================
-- Find the average number of shipping days
-- for orders shipped in each month.
--
-- Note:
-- Direct date subtraction is simpler here because
-- it returns the total number of days.
--
-- This approach is generally preferred over
-- EXTRACT(DAY FROM AGE(...))
SELECT
    EXTRACT(MONTH FROM shipdate) AS month,

    AVG(shipdate - orderdate)
    AS avg_shipping_days

FROM sales.orders

GROUP BY month
ORDER BY month;


-- =========================================================
-- EXTRACTING PARTS FROM AGE
-- =========================================================
-- AGE() returns an interval.
--
-- EXTRACT can retrieve individual parts
-- from that interval.
--
-- Example:
-- AGE('2026-06-10', '2025-04-01')
--
-- Result:
-- 1 year 2 mons 9 days
--
-- Individual parts can then be extracted.
SELECT
    EXTRACT(YEAR FROM AGE(shipdate, orderdate)) AS years,

    EXTRACT(MONTH FROM AGE(shipdate, orderdate)) AS months,

    EXTRACT(DAY FROM AGE(shipdate, orderdate)) AS days

FROM sales.orders;


-- =========================================================
-- IMPORTANT NOTE
-- =========================================================
-- AGE() is best when you need a human-readable
-- interval such as:
--
-- 2 years 3 mons 5 days
--
-- Direct subtraction is usually better when you need:
--
-- Total number of days
--
-- Example:
SELECT
    shipdate - orderdate AS total_days
FROM sales.orders;