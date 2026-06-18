-- ============================================================
-- File: 06_mart_data_validation.sql
-- Project: Retail Data Engineering Pipeline
-- Purpose: Validate mart layer fact and dimension tables
-- ============================================================

-- Row counts for all mart tables
SELECT 'dim_customers' AS table_name, COUNT(*) AS row_count FROM marts.dim_customer
UNION ALL 
SELECT 'dim_product', COUNT(*) FROM marts.dim_product
UNION ALL
SELECT 'dim_region', COUNT(*) FROM marts.dim_region
UNION ALL
SELECT 'dim_date', COUNT(*) FROM marts.dim_date
UNION ALL
SELECT 'fact_sales', COUNT(*) FROM marts.fact_sales;

-- Check duplicate customer keys
SELECT customer_key, COUNT(*) AS duplicate_count
FROM marts.dim_customer
GROUP BY customer_key
HAVING COUNT(*) > 1;

-- Check duplicate product keys
SELECT product_key, COUNT(*) AS duplicate_count
FROM marts.dim_product
GROUP BY product_key
HAVING COUNT(*) > 1;

-- Check duplicate region keys
SELECT region_key, COUNT(*) AS duplicate_count
FROM marts.dim_region
GROUP BY region_key
HAVING COUNT(*) > 1;

-- Check duplicate sales keys
SELECT sales_key, COUNT(*) AS duplicate_count
FROM marts.fact_sales
GROUP BY sales_key
HAVING COUNT(*) > 1;

-- Check missing dimension keys in fact table

SELECT  
    SUM(CASE WHEN customer_key IS NULL THEN 1 ELSE 0 END) AS missing_customer_keys,
    SUM(CASE WHEN product_key IS NULL THEN 1 ELSE 0 END) AS missing_product_keys,
    SUM(CASE WHEN region_key IS NULL THEN 1 ELSE 0 END) AS missing_region_keys
FROM marts.fact_sales;

-- Validate fact table date range

SELECT
    MIN(order_date) AS earliest_order_date,
    MAX(order_date) AS latest_order_date,
    MIN(ship_date) AS earliest_ship_date,
    MAX(ship_date) AS latest_ship_date
FROM marts.fact_sales;

-- Validate date dimension range

SELECT 
    MIN(date_day) AS earliest_date,
    MAX(date_day) AS latest_date,
    COUNT(*) AS total_calender_dates
FROM marts.dim_date;

-- Validate business metric totals

SELECT  
    ROUND(SUM(sales),2) AS total_sales,
    SUM(quantity) AS total_quantity,
    ROUND(SUM(profit),2) AS total_profit,
    ROUND(AVG(discount), 4) AS avg_discount
FROM marts.fact_sales;

