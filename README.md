# PostgreSQL SQL Learning Journey 🚀

A comprehensive PostgreSQL SQL learning repository covering concepts from **beginner to advanced level** with properly structured queries, detailed explanations, best practices, and real-world examples.

This repository documents my hands-on journey of learning PostgreSQL while building a solid foundation in SQL for data analytics, data engineering, and backend development.

---

# 📚 Topics Covered

## ✅ SQL Fundamentals

* SELECT statements
* Column selection
* Filtering data with `WHERE`
* Sorting using `ORDER BY`
* Aggregation with `GROUP BY`
* Filtering groups using `HAVING`
* Unique values with `DISTINCT`
* Limiting results using `LIMIT`

---

## ✅ DDL (Data Definition Language)

### Commands Covered

* `CREATE TABLE`
* `ALTER TABLE`
* `DROP TABLE`

### Constraints

* `PRIMARY KEY`
* `NOT NULL`

---

## ✅ DML (Data Manipulation Language)

### Commands Covered

* `INSERT`
* `UPDATE`
* `DELETE`
* `TRUNCATE`

### Data Loading Techniques

* Manual Inserts
* Insert from Another Table
* Data Migration Between Tables

---

## ✅ SQL Operators

### Comparison Operators

* `=`
* `!=`
* `<>`
* `>`
* `<`
* `>=`
* `<=`

### Logical Operators

* `AND`
* `OR`
* `NOT`

### Range & Membership Operators

* `BETWEEN`
* `IN`
* `NOT IN`

### Search Operators

* `LIKE`

---

## ✅ SQL Joins

### Basic Joins

* `INNER JOIN`
* `LEFT JOIN`
* `RIGHT JOIN`
* `FULL JOIN`

### Advanced Joins

* Left Anti Join
* Right Anti Join
* Full Anti Join
* Cross Join
* Multi-Table Join

---

## ✅ Set Operators

### Operators Covered

* `UNION`
* `UNION ALL`
* `EXCEPT`
* `INTERSECT`

### Concepts Covered

* Set Operator Rules
* Combining Data from Multiple Tables
* Delta Detection
* Data Completeness Checks

---

## ✅ String Functions

### Text Transformation

* `CONCAT`
* `CONCAT_WS`
* `UPPER`
* `LOWER`
* `TRIM`
* `REPLACE`

### String Analysis

* `LENGTH`

### String Extraction

* `LEFT`
* `RIGHT`
* `SUBSTRING`

---

## ✅ Number Functions

* `ROUND`
* `ABS`

---

## ✅ Date & Time Functions

### Date Part Extraction

* `EXTRACT`
* `DATE_PART`

### Date Formatting

* `TO_CHAR`
* Custom Date Formats

### Date Truncation

* `DATE_TRUNC`

### Reporting Use Cases

* Monthly Reports
* Yearly Reports
* Date Filtering
* End-of-Month Calculations

---

## ✅ Formatting & Casting

### Formatting

* Date Formatting using `TO_CHAR`
* Month, Day, Quarter, Week Formatting
* Custom Timestamp Formatting

### Type Conversion

* `CAST()`
* PostgreSQL `::` Casting Operator

### Conversions Covered

* String → Integer
* String → Date
* String → Timestamp

---

## ✅ Date Calculations

### Functions Covered

* `INTERVAL`
* `AGE`
* Date Arithmetic
* Date Difference Calculations

### Use Cases

* Date Addition
* Date Subtraction
* Shipping Duration Analysis
* Employee Age Analysis

---

## ✅ NULL Handling Functions

### Functions Covered

* `COALESCE`
* `NULLIF`

### NULL Filtering

* `IS NULL`
* `IS NOT NULL`

### Real-World Use Cases

* Replacing Missing Values
* Preventing Division by Zero
* Handling NULLs in String Concatenation
* Sorting NULL Values
* Finding Missing Relationships Using Joins

---

## ✅ Aggregate Functions

### Functions Covered

* `COUNT`
* `SUM`
* `AVG`
* `MIN`
* `MAX`

### Concepts Covered

* Aggregate Calculations
* Summary Reports
* Business Metrics
* NULL Handling in Aggregates
* `COUNT(*)` vs `COUNT(column)`

---

## ✅ CASE Expressions

### CASE Types

* Searched CASE
* Simple CASE

### Use Cases

* Data Categorization
* Value Mapping
* Conditional Aggregation
* NULL Handling
* Data Transformation

### Business Scenarios

* Sales Segmentation
* Gender Mapping
* Country Code Mapping
* Customer Score Analysis

---

## ✅ Window Functions

### Core Concepts

* Window Functions vs `GROUP BY`
* Partitions
* Window Ordering
* Frame Clauses
* Window Processing Rules

### Clauses Covered

* `PARTITION BY`
* `ORDER BY`
* `ROWS`
* `RANGE`

### Analysis Types

* Running Calculations
* Rolling Calculations
* Group-Level Analysis with Row-Level Detail

---

## ✅ Window Aggregate Functions

### Functions Covered

* `COUNT() OVER()`
* `SUM() OVER()`
* `AVG() OVER()`
* `MIN() OVER()`
* `MAX() OVER()`

### Use Cases

* Running Totals
* Rolling Totals
* Running Averages
* Percentage Contribution Analysis
* Duplicate Detection
* Data Quality Checks
* Deviation Analysis

---

## ✅ Ranking & Distribution Functions

### Ranking Functions

* `ROW_NUMBER()`
* `RANK()`
* `DENSE_RANK()`

### Distribution Functions

* `NTILE()`
* `CUME_DIST()`
* `PERCENT_RANK()`

### Business Use Cases

* Top-N Analysis
* Bottom-N Analysis
* Leaderboards
* Deduplication
* Customer Segmentation
* Product Segmentation
* Percentile Analysis
* Batch Processing

---

## ✅ Window Value Functions

### Functions Covered

* `LAG()`
* `LEAD()`
* `FIRST_VALUE()`
* `LAST_VALUE()`

### Analytical Use Cases

* Month-over-Month (MoM) Analysis
* Trend Analysis
* Time Series Analysis
* Customer Retention Analysis
* Gap Analysis
* Baseline Comparisons

---

## ✅ Subqueries

### Types Covered

* Scalar Subqueries
* Multi-Row Subqueries
* Derived Tables (Inline Views)
* Correlated Subqueries
* Non-Correlated Subqueries

### Operators Covered

* `IN`
* `EXISTS`
* `ANY`
* `ALL`

### Use Cases

* Filtering Data
* Aggregate Comparisons
* Ranking Results
* Customer Order Analysis
* Product Price Analysis

---

## ✅ Common Table Expressions (CTEs)

### Non-Recursive CTEs

* Single CTE
* Multiple CTEs
* Nested CTEs

### Recursive CTEs

* Anchor Query
* Recursive Query
* Stop Condition

### Real-World Examples

* Number Series Generation
* Employee Hierarchies
* Customer Ranking
* Customer Segmentation
* Modular Query Design

---

## ✅ Views

### Concepts Covered

* Creating Views
* `CREATE OR REPLACE VIEW`
* Dropping Views
* Virtual Tables
* Reusable SQL Logic

### Business Use Cases

* Monthly Sales Reporting
* Multi-Table Reporting Views
* Security-Based Views
* Data Abstraction
* Simplifying Complex Queries

---

## ✅ CTAS (CREATE TABLE AS)

### Concepts Covered

* Creating Tables from Query Results
* Materializing Query Output
* Snapshot Creation

### Business Use Cases

* Performance Optimization
* Data Warehousing
* Reporting Tables
* Physical Data Marts
* Historical Snapshots

---

## ✅ Temporary Tables

### Concepts Covered

* `CREATE TEMP TABLE`
* `CREATE TEMPORARY TABLE`
* Session Scope
* Temporary Schema (`pg_temp`)

### Business Use Cases

* Intermediate Calculations
* ETL Processing
* Staging Data
* Data Cleansing
* Breaking Complex Processes into Steps

---

## ✅ Stored Procedures

### Concepts Covered

* Creating Stored Procedures
* `CREATE OR REPLACE PROCEDURE`
* Input (`IN`) Parameters
* Output (`OUT`) Parameters
* Local Variables (`DECLARE`)
* Conditional Logic (`IF...ELSE`)
* Exception Handling
* `RAISE NOTICE`
* Calling Procedures (`CALL`)
* Dropping Procedures (`DROP PROCEDURE`)

### PL/pgSQL Features

* Variables
* Control Flow
* SQL inside Procedures
* `SELECT ... INTO`
* Error Handling using `EXCEPTION`
* Default Values using `COALESCE`

### Business Use Cases

* Automated Report Generation
* Customer Statistics
* Sales Summary Reports
* Data Validation
* Data Cleaning
* Reusable Business Logic


## ✅ Triggers

### Concepts Covered

* What are Triggers?
* Trigger Timing (BEFORE, AFTER)
* Trigger Events (INSERT, UPDATE, DELETE)
* Row-Level Triggers (FOR EACH ROW)
* Creating Trigger Functions
* Creating Triggers
* Dropping Triggers

### PL/pgSQL Features

* RETURNS TRIGGER
* NEW and OLD Records
* Trigger Variables
* RETURN NEW
* RETURN OLD

### Business Use Cases

* Audit Logging
* Automatic Data Formatting
* Data Validation
* Enforcing Business Rules
* Maintaining History Tables
* Automatic Timestamp Updates
* Inventory Management
* Synchronizing Related Tables

---
# 📌 Current Progress

### ✅ Completed Topics

* SQL Fundamentals
* DDL (Data Definition Language)
* DML (Data Manipulation Language)
* SQL Operators
* SQL Joins
* Set Operators
* String Functions
* Number Functions
* Date & Time Functions
* Formatting & Casting
* Date Calculations
* NULL Handling Functions
* Aggregate Functions
* CASE Expressions
* Window Functions
* Window Aggregate Functions
* Ranking & Distribution Functions
* Window Value Functions
* Subqueries
* Common Table Expressions (CTEs)
* Recursive CTEs
* Views
* CTAS (CREATE TABLE AS)
* Temporary Tables
* Stored Procedures
* Triggers

---

### 🚀 Upcoming Topics

* PostgreSQL Advanced Concepts

---

# 🎯 Learning Goals

This repository aims to:

* Build strong SQL fundamentals.
* Master PostgreSQL through practical examples.
* Write clean, readable, and optimized SQL queries.
* Understand real-world business scenarios and analytical use cases.
* Prepare for Data Analyst, Data Engineer, and Backend Developer roles.
* Develop interview-ready SQL skills from beginner to advanced level.

---

# 🛠️ Tools Used

* PostgreSQL
* pgAdmin
* SQL

---

# 💡 Notes

* Every topic includes well-commented SQL queries.
* Concepts are explained from beginner to advanced level.
* Real-world business scenarios accompany most examples.
* PostgreSQL best practices and syntax are highlighted throughout.
* The repository progresses from SQL fundamentals to advanced analytical SQL and database design concepts.
* New topics are added continuously as the learning journey progresses.

---

# 🤝 Contributions

This repository primarily serves as a personal learning resource and documentation. Suggestions, improvements, and discussions are always welcome.

---

# 📜 License

This repository is intended for educational and learning purposes.
