-- =========================================================
-- DATA MANIPULATION LANGUAGE (DML)
-- Database: PostgreSQL
-- Description:
-- This file demonstrates basic DML operations such as
-- INSERT, UPDATE, DELETE, and TRUNCATE.
-- =========================================================


-- =========================================================
-- INSERT DATA - METHOD 1 (MANUAL INSERT)
-- =========================================================
-- Rules for INSERT statements:
-- 1. Column order and value order must match.
-- 2. Data types must be compatible.
-- 3. Number of columns and values must be equal.
-- 4. Constraints such as PRIMARY KEY and NOT NULL must be satisfied.
-- 5. Column names can be omitted only if values are provided
--    for all columns in the correct order.
-- 6. Columns not included in INSERT will contain NULL
--    by default unless restricted by NOT NULL constraints.


-- Insert multiple records into the customers table
INSERT INTO customers (id, first_name, country, score)
VALUES
    (6, 'Lenda', 'UK', 799),
    (7, 'Tatti', 'USA', 978),
    (8, 'Suar', 'Germany', 976);


-- Insert a record without specifying column names
-- This works only when values match the exact table structure
INSERT INTO customers
VALUES (9, 'Chipkali', 'India', 900);


-- Insert partial data
-- Score column will become NULL because it is not provided
INSERT INTO customers (id, first_name, country)
VALUES (10, 'Pgadmin', 'UK');


-- Verify inserted records
SELECT *
FROM customers;


-- =========================================================
-- INSERT DATA - METHOD 2 (COPY DATA FROM ANOTHER TABLE)
-- =========================================================
-- Recreate the persons table
-- Note:
-- 'birth_data' should ideally be named 'birth_date'
-- but it is kept unchanged for demonstration purposes
CREATE TABLE persons (
    id INT PRIMARY KEY,
    person_name VARCHAR(150) NOT NULL,
    birth_data DATE,
    phone VARCHAR(15) NOT NULL
);


-- Verify that the table is currently empty
SELECT *
FROM persons;


-- Copy data from customers table into persons table
-- NULL is inserted into birth_data
-- 'Unknown' is inserted into phone column for all rows
INSERT INTO persons (id, person_name, birth_data, phone)
SELECT
    id,
    first_name,
    NULL,
    'Unknown'
FROM customers;


-- Verify copied data
SELECT *
FROM persons;


-- =========================================================
-- UPDATE STATEMENTS
-- =========================================================
-- Important:
-- Always use the WHERE clause carefully while updating data.
-- Without WHERE, all rows in the table will be updated.


-- Change the score of customer with id = 6 to 0
UPDATE customers
SET score = 0
WHERE id = 6;


-- Verify updated record
SELECT *
FROM customers
WHERE id = 6;


-- Update multiple columns in a single query
-- Change score to 0 and country to UK for customer with id = 10
UPDATE customers
SET
    score = 0,
    country = 'UK'
WHERE id = 10;


-- Verify updated data
SELECT *
FROM customers;


-- Replace NULL scores with 0
UPDATE customers
SET score = 0
WHERE score IS NULL;


-- Verify updated records
SELECT *
FROM customers;


-- =========================================================
-- DELETE STATEMENTS
-- =========================================================
-- Important:
-- WHERE clause is critical in DELETE statements.
-- Without WHERE, all rows from the table will be deleted.


-- Delete customers whose id is greater than 5
DELETE FROM customers
WHERE id > 5;


-- Verify remaining records
SELECT *
FROM customers;


-- =========================================================
-- DELETE VS TRUNCATE
-- =========================================================

-- Delete all rows from persons table
-- Table structure remains unchanged
DELETE FROM persons;


-- Faster alternative to remove all rows from a table
-- TRUNCATE is generally more efficient than DELETE
-- because it removes all rows without scanning them individually
TRUNCATE TABLE persons;


-- Verify that the table is empty
SELECT *
FROM persons;