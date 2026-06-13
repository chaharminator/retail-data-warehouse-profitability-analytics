-- ============================================================
-- File: 02_raw_data_validation.sql
-- Project: Retail Data Engineering Pipeline
-- Purpose: Validate raw Superstore data after ingestion
-- ============================================================


-- Count total rows
SELECT COUNT(*) AS total_rows
FROM raw.superstore_sales;


-- Preview raw data
SELECT *
FROM raw.superstore_sales
LIMIT 10;

-- Check duplicate row IDs
SELECT
    row_id,
    COUNT(*) AS duplicate_count
FROM raw.superstore_sales
GROUP BY row_id
HAVING COUNT(*) > 1;

-- Check duplicate order-product rows
SELECT  
    order_id,
    product_id,
    COUNT(*) AS duplicate_count
FROM raw.superstore_sales
GROUP BY order_id, product_id
HAVING COUNT(*) > 1;

-- Check missing values in important columns
SELECT  
    SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS missing_order_id,
    SUM(CASE WHEN order_date IS NULL THEN 1 ELSE 0 END) AS missing_order_date,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS missing_customer_id,
    SUM(CASE WHEN product_id IS NULL THEN 1 ELSE 0 END) AS missing_product_id,
    SUM(CASE WHEN sales IS NULL THEN 1 ELSE 0 END) AS missing_sales,
    SUM(CASE WHEN profit IS NULL THEN 1 ELSE 0 END) AS missing_profit
FROM raw.superstore_sales;

-- Check sales, quantity, discount and profit ranges

SELECT
    MIN(sales) AS min_sales,
    MAX(sales) AS max_sales,
    MIN(quantity) AS min_quantity,
    MAX(quantity) AS max_quantity,
    MIN(discount) AS min_discount,
    MAX(discount) AS max_discount,
    MIN(profit) AS min_profit,
    MAX(profit) AS max_profit
FROM raw.superstore_sales;