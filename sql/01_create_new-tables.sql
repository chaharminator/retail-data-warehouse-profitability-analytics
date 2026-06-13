-- ============================================================
-- File: 01_create_raw_tables.sql
-- Project: Retail Data Engineering Pipeline
-- Purpose: Create raw schema and raw Superstore sales table
-- ============================================================

-- Create raw schema
CREATE SCHEMA IF NOT EXISTS raw;

-- Drop table during development if it already exists
DROP TABLE IF EXISTS raw.superstore_sales;

-- Create raw Superstore sales table
CREATE TABLE raw.superstore_sales(
    row_id INTEGER,
    order_id TEXT,
    order_date TEXT,
    ship_date TEXT,
    ship_mode TEXT,
    customer_id TEXT,
    customer_name TEXT,
    segment TEXT,
    country_region TEXT,
    city TEXT,
    state_province TEXT,
    postal_code TEXT,
    region TEXT,
    product_id TEXT,
    category TEXT,
    sub_category TEXT,
    product_name TEXT,
    sales NUMERIC(12,4),
    quantity INTEGER,
    discount NUMERIC(5,1),
    profit NUMERIC(12,4)
);