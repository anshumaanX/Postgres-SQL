-- =========================================================
-- STRING MANIPULATION FUNCTIONS
-- Database: PostgreSQL
-- Description:
-- This file demonstrates commonly used SQL string
-- manipulation functions for formatting, transforming,
-- cleaning, and extracting text data.
-- =========================================================


-- =========================================================
-- CONCAT FUNCTION
-- =========================================================
-- CONCAT joins multiple strings into a single value.
--
-- Syntax:
-- CONCAT(value1, value2, value3, ...)
--
-- Example:
-- Combine customer's first name and country
-- into a single column.
SELECT
    CONCAT(first_name, ' ', country) AS name_country
FROM customers;


-- =========================================================
-- UPPER AND LOWER FUNCTIONS
-- =========================================================
-- LOWER() converts text into lowercase.
-- UPPER() converts text into uppercase.
--
-- Useful for:
-- 1. Standardizing text data
-- 2. Case-insensitive comparisons
-- 3. Data formatting
SELECT
    first_name,

    -- Convert text to lowercase
    LOWER(first_name) AS lower_case_name,

    -- Convert text to uppercase
    UPPER(first_name) AS upper_case_name

FROM customers;


-- =========================================================
-- TRIM FUNCTION
-- =========================================================
-- TRIM removes leading and trailing spaces
-- from a string.
--
-- Syntax:
-- TRIM(text)
--
-- This query identifies names containing
-- extra spaces at the beginning or end.
SELECT
    first_name,

    -- Original string length
    LENGTH(first_name) AS original_length,

    -- Length after removing spaces
    LENGTH(TRIM(first_name)) AS trimmed_length,

    -- Difference gives total extra spaces removed
    LENGTH(first_name) - LENGTH(TRIM(first_name))
    AS total_blank_spaces

FROM customers

-- Filter only rows containing extra spaces
WHERE LENGTH(first_name) != LENGTH(TRIM(first_name));


-- =========================================================
-- REPLACE FUNCTION
-- =========================================================
-- REPLACE substitutes part of a string
-- with another value.
--
-- Syntax:
-- REPLACE(original_text, old_value, new_value)
--
-- Parameters:
-- 1. original_text -> Source string
-- 2. old_value     -> Text to replace
-- 3. new_value     -> Replacement text


-- Remove dashes (-) from a phone number
SELECT
    '123-456-7890' AS phone,

    REPLACE('123-456-7890', '-', '')
    AS phone_without_dashes;


-- Replace .txt extension with .csv
SELECT
    'myfile.txt' AS txt_file,

    REPLACE('myfile.txt', '.txt', '.csv')
    AS csv_file;


-- =========================================================
-- LENGTH FUNCTION
-- =========================================================
-- LENGTH returns the total number of characters
-- in a string.
--
-- Syntax:
-- LENGTH(text)
SELECT
    first_name,

    LENGTH(first_name) AS first_name_length

FROM customers;


-- =========================================================
-- LEFT AND RIGHT FUNCTIONS
-- =========================================================
-- LEFT extracts characters from the beginning.
-- RIGHT extracts characters from the end.
--
-- Syntax:
-- LEFT(text, number_of_characters)
-- RIGHT(text, number_of_characters)


-- Retrieve first two characters from first_name
SELECT
    first_name,

    LEFT(TRIM(first_name), 2)
    AS first_two_characters_of_firstname

FROM customers;


-- Retrieve last two characters from first_name
SELECT
    first_name,

    RIGHT(TRIM(first_name), 2)
    AS last_two_characters_of_firstname

FROM customers;


-- =========================================================
-- SUBSTRING FUNCTION
-- =========================================================
-- SUBSTRING extracts part of a string.
--
-- Syntax:
-- SUBSTRING(text, start_position, length)
--
-- Parameters:
-- 1. text           -> Source string
-- 2. start_position -> Starting position (starts from 1)
-- 3. length         -> Number of characters to extract
--
-- Example:
-- Remove the first character from first_name
SELECT
    first_name,

    SUBSTRING(
        TRIM(first_name),
        2,
        LENGTH(TRIM(first_name))
    ) AS firstname_without_first_character

FROM customers;