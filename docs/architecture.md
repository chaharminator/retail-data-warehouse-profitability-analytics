# Architecture Documentation

## Project Architecture

This project follows a cloud-enabled data engineering and analytics architecture.

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

## Architecture Purpose

The purpose of this architecture is to simulate a real-world retail data pipeline where raw business data is first stored in a cloud data lake, cataloged for metadata discovery, ingested into a relational warehouse, transformed into analytics-ready tables, and finally used for business reporting.

This architecture shows both data engineering and analytics skills:

* Cloud raw data storage
* Metadata cataloging
* Python-based ingestion
* PostgreSQL warehouse storage
* dbt transformations
* Star schema modeling
* SQL analysis
* Power BI reporting

---

## Data Flow

### 1. Local Raw CSV

The original Superstore retail dataset is stored locally in:

```text
data/raw/superstore_sales.csv
```

This file represents the raw source data received from a business system.

The local raw file is kept unchanged for reproducibility and development.

---

### 2. AWS S3 Raw Data Lake Zone

The raw CSV file will be uploaded to Amazon S3.

S3 will act as the cloud raw data lake zone, where source data is stored before transformation.

Planned S3 structure:

```text
s3://retail-data-engineering-project-varun-2026/raw/superstore/superstore_sales.csv
```

In a real company, this layer helps keep source data centralized, durable, and accessible for downstream pipelines.

---

### 3. AWS Glue Crawler

AWS Glue Crawler will scan the raw file stored in S3.

The crawler will infer metadata such as:

* Column names
* Data types
* File format
* Table structure
* Source location

This helps automate metadata discovery instead of manually defining every column.

---

### 4. AWS Glue Data Catalog

The AWS Glue Data Catalog will store metadata about the raw dataset.

The catalog acts as a central metadata repository, allowing teams to discover available datasets and understand their structure.

In this project, Glue Data Catalog will be used to document the raw S3 dataset before ingestion into PostgreSQL.

---

### 5. Python Ingestion from S3

A Python ingestion script will read the raw CSV file from S3 and load it into PostgreSQL.

This step connects the cloud raw data lake layer to the relational warehouse layer.

The ingestion script will be responsible for:

* Connecting to AWS S3
* Reading the raw CSV file
* Standardizing column names for database usage
* Loading records into PostgreSQL
* Supporting repeatable pipeline execution

---

### 6. PostgreSQL Raw Schema

Raw data will be stored in PostgreSQL under the `raw` schema.

Initial table:

```text
raw.superstore_sales
```

The raw schema stores source-level data before transformation. This provides traceability and helps debug issues if later transformations produce unexpected results.

---

### 7. dbt Staging Models

dbt staging models will clean and standardize the raw data.

Staging transformations will include:

* Renaming columns into snake_case
* Converting order and ship dates into date types
* Converting numeric fields into appropriate data types
* Creating basic calculated fields if needed
* Preparing the dataset for warehouse modeling

Example staging model:

```text
staging.stg_superstore_sales
```

---

### 8. dbt Mart Models / Star Schema

The mart layer will contain analytics-ready fact and dimension tables.

Planned warehouse tables:

```text
marts.fact_sales
marts.dim_customer
marts.dim_product
marts.dim_date
marts.dim_region
```

The star schema will help make reporting faster, cleaner, and easier to understand.

Fact table:

```text
fact_sales
```

Dimension tables:

```text
dim_customer
dim_product
dim_date
dim_region
```

---

### 9. SQL Business Analysis

SQL analysis will be performed on the warehouse tables to answer business questions related to:

* Total sales
* Total profit
* Profit margin
* Product performance
* Category and sub-category performance
* Regional profitability
* Customer segment performance
* Discount impact

These SQL queries will validate that the warehouse supports real business analysis.

---

### 10. Power BI Dashboard

Power BI will connect to the warehouse tables and present executive-level business insights.

Planned dashboard pages:

```text
Executive Sales Summary
Product & Profitability Analysis
Regional & Customer Segment Analysis
```

The dashboard will help business stakeholders monitor sales, profit, discount impact, and underperforming areas.

---

## Database Layers

The PostgreSQL database will contain three main schemas.

### Raw Layer

Schema:

```text
raw
```

Purpose:

Stores source data before transformation.

Main table:

```text
raw.superstore_sales
```

---

### Staging Layer

Schema:

```text
staging
```

Purpose:

Cleans, standardizes, and prepares raw data.

Example table/model:

```text
staging.stg_superstore_sales
```

---

### Mart Layer

Schema:

```text
marts
```

Purpose:

Stores business-ready fact and dimension tables for reporting.

Planned tables:

```text
marts.fact_sales
marts.dim_customer
marts.dim_product
marts.dim_date
marts.dim_region
```

---

## Cost Control

Because this project uses AWS credits, the architecture is designed to control cost.

Cost-control approach:

* Use S3 for small raw dataset storage
* Use Glue Crawler only when needed
* Avoid always-running EC2, RDS, Redshift, or EMR resources at this stage
* Keep PostgreSQL local during the first version
* Monitor AWS billing regularly
* Delete unused AWS resources after testing

---

## Current Status

Completed:

- Project folder structure
- GitHub repository setup
- Raw dataset download
- Source data profiling
- Business requirements documentation
- AWS Budget alert setup
- S3 bucket creation
- Raw Superstore dataset upload to S3
- AWS Glue database creation
- AWS Glue Crawler creation and execution
- Glue Data Catalog table creation

Current S3 dataset path:

```text
s3://retail-data-engineering-project-varun-2026/raw/superstore/superstore_sales.csv

Current Glue Catalog table:

retail_data_catalog.raw_superstore
```

## Next step:

* Install AWS CLI locally
* Configure local AWS credentials sagely
* Build Python ingestion from S3 to PostgreSQL
