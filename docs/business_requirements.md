# Business Requirements

## Project Title

Retail Data Engineering Pipeline with AWS S3, PostgreSQL, dbt & Power BI

## Business Scenario

A retail company receives raw sales transaction data from its operational systems. The raw data contains order details, customer information, product information, geographic information, sales, discounts, quantity, shipping mode, and profit.

The company wants to build a reliable cloud-enabled data pipeline and analytics warehouse that allows business teams to analyze sales performance, profitability, product performance, regional performance, customer segments, and discount impact.

## Business Problem

The company has raw retail sales data, but the data is not structured for reliable analytics. Business users need clean, validated, and analytics-ready tables that can support SQL analysis and Power BI reporting.

The business also wants the raw data to be stored in a cloud data lake so that it can be cataloged, preserved, and reused by downstream data pipelines.

## Project Objectives

The objective of this project is to build an end-to-end data engineering and analytics solution that:

* Stores raw retail data in AWS S3 as a cloud raw data lake zone
* Uses AWS Glue Crawler and Glue Data Catalog for metadata discovery
* Ingests S3 raw data into PostgreSQL using Python
* Stores source-level data in a PostgreSQL raw schema
* Creates cleaned staging models
* Builds warehouse tables using a star schema
* Validates data quality
* Supports SQL business analysis
* Supports Power BI reporting
* Provides business recommendations to improve profitability

## Key Business Questions

1. What are total sales, total profit, and profit margin?
2. Which product categories and sub-categories generate the most sales?
3. Which products are loss-making?
4. Which regions, states, and cities are most and least profitable?
5. How do discounts affect profitability?
6. Which customer segments are most valuable?
7. What are monthly sales and profit trends?
8. Which shipping modes are used most often?
9. Which business areas should be prioritized to improve profit?

## Key Performance Indicators

* Total Sales
* Total Profit
* Profit Margin
* Total Orders
* Total Customers
* Average Order Value
* Average Discount
* Sales by Category
* Profit by Category
* Sales by Region
* Profit by Region
* Monthly Sales Trend
* Monthly Profit Trend
* Discount Impact on Profit
* Loss-Making Products

## Stakeholders

* Executive Leadership
* Sales Managers
* Finance Team
* Operations Team
* Regional Managers
* Business Intelligence Team
* Data Engineering Team

## Data Engineering Requirements

The data pipeline should:

* Preserve the original raw dataset
* Upload raw data to AWS S3
* Organize S3 data using a clear folder structure
* Catalog raw data using AWS Glue
* Load raw data from S3 into PostgreSQL
* Separate database layers into raw, staging, and marts
* Standardize column names
* Convert date fields into proper date types
* Convert numeric fields into appropriate numeric types
* Check for missing values and duplicates
* Support repeatable pipeline execution
* Keep documentation updated in GitHub

## Analytics Requirements

The analytics layer should support:

* Sales performance reporting
* Profitability analysis
* Product and category analysis
* Regional performance analysis
* Customer segment analysis
* Discount impact analysis
* Power BI dashboards
* Business recommendations

## Expected Output

The final solution should include:

* AWS S3 raw data lake zone
* AWS Glue Crawler and Data Catalog metadata
* Python ingestion pipeline
* PostgreSQL raw, staging, and mart layers
* dbt transformation models
* Data quality checks
* SQL analysis queries
* Power BI dashboard screenshots
* Business insights report
* Architecture documentation
* Professional GitHub README
