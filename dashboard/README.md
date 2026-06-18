# Power BI Dashboard

## Overview

This folder contains the Power BI dashboard documentation and related dashboard assets for the Retail Data Warehouse & Profitability Analytics project.

The dashboard was built using the PostgreSQL mart layer created from the ELT pipeline.

The dashboard connects to the following star schema tables:

* `marts.fact_sales`
* `marts.dim_customer`
* `marts.dim_product`
* `marts.dim_region`
* `marts.dim_date`

---

## Dashboard Purpose

The purpose of the dashboard is to help business users analyze retail sales and profitability across products, customers, regions, dates, and shipping modes.

The dashboard answers business questions such as:

* Which product categories generate the most sales and profit?
* Which regions are the most profitable?
* How do sales change over time?
* Which customer segments are most profitable?
* Which customers generate the most revenue?
* Which products are loss-making?
* Which shipping modes drive the most orders, sales, and profit?
* How long does each shipping mode take on average?

---

## Dashboard Pages

### 1. Retail Sales & Profitability Dashboard

This page provides an executive overview of business performance.

It includes:

* Total Sales
* Total Profit
* Profit Margin %
* Total Quantity
* Average Discount
* Average Shipping Days
* Sales by Category
* Profit by Category
* Sales by Region
* Profit by Region
* Monthly Sales Trend

Main insights:

* Technology is the most profitable category.
* Furniture has high sales but weak profitability.
* West is the strongest region by profit.
* Central has weaker profitability compared with other regions.
* Sales fluctuate month to month, so profitability should be monitored separately from revenue.

---

### 2. Customer & Product Analysis

This page focuses on customer segment performance, top customers, and loss-making products.

It includes:

* Profit by Customer Segment
* Profit Margin by Customer Segment
* Top 10 Customers by Sales
* Top Loss-Making Products

Main insights:

* Consumer generates the highest total profit.
* Home Office has the highest profit margin.
* Some high-sales customers generate negative profit.
* Several products generate sales revenue but still create losses.
* Loss-making products help identify areas for pricing, discounting, or product strategy review.

---

### 3. Shipping & Operations Analysis

This page focuses on shipping mode performance and operational efficiency.

It includes:

* Orders by Ship Mode
* Average Shipping Days by Ship Mode
* Sales by Ship Mode
* Profit by Ship Mode

Main insights:

* Standard Class has the highest number of orders.
* Standard Class also generates the highest sales and profit.
* Standard Class has the slowest average shipping time.
* Same Day shipping is the fastest but has the lowest order volume and profit.

---

## Dashboard Screenshots

Dashboard screenshots are stored in the project `images/` folder.

| Dashboard Page                         | Screenshot                                |
| -------------------------------------- | ----------------------------------------- |
| Retail Sales & Profitability Dashboard | `images/dashboard_overview.png`           |
| Customer & Product Analysis            | `images/customer_product_analysis.png`    |
| Shipping & Operations Analysis         | `images/shipping_operations_analysis.png` |

---

## Power BI File

The Power BI Desktop file is saved locally as:

```text
dashboard/retail_sales_profitability_dashboard.pbix
```

The `.pbix` file is not committed to GitHub because Power BI files can be large.

Instead, dashboard screenshots are committed to the repository for portfolio review.

---

## Data Model

The dashboard uses a star schema.

```text
                 dim_customer
                      |
dim_product  —   fact_sales   —  dim_region
                      |
                   dim_date
```

The fact table contains transaction metrics such as:

* Sales
* Quantity
* Discount
* Profit
* Shipping days
* Profit margin percentage

Dimension tables contain descriptive attributes for:

* Customers
* Products
* Regions
* Dates

---

## Measures Created in Power BI

The following DAX measures were created:

```DAX
Total Sales = SUM('marts fact_sales'[sales])
```

```DAX
Total Profit = SUM('marts fact_sales'[profit])
```

```DAX
Total Quantity = SUM('marts fact_sales'[quantity])
```

```DAX
Profit Margin % = DIVIDE([Total Profit], [Total Sales])
```

```DAX
Average Discount = AVERAGE('marts fact_sales'[discount])
```

```DAX
Average Shipping Days = AVERAGE('marts fact_sales'[shipping_days])
```

---

## Dashboard Status

Completed:

* Connected Power BI to PostgreSQL
* Loaded mart layer star schema tables
* Created fact-to-dimension relationships
* Created DAX measures
* Built executive overview page
* Built customer and product analysis page
* Built shipping and operations analysis page
* Exported dashboard screenshots for GitHub

Planned improvement:

* Add more advanced slicers and filters if needed
* Add optional drill-through pages
* Publish dashboard screenshots in the main project README
