-- ==========================================================
-- TRIGGERS
-- ==========================================================
-- A trigger is a special database object that automatically
-- executes a function when a specified event occurs on a table
-- or view.
--
-- Common Events:
-- • INSERT
-- • UPDATE
-- • DELETE
--
-- Trigger Timing:
-- • BEFORE  -> Executes before the event.
-- • AFTER   -> Executes after the event.
-- • INSTEAD OF -> Used with views.
--
-- Trigger Levels:
-- • FOR EACH ROW       -> Executes once for every affected row.
-- • FOR EACH STATEMENT -> Executes once per SQL statement.
--
-- Common Use Cases:
-- • Audit Logging
-- • Data Validation
-- • Automatic Formatting
-- • Maintaining History Tables
-- • Enforcing Business Rules
-- ==========================================================


-- ==========================================================
-- Sample Tables
-- ==========================================================

CREATE TABLE employees (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT
);

CREATE TABLE employee_log (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    employee_id INT NOT NULL,
    action TEXT NOT NULL,
    logged_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- ==========================================================
-- Trigger Function
-- ==========================================================
-- Trigger functions must:
-- 1. RETURN TRIGGER
-- 2. Have no parameters
-- 3. Return NEW for INSERT/UPDATE
-- 4. Return OLD for DELETE
--
-- NEW -> New row being inserted/updated
-- OLD -> Existing row being deleted/updated
-- ==========================================================


-- ==========================================================
-- BEFORE INSERT Trigger
-- Automatically convert employee names to uppercase before
-- inserting into the table.
-- ==========================================================

CREATE OR REPLACE FUNCTION uppercase_name()
RETURNS TRIGGER
AS $$
BEGIN

    NEW.name := UPPER(NEW.name);

    RETURN NEW;

END;
$$
LANGUAGE plpgsql;


CREATE TRIGGER before_insert_employee
BEFORE INSERT
ON employees
FOR EACH ROW
EXECUTE FUNCTION uppercase_name();


INSERT INTO employees(name)
VALUES ('Maria');

SELECT *
FROM employees;


-- ==========================================================
-- AFTER INSERT Trigger
-- Automatically create an audit log whenever a new employee
-- is inserted.
-- ==========================================================

CREATE OR REPLACE FUNCTION log_employee_insert()
RETURNS TRIGGER
AS $$
BEGIN

    INSERT INTO employee_log(employee_id, action)
    VALUES (NEW.id, 'INSERT');

    RETURN NEW;

END;
$$
LANGUAGE plpgsql;


CREATE TRIGGER after_employee_insert
AFTER INSERT
ON employees
FOR EACH ROW
EXECUTE FUNCTION log_employee_insert();


SELECT *
FROM employee_log;


-- ==========================================================
-- AFTER DELETE Trigger
-- Automatically log deleted employees.
-- ==========================================================

CREATE OR REPLACE FUNCTION log_employee_delete()
RETURNS TRIGGER
AS $$
BEGIN

    INSERT INTO employee_log(employee_id, action)
    VALUES (OLD.id, 'DELETE');

    RETURN OLD;

END;
$$
LANGUAGE plpgsql;


CREATE TRIGGER after_delete_employee
AFTER DELETE
ON employees
FOR EACH ROW
EXECUTE FUNCTION log_employee_delete();


DELETE
FROM employees
WHERE id = 2;


SELECT *
FROM employee_log;


-- ==========================================================
-- Useful Trigger Variables
-- ==========================================================
-- NEW        -> New row (INSERT/UPDATE)
-- OLD        -> Previous row (UPDATE/DELETE)
-- TG_NAME    -> Trigger name
-- TG_TABLE_NAME -> Table name
-- TG_OP      -> Operation (INSERT, UPDATE, DELETE)
-- TG_WHEN    -> BEFORE / AFTER / INSTEAD OF
-- ==========================================================


-- ==========================================================
-- Trigger Execution Order
-- ==========================================================
-- INSERT
-- BEFORE INSERT Trigger
--        ↓
-- Row Inserted
--        ↓
-- AFTER INSERT Trigger
--
--
-- UPDATE
-- BEFORE UPDATE Trigger
--        ↓
-- Row Updated
--        ↓
-- AFTER UPDATE Trigger
--
--
-- DELETE
-- BEFORE DELETE Trigger
--        ↓
-- Row Deleted
--        ↓
-- AFTER DELETE Trigger
-- ==========================================================


-- ==========================================================
-- Real-World Use Cases
-- ==========================================================
-- • Audit Logging
-- • Automatic Timestamp Updates
-- • History Tables
-- • Prevent Invalid Updates
-- • Data Validation
-- • Automatic Data Formatting
-- • Inventory Management
-- • Synchronizing Related Tables
-- ==========================================================