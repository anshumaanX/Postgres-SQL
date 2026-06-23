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

## ✅ Ranking Functions

### Functions Covered

* `ROW_NUMBER()`
* `RANK()`
* `DENSE_RANK()`

### Use Cases

* Top-N Analysis
* Bottom-N Analysis
* Deduplication
* Leaderboards
* Unique Row Identification

---

## ✅ Distribution Functions

### Functions Covered

* `NTILE()`
* `CUME_DIST()`
* `PERCENT_RANK()`

### Use Cases

* Percentile Analysis
* Product Segmentation
* Customer Segmentation
* Top X% Analysis
* Workload Distribution
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
* Comparing Against Aggregates
* Ranking Results
* Customer Order Analysis
* Product Price Analysis

---

## ✅ Common Table Expressions (CTEs)

### Non-Recursive CTEs

* Single CTE
* Multiple CTEs
* Nested CTEs
* Modular Query Design

### Use Cases

* Breaking Complex Queries into Steps
* Customer Segmentation
* Customer Ranking
* Sales Analysis
* Last Order Analysis

---

## ✅ Recursive CTEs

### Concepts Covered

* Anchor Query
* Recursive Query
* Recursion Stop Condition

### Examples Implemented

* Number Series Generation
* Employee Hierarchy Traversal

### Real-World Use Cases

* Organizational Charts
* Employee-Manager Relationships
* Parent-Child Hierarchies
* Category Trees
* Graph Traversal

---

# 📌 Current Progress

### Completed Topics

* SQL Fundamentals
* DDL (Data Definition Language)
* DML (Data Manipulation Language)
* SQL Operators
* Basic Joins
* Advanced Joins
* Multi-Table Joins
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
* Ranking Functions
* Distribution Functions
* Window Value Functions
* Subqueries
* Common Table Expressions (CTEs)
* Recursive CTEs

---

### Upcoming Topics

* Views
* Stored Procedures
* User Defined Functions (UDFs)
* Temporary Tables
* Indexes
* Constraints (Advanced)
* Transactions (TCL)
* Query Optimization
* Performance Tuning
* PostgreSQL Advanced Concepts

---

# 🎯 Learning Goals

This repository aims to:

* Build strong SQL fundamentals
* Learn PostgreSQL through practical examples
* Write clean and professional SQL queries
* Understand real-world business use cases
* Prepare for Data Analyst and Data Engineer roles
* Develop interview-ready SQL skills

---

# 🛠️ Tools Used

* PostgreSQL
* pgAdmin
* SQL

---

# 💡 Notes

* All queries are professionally formatted.
* Every topic contains detailed comments and explanations.
* Real-world examples are included wherever possible.
* PostgreSQL-specific best practices are highlighted.
* Concepts progress from beginner fundamentals to advanced analytical SQL.
* The repository is continuously updated as new topics are learned.

---

# 🤝 Contributions

This repository is primarily for personal learning and documentation. Suggestions, improvements, and discussions are always welcome.

---

# 📜 License

This repository is intended for educational and learning purposes.
