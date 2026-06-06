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

* `CREATE TABLE`
* `ALTER TABLE`
* `DROP TABLE`

### Constraints

* `PRIMARY KEY`
* `NOT NULL`

---

## ✅ DML (Data Manipulation Language)

* `INSERT`
* `UPDATE`
* `DELETE`
* `TRUNCATE`

### Data Loading Techniques

* Manual Inserts
* Insert from another table
* Data migration between tables

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
* Multi-table Join

---

## ✅ Set Operators

* `UNION`
* `UNION ALL`
* `EXCEPT`
* `INTERSECT`

### Topics Covered

* Rules of Set Operators
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
* PostgreSQL `::` Operator

### Conversions Covered

* String → Integer
* String → Date
* String → Timestamp

---

## ✅ Date Calculations

### Interval Operations

* `INTERVAL`
* Date Addition
* Date Subtraction

### Duration Calculations

* Date Difference
* Shipping Duration Analysis
* Employee Age Calculation

### Functions Covered

* `AGE`
* `EXTRACT`
* Date Arithmetic

---

## ✅ NULL Handling Functions

### NULL Functions

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

### Aggregate Functions Covered

* `COUNT`
* `SUM`
* `AVG`
* `MIN`
* `MAX`

### Concepts Covered

* Aggregate Calculations
* NULL Handling in Aggregates
* Summary Reports
* Business Metrics
* COUNT(*) vs COUNT(column)

---

## ✅ CASE Expressions

### CASE Statement Types

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

* Window Functions vs GROUP BY
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

* Month-over-Month Analysis (MoM)
* Trend Analysis
* Time Series Analysis
* Customer Retention Analysis
* Gap Analysis
* Baseline Comparisons

---

# 📌 Current Progress

### Completed Topics

* SQL Fundamentals
* DDL (Data Definition Language)
* DML (Data Manipulation Language)
* SQL Operators
* Basic Joins
* Advanced Joins
* Multi-table Joins
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

---

### Upcoming Topics

* Subqueries
* Common Table Expressions (CTEs)
* Views
* Stored Procedures
* User Defined Functions (UDFs)
* Temporary Tables
* Indexes
* Transactions
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
* Window Functions are covered from fundamentals to advanced analytical use cases.
* The repository is updated continuously as new concepts are learned.

---

# 🤝 Contributions

This repository is primarily for personal learning and documentation. Suggestions, improvements, and discussions are always welcome.

---

# 📜 License

This repository is intended for educational and learning purposes.
