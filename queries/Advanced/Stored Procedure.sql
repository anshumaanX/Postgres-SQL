```sql
-- ============================================================
-- STORED PROCEDURES
-- ============================================================

-- A Stored Procedure is a database object that stores a block of SQL
-- and procedural code which can be executed whenever needed.
--
-- Advantages:
-- • Reusable business logic
-- • Better code organization
-- • Reduces duplicate SQL
-- • Supports variables, conditions, loops and exception handling
-- • Can return values using OUT parameters
--
-- Unlike functions, procedures are executed using CALL and can
-- perform transaction control (COMMIT / ROLLBACK).



-- ============================================================
-- STEP 1 : Write the SQL Query
-- ============================================================

-- Find the total number of customers and the average score
-- for customers from USA.

SELECT
    COUNT(*) AS total_customer,
    AVG(score) AS avg_score
FROM sales.customers
WHERE country = 'USA';



-- ============================================================
-- STEP 2 : Convert the Query into a Stored Procedure
-- ============================================================

CREATE OR REPLACE PROCEDURE get_usa_customer_stats
(
    -- INPUT parameter
    -- Country supplied by the user.
    -- If NULL is passed, USA will be used.
    IN p_country TEXT,

    -- OUTPUT parameters
    OUT total_customer BIGINT,
    OUT avg_score NUMERIC,
    OUT total_orders BIGINT,
    OUT total_sales NUMERIC
)

-- Language used inside the procedure.
LANGUAGE plpgsql

-- Dollar quoting.
-- Everything between $$ ... $$ becomes the procedure body.
AS
$$

-- ============================================================
-- DECLARE SECTION
-- Used for declaring local variables.
-- ============================================================

DECLARE

    -- Local variable
    -- COALESCE() makes USA the default country.
    v_country TEXT := COALESCE(p_country, 'USA');

BEGIN

    -- ========================================================
    -- IF Statement
    -- Check whether any customer has a NULL score.
    -- ========================================================

    IF EXISTS
    (
        SELECT 1
        FROM sales.customers
        WHERE score IS NULL
          AND country = v_country
    )
    THEN

        RAISE NOTICE 'Updating NULL score to 0';

        UPDATE sales.customers
        SET score = 0
        WHERE score IS NULL
          AND country = v_country;

    ELSE

        RAISE NOTICE 'No NULL score found';

    END IF;



    -- ========================================================
    -- Generate Customer Statistics
    --
    -- INTO stores query results into variables.
    -- ========================================================

    SELECT
        COUNT(*),
        AVG(score)
    INTO
        total_customer,
        avg_score
    FROM sales.customers
    WHERE country = v_country;


    RAISE NOTICE 'Country           : %', v_country;
    RAISE NOTICE 'Total Customers   : %', total_customer;
    RAISE NOTICE 'Average Score     : %', avg_score;



    -- ========================================================
    -- Generate Order Statistics
    -- ========================================================

    SELECT
        COUNT(*),
        SUM(sales)

    INTO
        total_orders,
        total_sales

    FROM sales.orders AS o
    INNER JOIN sales.customers AS c
        ON o.customerid = c.customerid

    WHERE c.country = v_country;


    RAISE NOTICE 'Total Orders      : %', total_orders;
    RAISE NOTICE 'Total Sales       : %', total_sales;



-- ============================================================
-- Exception Handling
-- Executes only if any error occurs.
-- SQLERRM contains the error message.
-- ============================================================

EXCEPTION

    WHEN OTHERS THEN

        RAISE NOTICE 'Error : %', SQLERRM;

END;

$$;



-- ============================================================
-- Execute Procedure
-- ============================================================

-- Germany
CALL get_usa_customer_stats
(
    'Germany',
    NULL,
    NULL,
    NULL,
    NULL
);

-- Default Country (USA)
CALL get_usa_customer_stats
(
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
);



-- ============================================================
-- Drop Procedure
-- ============================================================

-- If the procedure signature changes (parameters are added,
-- removed or datatype changes), PostgreSQL requires dropping
-- the old procedure first.

DROP PROCEDURE get_usa_customer_stats(TEXT);



-- ============================================================
-- Query used inside the procedure
-- (Added for learning purposes)
-- ============================================================

SELECT
    COUNT(*) AS total_orders,
    SUM(sales) AS total_sales
FROM sales.orders AS o
INNER JOIN sales.customers AS c
    ON o.customerid = c.customerid
WHERE c.country = 'USA';
```
