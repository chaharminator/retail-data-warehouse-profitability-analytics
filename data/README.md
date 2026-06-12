# Data Folder

This folder stores the raw and processed data files used in the project.

## Folder Structure

```text
data/
├── raw/
└── processed/
```

## Raw Data

The raw dataset is stored in:

```text
data/raw/superstore_sales.csv
```

The raw file should not be manually modified. It represents the original source data received from the business system.

## Processed Data

The `processed` folder will be used later for cleaned or exported files if needed.

## Source Dataset

The project uses a Superstore retail sales dataset containing order, customer, product, sales, discount, profit, shipping, and regional information.

Expected columns include:

```text
Order ID
Order Date
Ship Date
Ship Mode
Customer ID
Customer Name
Segment
Country
City
State
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

In this project, the raw data layer is preserved separately from transformed data. This follows a common data engineering practice where original source data is stored unchanged for auditability and reproducibility.

Transformations will be performed later in the staging and warehouse layers, rather than directly changing the raw source file.
