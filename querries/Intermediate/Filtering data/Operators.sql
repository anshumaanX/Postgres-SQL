-- =========================================================
-- SQL OPERATORS
-- Database: PostgreSQL
-- Description:
-- This file demonstrates commonly used SQL operators
-- such as comparison, logical, range, membership,
-- and pattern matching operators.
-- =========================================================


-- =========================================================
-- COMPARISON OPERATORS
-- =========================================================

-- Retrieve all customers from Germany (=)
SELECT *
FROM customers
WHERE country = 'Germany';


-- Retrieve all customers who are not from Germany (!=)
-- PostgreSQL also supports <> as "not equal to"
SELECT *
FROM customers
WHERE country != 'Germany';


-- Retrieve all customers with scores greater than 500 (>)
SELECT *
FROM customers
WHERE score > 500;


-- Retrieve all customers with scores greater than or equal to 500 (>=)
SELECT *
FROM customers
WHERE score >= 500;


-- Retrieve all customers with scores less than 500 (<)
SELECT *
FROM customers
WHERE score < 500;


-- Retrieve all customers with scores less than or equal to 500 (<=)
SELECT *
FROM customers
WHERE score <= 500;


-- =========================================================
-- LOGICAL OPERATORS
-- =========================================================

-- AND Operator
-- Retrieve customers from USA with scores greater than 500
SELECT *
FROM customers
WHERE country = 'USA'
  AND score > 500;


-- OR Operator
-- Retrieve customers who are either from USA
-- or have scores greater than 500
SELECT *
FROM customers
WHERE country = 'USA'
   OR score > 500;


-- NOT Operator
-- Retrieve customers whose score is NOT less than 500
-- Equivalent to: score >= 500
SELECT *
FROM customers
WHERE NOT score < 500;


-- =========================================================
-- RANGE OPERATOR
-- =========================================================

-- BETWEEN Operator
-- BETWEEN is inclusive of both boundary values
-- Retrieve customers with scores between 100 and 500
SELECT *
FROM customers
WHERE score BETWEEN 100 AND 500;


-- Alternative way using comparison and logical operators
SELECT *
FROM customers
WHERE score >= 100
  AND score <= 500;


-- =========================================================
-- MEMBERSHIP OPERATORS
-- =========================================================

-- IN Operator
-- Retrieve customers from either Germany or USA
SELECT *
FROM customers
WHERE country IN ('Germany', 'USA');


-- NOT IN Operator
-- Retrieve customers who are neither from Germany nor USA
SELECT *
FROM customers
WHERE country NOT IN ('Germany', 'USA');


-- =========================================================
-- SEARCH / PATTERN MATCHING OPERATORS
-- =========================================================

-- LIKE Operator
-- % represents zero or more characters
-- _ represents a single character


-- Find customers whose first name starts with 'M'
SELECT *
FROM customers
WHERE first_name LIKE 'M%';


-- Find customers whose first name ends with 'n'
SELECT *
FROM customers
WHERE first_name LIKE '%n';


-- Find customers whose first name contains 'r'
SELECT *
FROM customers
WHERE first_name LIKE '%r%';


-- Find customers whose first name has 'r'
-- in the third position
SELECT *
FROM customers
WHERE first_name LIKE '__r%';