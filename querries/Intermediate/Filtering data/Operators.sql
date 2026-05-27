-- operators
-- comparision operator

-- Retrive all customer from Germany (=)
SELECT *
FROM customers
WHERE country = 'Germany';

-- Retrive all customer who are not from Germany (!=, <>)
SELECT *
FROM customers
WHERE country != 'Germany';

--Reteuve all customers with score greater than 500 (>)
SELECT *
FROM customers
WHERE score > 500;

--Reteuve all customers with score of 500 or more (>=)
SELECT *
FROM customers
WHERE score >= 500;

--Reteuve all customers with score less than 500 (<)
SELECT *
FROM customers
WHERE score < 500;

--Reteuve all customers with score of 500 or less (<=)
SELECT *
FROM customers
WHERE score <= 500;

------------------------------------------------------------------------------------------

-- Logical operators
-- AND
-- Retrive customers from USA with score greater than 500
SELECT *
FROM customers
WHERE country = 'USA' AND score > 500;

-- OR
-- Retrive customers from USA or score greater than 500
SELECT *
FROM customers
WHERE country = 'USA' OR score > 500;

-- NOT
-- Retrive customers whose score not less than 500
SELECT *
FROM customers
WHERE NOT score < 500;

------------------------------------------------------------------------------------------

-- RANGE OPERATOR
-- BETWEEN (boundary is inclusive)
-- Retrive all customes whose score falls between 100 and 500
SELECT *
FROM customers
WHERE score BETWEEN 100 AND 500;
-- alterante way (using comparision and logical operator)
SELECT *
FROM customers
WHERE score >= 100 AND score <= 500;

--------------------------------------------------------------------------------------------

-- MEMBERSHIP OPERATORS
-- IN
-- Retrive all customers from either germany or usa
SELECT *
FROM customers
WHERE country IN ('Germany', 'USA');

-- NOT IN
-- Retrive all customers nither from germany or usa
SELECT *
FROM customers
WHERE country NOT IN ('Germany', 'USA');

---------------------------------------------------------------------------------

-- Search operator
-- LIKE
-- Find all customers whose first name starts with 'M'
SELECT *
FROM customers
WHERE first_name LIKE 'M%';

-- Find all customers whose first name ends with 'n'
SELECT *
FROM customers
WHERE first_name LIKE '%n';

-- Find all customers whose first name contains 'r'
SELECT *
FROM customers
WHERE first_name LIKE '%r%';

-- Find all customers whose first name has 'r' in third position 
SELECT *
FROM customers
WHERE first_name LIKE '__r%';