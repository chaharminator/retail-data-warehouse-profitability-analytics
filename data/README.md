# Data Folder

This folder stores the local raw and processed data files used in the project.

## Folder Structure

```text
data/
├── raw/
└── processed/
```

## Local Raw Data

The local raw dataset is stored in:

```text
data/raw/superstore_sales.csv
```

This file represents the original source dataset downloaded for the project.

The local raw file should not be manually modified. It is kept unchanged for reproducibility and development.

## AWS S3 Raw Data Lake

The same raw dataset will be uploaded to AWS S3.

S3 will act as the cloud raw data lake zone for this project.

Planned S3 structure:

```text
s3://retail-data-engineering-project/raw/superstore/superstore_sales.csv
```

In a real data engineering workflow, raw files are commonly stored in cloud object storage before being cataloged, ingested, transformed, and modeled for analytics.

## Processed Data

The `processed` folder may be used later for cleaned or exported files if needed.

However, the main transformation workflow will happen through:

```text
AWS S3
↓
Python ingestion
↓
PostgreSQL
↓
dbt
↓
Power BI
```

## Source Dataset

The project uses a Superstore retail sales dataset containing:

* Order information
* Customer information
* Product information
* Geographic information
* Sales
* Quantity
* Discount
* Profit
* Shipping mode

Expected columns include:

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

## Data Engineering Note

This project separates the local raw file, cloud raw storage, and transformed warehouse data.

The raw file is preserved unchanged, while transformations will be applied later in PostgreSQL staging and mart layers using dbt.

This separation supports:

* Reproducibility
* Auditability
* Easier debugging
* Clear pipeline design
* Industry-style data engineering workflow
