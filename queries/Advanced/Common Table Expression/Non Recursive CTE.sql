-- =========================================================
-- COMMON TABLE EXPRESSIONS (CTEs)
-- =========================================================
-- A CTE (Common Table Expression) is a temporary named
-- result set that exists only during the execution
-- of a query.
--
-- Think of a CTE as a temporary virtual table that
-- helps break complex logic into smaller, readable steps.
--
-- Benefits:
-- • Improves query readability
-- • Simplifies complex SQL logic
-- • Eliminates repeated subqueries
-- • Makes debugging easier
-- • Allows modular query design
--
-- Syntax:
--
-- WITH cte_name AS
-- (
--     query
-- )
-- SELECT *
-- FROM cte_name;
--
--
-- Types of CTEs:
--
-- 1. Non-Recursive CTE
--    Most common type.
--    Executes once and returns a result set.
--
-- 2. Recursive CTE
--    References itself and is commonly used for:
--    • Hierarchical data
--    • Organizational charts
--    • Parent-child relationships
--    • Generating sequences
--
--
-- Important Rules:
--
-- 1. A CTE exists only for the query immediately
--    following the WITH clause.
--
-- 2. Multiple CTEs can be defined in a single WITH block.
--
-- 3. One CTE can reference another CTE defined earlier.
--
-- 4. ORDER BY is generally not allowed inside a CTE
--    unless used with LIMIT/OFFSET/FETCH.
--
-- 5. CTEs improve readability but do not always improve
--    performance compared to subqueries.
--
--
-- =========================================================
-- BUSINESS PROBLEM
-- =========================================================
-- Generate a customer performance report showing:
--
-- • Customer details
-- • Total sales
-- • Last order date
-- • Sales rank
-- • Sales category
--
--
-- =========================================================
-- STEP 1: TOTAL SALES PER CUSTOMER
-- =========================================================
WITH CTE_Total_Sales AS
(
    SELECT
        customerid,
        SUM(sales) AS total_sales
    FROM sales.orders
    GROUP BY customerid
),

-- =========================================================
-- STEP 2: LAST ORDER DATE PER CUSTOMER
-- =========================================================
CTE_Last_Order_Date AS
(
    SELECT
        customerid,
        MAX(orderdate) AS last_order_date
    FROM sales.orders
    GROUP BY customerid
),

-- =========================================================
-- STEP 3: RANK CUSTOMERS BY TOTAL SALES
-- =========================================================
-- This CTE depends on CTE_Total_Sales.
-- Such CTEs are often called dependent CTEs.
CTE_Rank AS
(
    SELECT
        customerid,
        total_sales,

        RANK() OVER (
            ORDER BY total_sales DESC
        ) AS sales_rank

    FROM CTE_Total_Sales
),

-- =========================================================
-- STEP 4: CUSTOMER SEGMENTATION
-- =========================================================
-- Divide customers into 3 buckets using NTILE().
--
-- NTILE(3):
-- 1 = Lowest Sales Group
-- 2 = Medium Sales Group
-- 3 = Highest Sales Group
CTE_Category AS
(
    SELECT
        customerid,

        CASE
            WHEN NTILE(3) OVER (ORDER BY total_sales) = 1
                THEN 'Low'

            WHEN NTILE(3) OVER (ORDER BY total_sales) = 2
                THEN 'Medium'

            ELSE 'High'
        END AS category

    FROM CTE_Total_Sales
)

-- =========================================================
-- FINAL REPORT
-- =========================================================
SELECT
    c.customerid,
    c.firstname,
    c.lastname,

    cts.total_sales,

    lod.last_order_date,

    r.sales_rank,

    cat.category

FROM sales.customers AS c

LEFT JOIN CTE_Total_Sales AS cts
    ON c.customerid = cts.customerid

LEFT JOIN CTE_Last_Order_Date AS lod
    ON c.customerid = lod.customerid

LEFT JOIN CTE_Rank AS r
    ON c.customerid = r.customerid

LEFT JOIN CTE_Category AS cat
    ON c.customerid = cat.customerid

ORDER BY total_sales DESC NULLS LAST;

-- CTEs execute from top to bottom, so a CTE can reference only those defined before it.

/*| CTE                                       | Subquery                     |
| ----------------------------------------- | ---------------------------- |
| Easier to read                            | Can become difficult to read |
| Good for multi-step logic                 | Better for simple logic      |
| Can be reused multiple times in the query | Usually used once            |
| Supports recursion                        | Does not                     |
*/
