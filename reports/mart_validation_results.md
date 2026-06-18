# Mart Data Validation Results

## Validation Purpose

This document records the validation results after transforming the staging Superstore dataset into a business-ready mart layer.

The purpose of the mart layer is to organise cleaned data into fact and dimension tables that support reporting, analytics, and dashboarding.

---

## Pipeline Step Validated

PostgreSQL staging.stg_superstore_sales
↓
PostgreSQL mart layer

---

## Mart Tables Created

| Table                | Purpose                               |
| -------------------- | ------------------------------------- |
| `marts.dim_customer` | Stores customer-level attributes      |
| `marts.dim_product`  | Stores product-level attributes       |
| `marts.dim_region`   | Stores geographic/location attributes |
| `marts.dim_date`     | Stores calendar date attributes       |
| `marts.fact_sales`   | Stores sales transaction metrics      |

---

## Row Count Validation

| Table                | Row Count |
| -------------------- | --------: |
| `marts.dim_customer` |       804 |
| `marts.dim_product`  |     1,862 |
| `marts.dim_region`   |       655 |
| `marts.dim_date`     |     1,464 |
| `marts.fact_sales`   |    10,194 |

**Result:** Passed

The `fact_sales` table preserved all 10,194 rows from the staging sales dataset.

---

## Duplicate Key Validation

The following key columns were checked for duplicate values:

* `customer_key`
* `product_key`
* `region_key`
* `sales_key`

**Result:** Passed

No duplicate key values were found in the checked mart tables.

---

## Missing Dimension Key Validation

The fact table was checked for missing dimension keys.

| Check                 | Missing Count |
| --------------------- | ------------: |
| Missing customer keys |             0 |
| Missing product keys  |             0 |
| Missing region keys   |             0 |

**Result:** Passed

All sales fact rows successfully matched to customer, product, and region dimension records.

---

## Date Range Validation

| Metric                       | Value      |
| ---------------------------- | ---------- |
| Earliest order date          | 2023-01-03 |
| Latest order date            | 2026-12-30 |
| Earliest ship date           | 2023-01-07 |
| Latest ship date             | 2027-01-05 |
| Calendar dates in `dim_date` | 1,464      |

**Result:** Passed

The date dimension covers the full date range required by the sales fact table.

---

## Business Metric Validation

| Metric           |        Value |
| ---------------- | -----------: |
| Total sales      | 2,326,534.35 |
| Total quantity   |       38,654 |
| Total profit     |   292,296.81 |
| Average discount |       0.1556 |

**Result:** Passed

The business metrics were successfully aggregated from the mart fact table.

---

## Mart Layer Summary

The mart layer successfully created a star schema with:

* One customer dimension
* One product dimension
* One region dimension
* One date dimension
* One sales fact table

The `fact_sales` table has a grain of one row per sales transaction line, identified by `sales_key`.

---

## Conclusion

The mart layer is valid and ready for business analysis and dashboard development.

The next step is to create business analysis SQL queries that answer key retail questions such as:

* Sales and profit by category
* Profit by region
* Sales trend by month
* Top customers by sales
* Loss-making products
