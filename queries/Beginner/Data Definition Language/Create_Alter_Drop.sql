-- =========================================================
-- DATA DEFINITION LANGUAGE (DDL)
-- Database: PostgreSQL
-- Description:
-- This file demonstrates basic DDL operations such as
-- creating, modifying, and deleting database tables.
-- =========================================================


-- =========================================================
-- CREATE TABLE
-- =========================================================
-- Create a new table named 'persons'
-- PRIMARY KEY:
--     Ensures each record has a unique identifier.
-- NOT NULL:
--     Prevents NULL values from being inserted.
CREATE TABLE persons (
    id INT PRIMARY KEY,
    person_name VARCHAR(150) NOT NULL,
    birth_date DATE,
    phone VARCHAR(15) NOT NULL
);


-- =========================================================
-- VIEW TABLE DATA
-- =========================================================
-- Check data inside the persons table
-- At this stage, the table is empty
SELECT *
FROM persons;


-- =========================================================
-- ALTER TABLE - ADD COLUMN
-- =========================================================
-- Add a new column named 'email'
-- The column does not allow NULL values
ALTER TABLE persons
ADD email VARCHAR(50) NOT NULL;


-- =========================================================
-- ALTER TABLE - DROP COLUMN
-- =========================================================
-- Remove the 'phone' column from the table
ALTER TABLE persons
DROP COLUMN phone;


-- =========================================================
-- VIEW UPDATED TABLE STRUCTURE/DATA
-- =========================================================
-- Verify the updated table after modifications
SELECT *
FROM persons;


-- =========================================================
-- DROP TABLE
-- =========================================================
-- Permanently delete the 'persons' table from the database
-- Warning:
--     All data inside the table will also be deleted
DROP TABLE persons;