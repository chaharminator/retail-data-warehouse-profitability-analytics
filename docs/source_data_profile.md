# Source Data Profile

## Dataset Overview

The project uses a Superstore retail sales dataset as the raw source file for the data engineering pipeline.

Raw file location:

```text
data/raw/superstore_sales.csv
```

## Initial Source Profile

| Metric                      |  Value |
| --------------------------- | -----: |
| Total Rows                  | 10,194 |
| Total Columns               |     21 |
| Duplicate Rows              |      0 |
| Columns with Missing Values |      0 |

## Source Columns

The raw dataset contains the following columns:

```text
Row ID
Order ID
Order Date
Ship Date
Ship Mode
Customer ID
Customer Name
Segment
Country/Region
City
State/Province
Postal Code
Region
Product ID
Category
Sub-Category
Product Name
Sales
Quantity
Discount
Profit
```

## Data Types Observed

| Column Type         | Columns                                                                                                                                                               |
| ------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Integer             | Row ID, Quantity                                                                                                                                                      |
| Decimal             | Sales, Discount, Profit                                                                                                                                               |
| Text                | Order ID, Ship Mode, Customer ID, Customer Name, Segment, Country/Region, City, State/Province, Postal Code, Region, Product ID, Category, Sub-Category, Product Name |
| Date stored as text | Order Date, Ship Date                                                                                                                                                 |

## Data Quality Findings

The initial inspection found:

* The dataset contains 10,194 rows and 21 columns.
* No missing values were found.
* No duplicate rows were found.
* Date fields are currently stored as text and will need to be converted into proper date types.
* Sales, Discount, and Profit are stored as decimal numeric fields.
* Quantity is stored as an integer.
* The first column initially showed a hidden encoding marker because the CSV contained a BOM character. This will be handled during ingestion using UTF-8 with BOM support.

## Transformation Requirements

Based on the initial profile, the pipeline should:

1. Standardize column names into database-friendly snake_case.
2. Convert `Order Date` and `Ship Date` into proper date columns.
3. Convert monetary and numeric columns into appropriate numeric data types.
4. Preserve the raw source file unchanged.
5. Load raw data into PostgreSQL before creating staging and warehouse models.
6. Create business-ready fact and dimension tables for analytics.

## Data Engineering Note

This source profiling step helps identify data structure, column names, data types, missing values, duplicates, and transformation requirements before building the ingestion pipeline.

In industry, source data profiling is usually performed before pipeline development to reduce ingestion errors and define data validation rules.
