-- =========================================================
-- NUMBER FUNCTIONS
-- =========================================================


-- =========================================================
-- ROUND FUNCTION
-- =========================================================
-- ROUND is used to round decimal numbers.
--
-- Syntax:
-- ROUND(number, decimal_places)
--
-- Parameters:
-- 1. number          -> Value to round
-- 2. decimal_places  -> Number of digits after decimal
--
-- Simple Rule:
-- If the next digit is:
-- 0 to 4 -> round down
-- 5 to 9 -> round up
--
-- Example:
-- 3.516 rounded to:
-- 2 decimal places -> 3.52
-- 1 decimal place  -> 3.5
-- 0 decimal places -> 4
SELECT
    3.516,

    ROUND(3.516, 2) AS round_2,

    ROUND(3.516, 1) AS round_1,

    ROUND(3.516, 0) AS round_0;


-- =========================================================
-- ABS FUNCTION (Absolute Value)
-- =========================================================
-- ABS returns the positive value of a number.
--
-- Syntax:
-- ABS(number)
--
-- Meaning:
-- Removes the negative sign if present.
SELECT
    -10,

    ABS(-10) AS absolute_value;