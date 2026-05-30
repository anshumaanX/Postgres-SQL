-- =========================================================
-- MULTI-TABLE JOIN
-- Database: PostgreSQL
-- Description:
-- This query demonstrates how to join multiple tables
-- together in a single query.
--
-- Objective:
-- Retrieve order details along with related customer,
-- product, and employee information.
--
-- Tables Used:
-- 1. sales.orders
-- 2. sales.customers
-- 3. sales.products
-- 4. sales.employees
--
-- Relationship Overview:
-- orders.customerid     -> customers.customerid
-- orders.productid      -> products.productid
-- orders.salespersonid  -> employees.employeeid
-- =========================================================


-- =========================================================
-- RETRIEVE COMPLETE ORDER DETAILS
-- =========================================================
-- For each order, display:
-- 1. Order ID
-- 2. Customer Name
-- 3. Product Name
-- 4. Sales Amount
-- 5. Product Price
-- 6. Salesperson Name
--
-- LEFT JOIN is used to ensure that all orders are returned
-- even if related records are missing in other tables.
SELECT
    o.orderid,
    o.sales,

    -- Customer information
    c.firstname AS customer_first_name,

    -- Product information
    p.product,
    p.price,

    -- Employee / salesperson information
    e.firstname AS employee_first_name

FROM sales.orders AS o

-- Join customers table
LEFT JOIN sales.customers AS c
ON o.customerid = c.customerid

-- Join products table
LEFT JOIN sales.products AS p
ON o.productid = p.productid

-- Join employees table
LEFT JOIN sales.employees AS e
ON o.salespersonid = e.employeeid;


-- =========================================================
-- QUERY EXPLANATION
-- =========================================================
-- o -> Alias for orders table
-- c -> Alias for customers table
-- p -> Alias for products table
-- e -> Alias for employees table
--
-- Aliases help make queries shorter and more readable.
--
-- LEFT JOIN keeps all records from the orders table
-- and retrieves matching records from related tables.
--
-- If matching data does not exist in joined tables,
-- PostgreSQL returns NULL values for those columns.