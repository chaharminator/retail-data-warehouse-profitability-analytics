-- ============================================================
-- File: 05_create_mart_tables.sql
-- Project: Retail Data Engineering Pipeline
-- Purpose: Create mart layer fact and dimension tables
-- ============================================================

-- Create marts schema
CREATE SCHEMA IF NOT EXISTS marts;

-- Drop fact table first because it depends on dimensions
DROP TABLE IF EXISTS marts.fact_sales;

-- Drop dimension tables
DROP TABLE IF EXISTS marts.dim_customer;
DROP TABLE IF EXISTS marts.dim_product;
DROP TABLE IF EXISTS marts.dim_region;
DROP TABLE IF EXISTS marts.dim_date;

-- ============================================================
-- Customer Dimension
-- Grain: One row per customer
-- ============================================================

CREATE TABLE marts.dim_customer AS
SELECT
    ROW_NUMBER() OVER (ORDER BY customer_id) AS customer_key,
    customer_id,
    MAX(customer_name) AS customer_name,
    MAX(segment) AS segment
FROM staging.stg_superstore_sales
GROUP BY customer_id;

-- ============================================================
-- Product Dimension
-- Grain: One row per product
-- ============================================================

CREATE TABLE marts.dim_product AS
SELECT
    ROW_NUMBER() OVER (ORDER BY product_id) AS product_key,
    product_id,
    MAX(product_name) AS product_name,
    MAX(category) AS category,
    MAX(sub_category) AS sub_category
FROM staging.stg_superstore_sales
GROUP BY product_id;

-- ============================================================
-- Region Dimension
-- Grain: One row per unique geographic location
-- ============================================================

CREATE TABLE marts.dim_region AS
SELECT
    ROW_NUMBER() OVER (
        ORDER BY country_region, region, state_province, city, postal_code
    ) AS region_key,
    country_region,
    region,
    state_province,
    city,
    postal_code
FROM (
    SELECT DISTINCT
        country_region,
        region,
        state_province,
        city,
        postal_code
    FROM staging.stg_superstore_sales
) AS locations;

-- ============================================================
-- Date Dimension
-- Grain: One row per calendar date
-- ============================================================

CREATE TABLE marts.dim_date AS
WITH date_range AS (
    SELECT GENERATE_SERIES(
        (SELECT MIN(order_date) FROM staging.stg_superstore_sales),
        (SELECT MAX(ship_date) FROM staging.stg_superstore_sales),
        INTERVAL '1 day'
    )::DATE AS date_day
)
SELECT
    date_day,
    EXTRACT(YEAR FROM date_day)::INT AS year,
    EXTRACT(QUARTER FROM date_day)::INT AS quarter,
    EXTRACT(MONTH FROM date_day)::INT AS month,
    TRIM(TO_CHAR(date_day, 'Month')) AS month_name,
    EXTRACT(DAY FROM date_day)::INT AS day,
    EXTRACT(DOW FROM date_day)::INT AS day_of_week,
    TRIM(TO_CHAR(date_day, 'Day')) AS day_name
FROM date_range;

-- ============================================================
-- Sales Fact Table
-- Grain: One row per sales transaction line
-- ============================================================

CREATE TABLE marts.fact_sales AS
SELECT
    s.row_id AS sales_key,
    s.order_id,
    s.order_date,
    s.ship_date,

    c.customer_key,
    p.product_key,
    r.region_key,

    s.ship_mode,
    s.sales,
    s.quantity,
    s.discount,
    s.profit,
    s.shipping_days,
    s.profit_margin_percentage

FROM staging.stg_superstore_sales s

LEFT JOIN marts.dim_customer c
    ON s.customer_id = c.customer_id

LEFT JOIN marts.dim_product p
    ON s.product_id = p.product_id

LEFT JOIN marts.dim_region r
    ON s.country_region = r.country_region
    AND s.region = r.region
    AND s.state_province = r.state_province
    AND s.city = r.city
    AND s.postal_code = r.postal_code;