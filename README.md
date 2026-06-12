# Retail Data Warehouse & Profitability Analytics

## Project Overview

This project is an end-to-end data engineering and analytics project focused on retail sales and profitability.

The goal is to build a data pipeline that ingests raw retail data, stores it in PostgreSQL, transforms it into analytics-ready warehouse tables, validates data quality, and supports business reporting through SQL and Power BI.

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

- Build a raw data ingestion pipeline
- Store raw data in PostgreSQL
- Create staging and warehouse layers
- Design fact and dimension tables
- Add data quality checks
- Use dbt for transformations
- Use orchestration for pipeline execution
- Perform SQL business analysis
- Build Power BI dashboards
- Document the full project for GitHub and interviews

## Tech Stack

- Python
- PostgreSQL
- SQL
- dbt Core
- Prefect or Airflow
- Power BI
- Git
- GitHub
- VS Code

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