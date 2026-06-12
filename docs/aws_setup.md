# AWS Setup Documentation

## Purpose

This document describes the AWS services used in this project and how they support the retail data engineering pipeline.

The goal is to use AWS in a cost-controlled way while still simulating a real industry-style data engineering workflow.

---

## AWS Services Used

This project will use the following AWS services:

| AWS Service           | Purpose                                         |
| --------------------- | ----------------------------------------------- |
| Amazon S3             | Store raw retail data in a cloud data lake zone |
| AWS Glue Crawler      | Scan raw S3 data and infer metadata             |
| AWS Glue Data Catalog | Store metadata about the raw dataset            |

---

## Planned AWS Architecture

```text
Local Raw CSV
    ↓
Amazon S3 Raw Zone
    ↓
AWS Glue Crawler
    ↓
AWS Glue Data Catalog
    ↓
Python Ingestion from S3
    ↓
PostgreSQL
    ↓
dbt Transformations
    ↓
Power BI Dashboard
```

---

## S3 Raw Data Lake

Amazon S3 will be used as the cloud raw data lake storage layer.

The raw Superstore CSV file will be uploaded to S3 and preserved without manual modification.

Planned S3 structure:

```text
s3://retail-data-engineering-project/raw/superstore/superstore_sales.csv
```

The `raw` folder represents the original source data layer.

---

## AWS Glue Crawler

AWS Glue Crawler will scan the raw dataset stored in S3.

The crawler will infer:

* File format
* Column names
* Data types
* Table metadata
* Source location

This helps automate metadata discovery instead of manually defining every column.

---

## AWS Glue Data Catalog

AWS Glue Data Catalog will store the metadata created by the Glue Crawler.

This simulates how companies manage discoverable datasets in a cloud data lake.

The catalog makes it easier for downstream tools and teams to understand what data exists and how it is structured.

---

## Cost Control Rules

To keep AWS usage within budget:

* Use S3 only for small project files
* Run Glue Crawler only when needed
* Do not use always-running AWS services unless necessary
* Avoid EC2, RDS, Redshift, and EMR in the first version
* Monitor AWS Billing Dashboard regularly
* Delete unused AWS resources after testing
* Set up an AWS Budget alert before creating resources

---

## Current AWS Status

Completed AWS setup:

- Created AWS Budget alert for cost monitoring
- Created S3 bucket for the project
- Created raw data lake folder structure
- Uploaded the raw Superstore sales dataset to S3
- Created AWS Glue database
- Created and ran AWS Glue Crawler
- Created Glue Data Catalog table for raw Superstore data

## Created AWS Resources

| Resource | Value |
|---|---|
| S3 Bucket | retail-data-engineering-project-varun-2026 |
| Raw Zone Prefix | raw/superstore/ |
| Raw Dataset Object | raw/superstore/superstore_sales.csv |
| Glue Database | retail_data_catalog |
| Glue Crawler | superstore_raw_data_crawler |
| Glue Catalog Table | raw_superstore |

## S3 Dataset Path

```text
s3://retail-data-engineering-project-varun-2026/raw/superstore/superstore_sales.csv

Glue Catalog Reference

retail_data_catalog.raw_superstore
```

## Next AWS steps

1. Install AWS CLI locally
2. Configure local AWS credentials safely
3. Install boto3
4. Build Python ingestion pipeline from S3 to PostgreSQ
