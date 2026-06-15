-- ============================================================
-- File: 03_create_staging_table.sql
-- Project: Retail Data Engineering Pipeline
-- Purpose: Create staging schema and staging Superstore table
-- ============================================================

-- Create staging schema
CREATE SCHEMA IF NOT EXISTS staging;

-- Drop staging table during development if it already exists
DROP TABLE IF EXISTS staging.stg_superstore_sales;

--Create staging table from raw data
CREATE TABLE staging.stg_superstore_sales AS
SELECT
    row_id,
    order_id,

    --Convert text dates into proper DATE type
    TO_DATE(order_date, 'MM/DD/YYYY') AS order_date,
    TO_DATE(ship_date, 'MM/DD/YYYY') AS ship_date,

    ship_mode,
    customer_id,
    customer_name,
    segment,
    country_region,
    city,
    state_province,
    postal_code,
    region,
    product_id,
    category,
    sub_category,
    product_name,
    sales,
    quantity,
    discount,
    profit,

    -- New calculated fields
    (TO_DATE(ship_date, 'MM/DD/YYYY') - TO_DATE(order_date, 'MM/DD/YYYY')) AS shipping_days,

    CASE 
        WHEN sales = 0 THEN NULL
        ELSE ROUND((profit/sales) * 100,2)
    END AS profit_margin_percentage

FROM raw.superstore_sales;