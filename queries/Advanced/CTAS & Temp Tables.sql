-- ============================================================================
-- CREATE TABLE AS (CTAS)
-- ============================================================================
-- CTAS (CREATE TABLE AS) creates a NEW physical table using the result
-- of a SELECT query.
--
-- Unlike a VIEW, CTAS stores the query result permanently.
-- The new table becomes independent of the source tables.
--
-- Syntax:
--
-- CREATE TABLE table_name AS
-- SELECT ...
--
-- ============================================================================


-- ============================================================================
-- CTAS vs VIEW
-- ============================================================================
--
-- VIEW
-- ----
-- • Virtual table (does not store data)
-- • Always shows the latest data
-- • Executes the underlying query every time
-- • Suitable for reusable reports and business logic
--
-- CTAS
-- ----
-- • Creates a physical table
-- • Stores data permanently
-- • Faster to query because data is already materialized
-- • Does NOT automatically reflect changes in source tables
-- • Useful for snapshots, reporting and performance optimization
--
-- Rule:
-- Use VIEW when data should always stay up to date.
-- Use CTAS when performance is more important than live data.
-- ============================================================================



-- ============================================================================
-- Use Case 1: Performance Optimization
--
-- Pre-compute monthly order statistics once and store them in a table.
-- Future queries read directly from this table instead of recalculating
-- the aggregation every time.
-- ============================================================================

CREATE TABLE sales.monthly_orders AS
SELECT
    DATE_TRUNC('month', orderdate) AS month_start,
    TO_CHAR(DATE_TRUNC('month', orderdate), 'Mon YYYY') AS month,
    COUNT(orderid) AS total_orders
FROM sales.orders
GROUP BY month_start
ORDER BY month_start;



SELECT *
FROM sales.monthly_orders;



-- Remove the table if it already exists.
DROP TABLE IF EXISTS sales.monthly_orders;



-- ============================================================================
-- Additional CTAS Use Cases
-- ============================================================================
--
-- 2. Data Transformation
--    Store cleaned or transformed data in a new table.
--
-- 3. Snapshot Tables
--    Capture data at a specific point in time.
--    Later changes to the source tables will NOT affect the snapshot.
--
-- 4. Physical Data Marts (Data Warehouse)
--    Create department-specific reporting tables
--    (Sales, HR, Finance, Marketing, etc.).
--
-- 5. Large Report Generation
--    Store expensive query results instead of recalculating them.
-- ============================================================================




-- ============================================================================
-- TEMPORARY TABLES
-- ============================================================================
-- Temporary tables are session-specific tables.
--
-- They behave like normal tables but exist only for the current session.
--
-- PostgreSQL automatically removes them when the session ends.
--
-- Useful for:
--
-- • Intermediate calculations
-- • ETL processes
-- • Staging data
-- • Breaking large queries into smaller steps
-- • Testing without affecting permanent tables
--
-- TEMP and TEMPORARY are identical keywords.
-- ============================================================================



-- Create a temporary table from a query
CREATE TEMP TABLE temp_table AS
SELECT *
FROM sales.orders;



-- Create an empty temporary table
CREATE TEMPORARY TABLE temp_table2
(
    id INT PRIMARY KEY,
    orders VARCHAR(50)
);



-- Remove temporary table manually (optional)
DROP TABLE IF EXISTS temp_table2;



-- Query the temporary table
SELECT *
FROM temp_table;



-- Temporary tables are internally stored
-- inside PostgreSQL's pg_temp schema.
SELECT *
FROM pg_temp.temp_table;



-- Modify temporary data safely without affecting the original table.
DELETE
FROM temp_table
WHERE orderstatus = 'Delivered';



-- Save processed temporary data permanently.
CREATE TABLE sales.orders_test AS
SELECT *
FROM temp_table;



SELECT *
FROM sales.orders_test;





-- ============================================================================
-- Comparison:
-- Subquery vs CTE vs View vs CTAS vs Temporary Table
-- ============================================================================

/*

----------------------------------------------------------------------------------------------
Feature            | Subquery | CTE | View | CTAS | Temporary Table
----------------------------------------------------------------------------------------------
Physical Storage   | No       | No  | No   | Yes  | Yes
----------------------------------------------------------------------------------------------
Lifetime           | One Query| One Query | Permanent | Permanent | Session
----------------------------------------------------------------------------------------------
Deleted            | After Query | After Query | DROP VIEW | DROP TABLE | Session Ends
----------------------------------------------------------------------------------------------
Scope              | Current Query | Current Query | Entire Database | Entire Database | Current Session
----------------------------------------------------------------------------------------------
Reusable           | No       | No  | Yes  | Yes  | Yes (Session Only)
----------------------------------------------------------------------------------------------
Always Up-to-Date  | Yes      | Yes | Yes  | No   | No
----------------------------------------------------------------------------------------------
Stores Data        | No       | No  | No   | Yes  | Yes
----------------------------------------------------------------------------------------------
Performance        | Normal   | Normal | Depends on Query | Fast | Fast
----------------------------------------------------------------------------------------------
Main Purpose

Subquery
- Small calculations
- Filtering
- Comparisons

CTE
- Improve readability
- Break complex queries into logical steps

View
- Reusable business logic
- Security
- Reporting

CTAS
- Performance optimization
- Snapshots
- Physical reporting tables

Temporary Table
- Intermediate processing
- ETL
- Staging
- Session-specific work

----------------------------------------------------------------------------------------------

Quick Rule to Remember

Need a quick calculation?
→ Subquery

Need readable SQL?
→ CTE

Need reusable logic?
→ View

Need better performance or a snapshot?
→ CTAS

Need temporary working data?
→ Temporary Table

----------------------------------------------------------------------------------------------

*/