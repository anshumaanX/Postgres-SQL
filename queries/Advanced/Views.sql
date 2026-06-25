-- ============================================================================
-- VIEWS
-- ============================================================================
-- A View is a virtual table based on the result of a SQL query.
-- It does not store data itself (except Materialized Views).
-- Instead, PostgreSQL executes the underlying query whenever the view is queried.
--
-- Benefits of Views:
-- 1. Simplify complex queries
-- 2. Reuse business logic
-- 3. Improve security by hiding sensitive columns/rows
-- 4. Provide a consistent interface to users
-- 5. Hide underlying table complexity
--
-- View vs CTE
--
-- CTE (WITH Clause)
-- - Exists only during query execution
-- - Cannot be reused outside the query
-- - Best for breaking down complex queries into readable steps
--
-- View
-- - Stored permanently in the database
-- - Can be reused by multiple users and queries
-- - Best for frequently used business logic
--
-- Example:
--
-- CTE:
-- WITH monthly_sales AS (...)
-- SELECT * FROM monthly_sales;
--
-- View:
-- CREATE VIEW monthly_sales AS (...);
-- SELECT * FROM monthly_sales;
--
-- Use CTE when logic is needed once.
-- Use View when logic will be reused many times.
-- ============================================================================



-- ============================================================================
-- Example 1: Monthly Sales View
-- Find monthly sales and use the view to calculate a running total.
-- ============================================================================

CREATE VIEW sales.monthly_sales AS
SELECT
    DATE_TRUNC('month', orderdate) AS month,
    SUM(sales) AS total_sales
FROM sales.orders
GROUP BY DATE_TRUNC('month', orderdate);



-- Remove an existing view
DROP VIEW sales.monthly_sales;



-- CREATE OR REPLACE updates an existing view definition
-- without requiring the view to be dropped first.
CREATE OR REPLACE VIEW sales.monthly_sales AS
SELECT
    DATE_TRUNC('month', orderdate) AS month,
    SUM(sales) AS total_sales,
    AVG(sales) AS average_sale
FROM sales.orders
GROUP BY DATE_TRUNC('month', orderdate);



-- Running total of monthly sales
SELECT
    month,
    total_sales,
    SUM(total_sales) OVER (ORDER BY month) AS running_total
FROM sales.monthly_sales;



-- ============================================================================
-- Example 2: Business Reporting View
-- Combine data from multiple tables into a single reusable reporting view.
-- ============================================================================

CREATE OR REPLACE VIEW sales.v_order_details AS
SELECT
    o.orderid,
    o.orderdate,

    p.product,
    p.category,
    p.price,

    -- CONCAT_WS = CONCAT With Separator
    --
    -- Syntax:
    -- CONCAT_WS(separator, value1, value2, ...)
    --
    -- Unlike CONCAT(), CONCAT_WS() automatically ignores NULL values.
    --
    -- Example:
    -- CONCAT_WS(' ', 'John', 'Smith')
    -- Result: John Smith
    --
    -- CONCAT_WS(' ', 'John', NULL)
    -- Result: John
    --
    CONCAT_WS(' ', c.firstname, c.lastname) AS customer_name,

    c.country AS customer_country,

    -- Alternative approach using COALESCE
    -- COALESCE replaces NULL with an empty string.
    -- TRIM removes any extra leading/trailing spaces.
    TRIM(
        COALESCE(e.firstname, '') || ' ' ||
        COALESCE(e.lastname, '')
    ) AS employee_name,

    e.department,

    o.sales,
    o.quantity

FROM sales.orders AS o

LEFT JOIN sales.products AS p
    ON o.productid = p.productid

LEFT JOIN sales.customers AS c
    ON o.customerid = c.customerid

LEFT JOIN sales.employees AS e
    ON o.salespersonid = e.employeeid;



-- Query the view like a regular table
SELECT *
FROM sales.v_order_details;



-- ============================================================================
-- Example 3: Security-Focused View
-- Create a restricted view for the EU sales team.
--
-- The view excludes customers from the USA.
-- Users can query the view without directly accessing base tables.
-- ============================================================================

CREATE OR REPLACE VIEW sales.v_order_details_eu AS
SELECT
    o.orderid,
    o.orderdate,

    p.product,
    p.category,
    p.price,

    CONCAT_WS(' ', c.firstname, c.lastname) AS customer_name,

    c.country AS customer_country,

    TRIM(
        COALESCE(e.firstname, '') || ' ' ||
        COALESCE(e.lastname, '')
    ) AS employee_name,

    e.department,

    o.sales,
    o.quantity

FROM sales.orders AS o

LEFT JOIN sales.products AS p
    ON o.productid = p.productid

LEFT JOIN sales.customers AS c
    ON o.customerid = c.customerid

LEFT JOIN sales.employees AS e
    ON o.salespersonid = e.employeeid

WHERE c.country <> 'USA';



SELECT *
FROM sales.v_order_details_eu;



-- ============================================================================
-- Common Real-World Use Cases of Views
-- ============================================================================
--
-- 1. Business Reporting
--    Create reusable reports for sales, finance, HR, etc.
--
-- 2. Data Security
--    Hide sensitive columns (salary, personal information)
--    or restrict rows using filters.
--
-- 3. Reusable Business Logic
--    Centralize complex joins and calculations in one place.
--
-- 4. Simplify Complex Queries
--    Users query a view instead of writing long joins.
--
-- 5. Data Warehousing (DWH)
--    Create Virtual Data Marts for different departments.
--
-- 6. Multiple Language Support
--    Create localized views for different regions.
--
-- 7. Data Abstraction Layer
--    Applications can query views without knowing
--    underlying table structures.
--
-- 8. Flexibility
--    Underlying tables can change while keeping
--    the same view interface for users.
--
-- ============================================================================
-- Important Limitation
-- ============================================================================
--
-- Standard Views do NOT store data.
-- Every time a view is queried, PostgreSQL executes the underlying query.
--
-- For expensive calculations queried frequently,
-- PostgreSQL provides:
--
-- MATERIALIZED VIEW
--
-- which physically stores the query result for faster access.