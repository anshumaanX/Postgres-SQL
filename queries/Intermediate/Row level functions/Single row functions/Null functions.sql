-- =========================================================
-- NULL FUNCTIONS
-- =========================================================
-- NULL represents a missing or unknown value.
--
-- Important:
-- NULL is NOT equal to:
-- 0
-- ''
-- FALSE
--
-- Common NULL Functions:
-- 1. COALESCE()
-- 2. NULLIF()
-- 3. IS NULL
-- 4. IS NOT NULL


-- =========================================================
-- COALESCE FUNCTION
-- =========================================================
-- COALESCE returns the first non-NULL value
-- from the list of provided arguments.
--
-- Syntax:
-- COALESCE(value1, value2, value3, ...)
--
-- Examples:
-- COALESCE(NULL, 10)      -> 10
-- COALESCE(NULL, NULL, 5) -> 5
-- COALESCE(20, 10)        -> 20
--
-- Common Uses:
-- 1. Replace NULL values
-- 2. Prevent calculations from returning NULL
-- 3. Display default values


-- =========================================================
-- AVERAGE SCORE EXAMPLE
-- =========================================================
-- AVG() automatically ignores NULL values.
--
-- Example:
-- Scores: 100, 200, NULL
--
-- AVG(score)
-- = (100 + 200) / 2
-- = 150
--
-- AVG(COALESCE(score,0))
-- = (100 + 200 + 0) / 3
-- = 100
--
-- Important:
-- Replacing NULL with 0 changes the calculation,
-- so use COALESCE only when business logic requires it.
--
-- OVER() is a Window Function clause.
-- It is used here only for demonstration and will be
-- discussed in detail later.
SELECT
    customerid,
    score,

    COALESCE(score, 0) AS non_null_score,

    AVG(score) OVER () AS avg_with_nulls,

    AVG(COALESCE(score, 0)) OVER ()
    AS avg_without_nulls

FROM sales.customers;


-- =========================================================
-- HANDLING NULL VALUES IN STRING CONCATENATION
-- =========================================================
-- In PostgreSQL:
-- NULL || 'text' = NULL
--
-- Therefore COALESCE is often used when building
-- full names or addresses.
--
-- Example:
-- firstname = 'John'
-- lastname  = NULL
--
-- Without COALESCE:
-- Result = NULL
--
-- With COALESCE:
-- Result = 'John'
SELECT
    firstname,
    lastname,

    COALESCE(firstname, '')
    || ' ' ||
    COALESCE(lastname, '')
    AS full_name,

    score,

    COALESCE(score, 0) + 10
    AS bonus_score

FROM sales.customers;


-- =========================================================
-- SORTING NULL VALUES
-- =========================================================
-- By default PostgreSQL treats NULL values as:
--
-- ASC  -> NULLS LAST
-- DESC -> NULLS FIRST
--
-- Examples:
--
-- ORDER BY score ASC
-- Lowest score → Highest score → NULL values
--
-- ORDER BY score DESC
-- NULL values → Highest score → Lowest score
--
-- CASE expression is used here only for demonstration.
-- CASE will be covered in detail later.
SELECT
    customerid,
    score,

    CASE
        WHEN score IS NULL THEN 1
        ELSE 0
    END AS flag

FROM sales.customers

ORDER BY
    CASE
        WHEN score IS NULL THEN 1
        ELSE 0
    END,
    score;


-- =========================================================
-- BETTER POSTGRESQL APPROACH
-- =========================================================
-- PostgreSQL provides NULLS FIRST and NULLS LAST.
--
-- This is usually preferred over CASE expressions.
SELECT
    customerid,
    score
FROM sales.customers
ORDER BY score NULLS LAST;


-- =========================================================
-- NULLIF FUNCTION
-- =========================================================
-- NULLIF compares two expressions.
--
-- Syntax:
-- NULLIF(value1, value2)
--
-- If value1 = value2:
--     Returns NULL
--
-- Otherwise:
--     Returns value1
--
-- Examples:
-- NULLIF(5,5) -> NULL
-- NULLIF(5,3) -> 5
--
-- Common Uses:
-- 1. Prevent division-by-zero errors
-- 2. Convert unwanted values into NULL


-- =========================================================
-- DIVISION BY ZERO PREVENTION
-- =========================================================
-- If quantity = 0:
--
-- sales / quantity
-- produces an error.
--
-- NULLIF(quantity, 0)
-- converts 0 into NULL.
--
-- Division by NULL returns NULL
-- instead of raising an error.
SELECT
    orderid,
    sales,
    quantity,

    sales / NULLIF(quantity, 0)
    AS sales_price

FROM sales.orders;


-- =========================================================
-- IS NULL
-- =========================================================
-- Find customers who do not have a score.
--
-- Important:
-- Never use:
-- score = NULL
--
-- Always use:
-- score IS NULL
SELECT
    customerid,
    score

FROM sales.customers

WHERE score IS NULL;


-- =========================================================
-- IS NOT NULL
-- =========================================================
-- Find customers who have a score.
SELECT
    customerid,
    score

FROM sales.customers

WHERE score IS NOT NULL;


-- =========================================================
-- REAL-WORLD USE CASE
-- =========================================================
-- Find customers who have never placed an order.
--
-- Logic:
-- 1. LEFT JOIN keeps all customers.
-- 2. Customers without matching orders receive NULL
--    values from the orders table.
-- 3. Filter those unmatched rows.
SELECT
    *
FROM sales.customers AS c

LEFT JOIN sales.orders AS o
ON c.customerid = o.customerid

WHERE o.customerid IS NULL;