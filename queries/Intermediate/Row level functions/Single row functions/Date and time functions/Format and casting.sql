-- =========================================================
-- FORMATTING AND CASTING
-- =========================================================


-- =========================================================
-- DATE/TIME FORMATTING USING TO_CHAR
-- =========================================================
-- TO_CHAR converts a date, timestamp, or number
-- into a formatted text/string.
--
-- Syntax:
-- TO_CHAR(value, format_pattern)
--
-- Return Type:
-- TEXT (String)
--
-- Commonly used for:
-- 1. Reports
-- 2. User-friendly display
-- 3. Custom date/time formats
SELECT
    creationtime,

    -- Day Information
    TO_CHAR(creationtime, 'DD')      AS dd,        -- Day of month (01-31)
    TO_CHAR(creationtime, 'DDD')     AS ddd,       -- Day of year (001-366)
    TO_CHAR(creationtime, 'D')       AS d,         -- Day of week (1-7)

    -- Month Information
    TO_CHAR(creationtime, 'MM')      AS mm,        -- Month number (01-12)
    TO_CHAR(creationtime, 'Mon')     AS mon,       -- Jan, Feb, Mar
    TO_CHAR(creationtime, 'Month')   AS month,     -- January, February

    -- Year Information
    TO_CHAR(creationtime, 'YY')      AS yy,        -- 26
    TO_CHAR(creationtime, 'YYYY')    AS yyyy,      -- 2026

    -- Quarter
    TO_CHAR(creationtime, 'Q')       AS quarter,   -- 1,2,3,4

    -- Week Information
    TO_CHAR(creationtime, 'WW')      AS week_of_year,
    TO_CHAR(creationtime, 'IW')      AS iso_week,

    -- Day Names
    TO_CHAR(creationtime, 'Dy')      AS short_day,
    TO_CHAR(creationtime, 'Day')     AS full_day,

    -- Time Information
    TO_CHAR(creationtime, 'HH12')    AS hour_12,
    TO_CHAR(creationtime, 'HH24')    AS hour_24,
    TO_CHAR(creationtime, 'MI')      AS minute,
    TO_CHAR(creationtime, 'SS')      AS second,
    TO_CHAR(creationtime, 'MS')      AS millisecond,

    -- AM / PM
    TO_CHAR(creationtime, 'AM')      AS am_pm,

    -- Time Zone
    -- Works only with TIMESTAMP WITH TIME ZONE values
    TO_CHAR(creationtime, 'TZ')      AS timezone

FROM sales.orders;


-- =========================================================
-- CUSTOM DATE FORMAT
-- =========================================================
-- Format:
-- DD-MM-YYYY
SELECT
    TO_CHAR(creationtime, 'DD-MM-YYYY') AS formatted_date
FROM sales.orders;


-- =========================================================
-- CUSTOM REPORT FORMAT
-- =========================================================
-- Example Output:
-- Day Wed Jan Q2 2026 12:34:56 AM
--
-- || is PostgreSQL's string concatenation operator
SELECT
    orderid,
    creationtime,

    'Day '
    || TO_CHAR(creationtime, 'Dy Mon')
    || ' Q'
    || TO_CHAR(creationtime, 'Q ')
    || TO_CHAR(creationtime, 'YYYY HH12:MI:SS AM')
    AS custom_format

FROM sales.orders;


-- =========================================================
-- DATA AGGREGATION USE CASE
-- =========================================================
-- Group orders by Month and Year.
--
-- Example Output:
-- Jan 2026
-- Feb 2026
-- Mar 2026
SELECT
    TO_CHAR(orderdate, 'Mon YYYY') AS order_month,

    COUNT(*) AS total_orders

FROM sales.orders

GROUP BY order_month;


-- =========================================================
-- CASTING / TYPE CONVERSION
-- =========================================================
-- Casting means converting one data type into another.
--
-- PostgreSQL supports two methods:
--
-- Method 1: CAST()
-- Method 2: ::
--
-- Both perform exactly the same operation.
--
-- CAST() -> SQL Standard (portable)
-- ::     -> PostgreSQL Shortcut
--
-- Most PostgreSQL developers commonly use ::
-- because it is shorter.


-- =========================================================
-- STRING TO INTEGER
-- =========================================================

-- Standard SQL way
SELECT
    CAST('123' AS INTEGER) AS str_to_int;

-- PostgreSQL shortcut
SELECT
    '123'::INTEGER AS str_to_int;


-- =========================================================
-- STRING TO DATE
-- =========================================================

-- Standard SQL way
SELECT
    CAST('2026-06-30' AS DATE) AS string_to_date;

-- PostgreSQL shortcut
SELECT
    '2026-05-30'::DATE AS string_to_date;


-- =========================================================
-- STRING TO TIMESTAMP
-- =========================================================

SELECT
    '2026-05-30 23:50:24'::TIMESTAMP
    AS str_to_timestamp;

-- CAST vs TO_CHAR
--
-- CAST changes the actual data type.
--
-- Example:
SELECT '123'::INTEGER;

-- Result Type:
-- INTEGER
--
-----------------------------------------------------
--
-- TO_CHAR formats a value as text.
--
-- Example:
SELECT TO_CHAR(CURRENT_DATE, 'DD-MM-YYYY');
--
-- Result Type:
-- TEXT