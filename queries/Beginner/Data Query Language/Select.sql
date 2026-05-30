-- =========================================================
-- SELECT STATEMENTS AND BASIC QUERY CLAUSES
-- Database: PostgreSQL
-- Description:
-- This file demonstrates commonly used SQL SELECT queries
-- and clauses for retrieving and filtering data.
-- =========================================================


-- =========================================================
-- SQL COMMENTS
-- =========================================================

-- Single-line comment

/*
Multi-line comment
used for longer explanations
or documentation.
*/


-- =========================================================
-- RETRIEVE ALL DATA
-- =========================================================
-- Retrieve all columns and rows from the customers table
SELECT *
FROM customers;

-- Retrieve all columns and rows from the orders table
SELECT *
FROM orders;


-- =========================================================
-- RETRIEVE SPECIFIC COLUMNS
-- =========================================================
-- Fetch only required columns instead of all columns
-- Improves readability and can improve performance
SELECT
    first_name,
    country,
    score
FROM customers;


-- =========================================================
-- WHERE CLAUSE
-- =========================================================
-- Filter customers who belong to Germany
SELECT *
FROM customers
WHERE country = 'Germany';

-- Retrieve customers whose score is not equal to 0
SELECT *
FROM customers
WHERE score != 0;


-- =========================================================
-- ORDER BY CLAUSE
-- =========================================================
-- Sort customer scores in ascending order (lowest to highest)
SELECT *
FROM customers
ORDER BY score ASC;

-- Sort customer scores in descending order (highest to lowest)
SELECT *
FROM customers
ORDER BY score DESC;

-- Retrieve customers with scores greater than 0
-- and sort them from highest to lowest
SELECT *
FROM customers
WHERE score > 0
ORDER BY score DESC;

-- Sort data first by country (A-Z)
-- and then by score within each country in descending order
SELECT *
FROM customers
ORDER BY country, score DESC;


-- =========================================================
-- GROUP BY CLAUSE
-- =========================================================
-- Calculate the total score for each country
SELECT
    country,
    SUM(score) AS total_score
FROM customers
GROUP BY country
ORDER BY total_score DESC;

-- Calculate total score and total number of customers
-- for each country where score is greater than 0
SELECT
    country,
    SUM(score) AS total_score,
    COUNT(*) AS number_of_customers
FROM customers
WHERE score > 0
GROUP BY country
ORDER BY total_score DESC;


-- =========================================================
-- HAVING CLAUSE
-- =========================================================
-- HAVING filters grouped data after aggregation
-- Retrieve countries whose total score is greater than 800
SELECT
    country,
    SUM(score) AS total_score
FROM customers
WHERE score > 0
GROUP BY country
HAVING SUM(score) > 800
ORDER BY total_score DESC;

-- Calculate average score for each country
-- considering only customers with non-zero scores
-- Return only countries with an average score greater than 430
SELECT
    country,
    AVG(score) AS avg_score
FROM customers
WHERE score != 0
GROUP BY country
HAVING AVG(score) > 430;


-- =========================================================
-- DISTINCT
-- =========================================================
-- Retrieve a unique list of countries
SELECT DISTINCT country
FROM customers;


-- =========================================================
-- LIMIT CLAUSE
-- =========================================================
-- Retrieve top 3 customers with the highest scores
SELECT *
FROM customers
ORDER BY score DESC
LIMIT 3;

-- Retrieve 2 customers with the lowest scores
SELECT *
FROM customers
ORDER BY score ASC
LIMIT 2;

-- Retrieve the 2 most recent orders
SELECT *
FROM orders
ORDER BY order_date DESC
LIMIT 2;


-- =========================================================
-- STATIC VALUE
-- =========================================================
-- Return a static/custom value using SELECT
SELECT '123q' AS static_value;