# Retail Data Warehouse & Profitability Analytics

## Project Overview

This project is an end-to-end data engineering and analytics project focused on retail sales and profitability.

The goal is to build a cloud-enabled data pipeline that stores raw retail data in AWS S3, catalogs the data using AWS Glue, ingests it into PostgreSQL, transforms it into analytics-ready warehouse tables, validates data quality, and supports business reporting through SQL and Power BI.

## Business Scenario

A retail company receives raw sales, customer, product, and regional data from different business systems. The raw data is not ready for analysis.

The business needs a reliable data warehouse that can support analysis of:

- Sales performance
- Profitability
- Product performance
- Regional performance
- Customer segments
- Discount impact

## Project Goals

* Store raw retail data in AWS S3 as a cloud raw data lake zone
* Use AWS Glue Crawler and Glue Data Catalog for metadata discovery
* Build a Python ingestion pipeline from S3 to PostgreSQL
* Store raw data in a PostgreSQL raw schema
* Create staging and warehouse layers
* Design fact and dimension tables using a star schema
* Add data quality checks
* Use dbt for transformations
* Use orchestration for pipeline execution
* Perform SQL business analysis
* Build Power BI dashboards
* Document the full project for GitHub and interviews


## Tech Stack

* AWS S3
* AWS Glue Crawler
* AWS Glue Data Catalog
* Python
* PostgreSQL
* SQL
* dbt Core
* Prefect or Airflow
* Power BI
* Git
* GitHub
* VS Code

## Planned Architecture

```text
Local Raw CSV
    ↓
AWS S3 Raw Data Lake Zone
    ↓
AWS Glue Crawler
    ↓
AWS Glue Data Catalog
    ↓
Python Ingestion from S3
    ↓
PostgreSQL Raw Schema
    ↓
dbt Staging Models
    ↓
dbt Mart Models / Star Schema
    ↓
SQL Business Analysis
    ↓
Power BI Dashboard
```

## Project Structure

```text
Retail-Data-Warehouse-Profitability-Analytics/
│
├── data/
│   ├── raw/
│   ├── processed/
│   └── README.md
│
├── scripts/
│
├── sql/
│
├── dbt/
│
├── orchestration/
│
├── dashboard/
│   └── README.md
│
├── images/
│
├── docs/
│   ├── business_requirements.md
│   ├── architecture.md
│   └── data_model.md
│
├── reports/
│   └── business_insights.md
│
├── requirements.txt
├── README.md
└── .gitignore