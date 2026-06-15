# Staging Data Validation Results

## Validation Purpose

This document records the validation results after transforming the raw Superstore dataset into the PostgreSQL staging layer.

The purpose of the staging layer is to clean, standardize, and prepare raw data for warehouse modeling and business analytics.

---

## Pipeline Step Validated

```text
PostgreSQL raw.superstore_sales
    ↓
PostgreSQL staging.stg_superstore_sales
```

---

## Source and Target

| Layer  | Table                          |
| ------ | ------------------------------ |
| Source | `raw.superstore_sales`         |
| Target | `staging.stg_superstore_sales` |

---

## Row Count Validation

| Table                          | Row Count |
| ------------------------------ | --------: |
| `raw.superstore_sales`         |    10,194 |
| `staging.stg_superstore_sales` |    10,194 |

**Result:** Passed

The staging table contains the same number of rows as the raw table.

---

## Date Conversion Validation

Raw date fields were converted from text into PostgreSQL `DATE` values.

| Metric              | Value      |
| ------------------- | ---------- |
| Earliest Order Date | 2023-01-03 |
| Latest Order Date   | 2026-12-30 |
| Earliest Ship Date  | 2023-01-07 |
| Latest Ship Date    | 2027-01-05 |

**Result:** Passed

The `order_date` and `ship_date` fields were successfully converted into proper date types.

---

## Shipping Days Validation

A new calculated field, `shipping_days`, was created by subtracting `order_date` from `ship_date`.

| Metric                | Value |
| --------------------- | ----: |
| Minimum Shipping Days |     0 |
| Maximum Shipping Days |    11 |
| Average Shipping Days |  3.96 |

**Result:** Passed

Shipping duration values appear reasonable. A minimum value of `0` indicates same-day shipping for some orders.

---

## Profit Margin Validation

A new calculated field, `profit_margin_percentage`, was created using:

```text
(profit / sales) * 100
```

| Metric                |    Value |
| --------------------- | -------: |
| Minimum Profit Margin | -275.00% |
| Maximum Profit Margin |   50.00% |
| Average Profit Margin |   12.22% |

**Result:** Passed

Negative profit margin values are valid because they represent loss-making transactions.

---

## Missing Value Validation

Important staging columns were checked for missing values:

* `row_id`
* `order_id`
* `order_date`
* `ship_date`
* `customer_id`
* `product_id`
* `sales`
* `profit`

**Result:** Passed

No missing values were found in the important staging columns.

---

## Staging Transformation Summary

The staging layer successfully applied the following transformations:

* Created the `staging` schema
* Created `staging.stg_superstore_sales`
* Converted `order_date` from text to date
* Converted `ship_date` from text to date
* Created `shipping_days`
* Created `profit_margin_percentage`
* Preserved row count from the raw layer
* Prepared the dataset for warehouse modeling

---

## Conclusion

The staging table is valid and ready for the next pipeline stage: warehouse mart modeling.

The next step is to design and create fact and dimension tables, including:

* `marts.fact_sales`
* `marts.dim_customer`
* `marts.dim_product`
* `marts.dim_date`
* `marts.dim_region`
