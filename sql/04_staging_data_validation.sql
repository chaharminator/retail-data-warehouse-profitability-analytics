-- ============================================================
-- File: 04_staging_data_validation.sql
-- Project: Retail Data Engineering Pipeline
-- Purpose: Validate staging Superstore data after transformation
-- ============================================================

-- Count total shipping rows
SELECT COUNT(*) AS total_rows
FROM staging.stg_superstore_sales;

-- Preview staging data
SELECT *
FROM staging.stg_superstore_sales
LIMIT 10

-- Validate data conversion
SELECT  
    MIN(order_date) AS earliest_order_date,
    MAX(order_date) AS latest_order_date,
    MIN(ship_date) AS easliest_ship_date,
    MAX(shhip_date) AS latest_ship_date
FROM staging.stg_superstore_sales;

-- Validate shipping days calculation
SELECT      
    MIN(shipping_days) AS min_shipping_days,
    MAX(shipping_days) AS max_shhipping_days,
    ROUND(AVG(shipping_days), 2) AS avh_shipping_days
FROM staging.stg_superstore_sales;

-- Validate profit margin calculation

SELECT  
    MIN(profit_margin_percentage) AS min_profit_margin,
    MAX(profit_margin_percentage) AS max_profit_margin,
    ROUND(AVG(profit_margin_percentage), 2) AS avg_profit_margin
FROM staging.stg_superstore_sales;

-- Check for negative shipping days

SELECT *
FROM staging.stg_superstore_sales
WHERE shipping_days < 0;

-- Check missing values in staging important columns

SELECT
    SUM(CASE WHEN row_id IS NULL THEN 1 ELSE 0 END) AS missing_row_id,
    SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END) AS missing_order_id,
    SUM(CASE WHEN order_date IS NULL THEN 1 ELSE 0 END) AS missing_order_date,
    SUM(CASE WHEN ship_date IS NULL THEN 1 ELSE 0 END) AS missing_ship_date,
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END) AS missing_customer_id,
    SUM(CASE WHEN product_id IS NULL THEN 1 ELSE 0 END) AS missing_product_id,
    SUM(CASE WHEN sales IS NULL THEN 1 ELSE 0 END) AS missing_sales,
    SUM(CASE WHEN profit IS NULL THEN 1 ELSE 0 END) AS missing_profit
FROM staging.stg_superstore_sales;