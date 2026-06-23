-- =========================================================
-- RECURSIVE CTE (COMMON TABLE EXPRESSION)
-- =========================================================
-- A Recursive CTE is a CTE that references itself.
--
-- It is commonly used for:
-- • Hierarchical data
-- • Employee-Manager relationships
-- • Organization charts
-- • Folder structures
-- • Category trees
-- • Graph traversal
-- • Number generation
--
--
-- Structure of a Recursive CTE:
--
-- WITH RECURSIVE cte_name AS
-- (
--     -- Anchor Query
--     SELECT ...
--
--     UNION ALL
--
--     -- Recursive Query
--     SELECT ...
--     FROM cte_name
--     WHERE ...
-- )
-- SELECT *
-- FROM cte_name;
--
--
-- Execution Flow:
--
-- Step 1:
-- Execute the Anchor Query.
--
-- Step 2:
-- Execute the Recursive Query using the rows
-- returned from the previous iteration.
--
-- Step 3:
-- Repeat until no new rows are returned.
--
--
-- Important Rules:
--
-- 1. The recursive CTE must contain:
--    • Anchor Query
--    • Recursive Query
--
-- 2. Anchor and Recursive queries must have:
--    • Same number of columns
--    • Compatible data types
--
-- 3. UNION ALL is typically preferred.
--
-- 4. Always include a termination condition
--    to avoid infinite recursion.
--
-- 5. PostgreSQL stops recursion when no new
--    rows are produced.
--
--
-- =========================================================
-- EXAMPLE 1: GENERATE A NUMBER SERIES
-- =========================================================
-- Generate numbers from 1 to 20.
WITH RECURSIVE Series AS
(
    -- Anchor Query
    SELECT
        1 AS my_number

    UNION ALL

    -- Recursive Query
    SELECT
        my_number + 1
    FROM Series
    WHERE my_number < 20
)

SELECT *
FROM Series;


-- =========================================================
-- HOW IT WORKS
-- =========================================================
--
-- Iteration 1:
-- 1
--
-- Iteration 2:
-- 2
--
-- Iteration 3:
-- 3
--
-- ...
--
-- Iteration 20:
-- 20
--
-- Stop condition:
-- my_number < 20 becomes FALSE.
--
--
-- =========================================================
-- LIMIT DOES NOT STOP RECURSION
-- =========================================================
-- LIMIT only affects the final result set.
--
-- The recursive CTE still generates all rows
-- before LIMIT is applied.
--
-- Example:
SELECT *
FROM Series
LIMIT 10;


-- =========================================================
-- POSTGRESQL ALTERNATIVE
-- =========================================================
-- If only a number series is required,
-- PostgreSQL provides generate_series().
SELECT *
FROM generate_series(1, 20);

--
-- generate_series() is:
-- • Simpler
-- • Faster
-- • More efficient
--
-- However, Recursive CTEs are still important
-- because generate_series() cannot solve
-- hierarchical problems.


/*
Common Recursive CTE Use Cases

1. Employee Hierarchies
   CEO -> Manager -> Employee

2. Organization Charts

3. Folder Structures

4. Product Categories

5. Bill of Materials (BOM)

6. Parent-Child Relationships

7. Graph Traversal
*/


-- =========================================================
-- EXAMPLE 2: EMPLOYEE HIERARCHY
-- =========================================================
-- Display employees along with their level
-- in the organization.
--
-- Level 1 = Top Manager / CEO
-- Level 2 = Direct Reports
-- Level 3 = Reports of Level 2
-- etc.
WITH RECURSIVE CTE_Employee_Hierarchy AS
(
    -- Anchor Query
    -- Start with top-level employees
    -- who do not report to anyone.
    SELECT
        employeeid,
        firstname,
        managerid,
        1 AS level
    FROM sales.employees
    WHERE managerid IS NULL

    UNION ALL

    -- Recursive Query
    -- Find employees reporting to the
    -- employees found in the previous iteration.
    SELECT
        e.employeeid,
        e.firstname,
        e.managerid,
        ceh.level + 1
    FROM sales.employees AS e
    INNER JOIN CTE_Employee_Hierarchy AS ceh
        ON e.managerid = ceh.employeeid
)

SELECT
    *
FROM CTE_Employee_Hierarchy
ORDER BY level, employeeid;


-- =========================================================
-- HIERARCHY EXECUTION EXAMPLE
-- =========================================================
--
-- CEO (Level 1)
--   ├── Manager A (Level 2)
--   │      ├── Employee A1 (Level 3)
--   │      └── Employee A2 (Level 3)
--   │
--   └── Manager B (Level 2)
--          └── Employee B1 (Level 3)
--
-- The recursive query keeps finding
-- employees reporting to the previous level
-- until no more employees are found.