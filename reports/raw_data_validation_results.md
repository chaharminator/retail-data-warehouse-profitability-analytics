# Raw Data Validation Results

## Validation Purpose

This document records the validation results after loading the Superstore raw dataset from AWS S3 into PostgreSQL.

The goal of this validation step is to confirm that the ingestion pipeline loaded the raw data correctly and that the raw PostgreSQL table is ready for staging transformations.

---

## Pipeline Step Validated

```text
AWS S3 raw CSV
    ↓
Python ingestion script
    ↓
PostgreSQL raw.superstore_sales
```

---

## Source and Target

| Layer  | Location                                                                              |
| ------ | ------------------------------------------------------------------------------------- |
| Source | `s3://retail-data-engineering-project-varun-2026/raw/superstore/superstore_sales.csv` |
| Target | `retail_dw_db.raw.superstore_sales`                                                   |

---

## Row Count Validation

| Source                                        | Row Count |
| --------------------------------------------- | --------: |
| AWS S3 CSV rows read by Python                |    10,194 |
| PostgreSQL `raw.superstore_sales` rows loaded |    10,194 |

**Result:** Passed

The row count matched between the AWS S3 source file and the PostgreSQL raw table.

---

## Missing Value Validation

Important business and pipeline columns were checked for missing values:

* `order_id`
* `order_date`
* `customer_id`
* `product_id`
* `sales`
* `profit`

**Result:** Passed

No missing values were found in the checked important columns.

---

## Duplicate Validation

### Duplicate Row ID Check

The `row_id` column was checked for duplicate values.

**Result:** Passed

No duplicate `row_id` values were found.

### Duplicate Order-Product Check

Some repeated `order_id` and `product_id` combinations were found.

**Result:** Reviewed

These records are not treated as failed validation because `row_id` is unique. The repeated combinations may represent repeated order line entries rather than full duplicate records.

---

## Numeric Range Validation

Numeric fields were checked to confirm that sales, quantity, discount, and profit values loaded correctly.

| Metric   |    Minimum |    Maximum |
| -------- | ---------: | ---------: |
| Sales    |     0.4440 | 22638.4800 |
| Quantity |          1 |         14 |
| Discount |        0.0 |        0.8 |
| Profit   | -6599.9780 |  8399.9760 |

**Result:** Passed

The numeric range check confirms that numeric fields were loaded successfully.

Negative profit values are valid because they represent loss-making transactions.

---

## Validation Summary

The raw ingestion pipeline successfully loaded the Superstore dataset from AWS S3 into PostgreSQL.

Key validation checks passed:

* Row count matched between S3 and PostgreSQL
* No missing values in important fields
* No duplicate `row_id` values
* Numeric fields loaded successfully
* Negative profit values were identified and treated as valid business data
* Raw table is ready for staging transformations

---

## Conclusion

The raw data layer is valid and ready for the next pipeline stage: staging transformations.

The next step is to build a staging layer that standardizes data types, converts date fields, cleans column naming, and prepares the dataset for warehouse modeling.
