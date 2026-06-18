-- ============================================================
-- File: 07_business_analysis_queries.sql
-- Project: Retail Data Engineering Pipeline
-- Purpose: Business analysis queries using mart layer tables
-- ============================================================

-- ============================================================
-- 1. Sales and profit by product category
-- Business question:
-- Which product categories generate the most sales and profit?
-- ============================================================

SELECT  
    p.category,
    ROUND(SUM(f.sales),2) AS total_sales,
    ROUND(SUM(f.profit),2) AS total_profit,
    ROUND((SUM(f.profit) / NULLIF(SUM(f.sales),0)) * 100,2) AS profit_margin_percentage
FROM marts.fact_sales f
JOIN marts.dim_product p
    ON f.product_key = p.product_key
GROUP BY p.category
ORDER BY total_profit DESC;

-- ============================================================
-- 2. Sales and profit by region
-- Business question:
-- Which regions are most profitable?
-- ============================================================

SELECT
    r.region,
    ROUND(SUM(f.sales),2) AS total_sales,
    ROUND(SUM(f.profit),2) AS total_profit,
    ROUND((SUM(f.profit) / NULLIF(SUM(f.sales),0)) * 100,2) AS profit_margin_percentage
FROM marts.fact_sales f
JOIN marts.dim_region r
    ON f.region_key = r.region_key
GROUP BY r.region
ORDER BY total_profit DESC;

-- ============================================================
-- 3. Monthly sales and profit trend
-- Business question:
-- How are sales and profit changing over time?
-- ============================================================

SELECT
    d.year,
    d.month,
    d.month_name,
    ROUND(SUM(f.sales),2) AS total_sales,
    ROUND(SUM(f.profit),2) AS total_profit
FROM marts.fact_sales f
JOIN marts.dim_date d
    ON f.order_date = d.date_day
GROUP BY
    d.year,
    d.month,
    d.month_name
ORDER BY
    d.year,
    d.month;

-- ============================================================
-- 4. Top 10 customers by sales
-- Business question:
-- Which customers contribute the most revenue?
-- ============================================================

SELECT
    c.customer_name,
    c.segment,
    ROUND(SUM(f.sales),2) AS total_sales,
    ROUND(SUM(f.profit),2) AS total_profit
FROM marts.fact_sales f
JOIN marts.dim_customer c
    ON f.customer_key = c.customer_key
GROUP BY 
    c.customer_name,
    c.segment
ORDER BY total_sales DESC
LIMIT 10;

-- ============================================================
-- 5. Loss-making products
-- Business question:
-- Which products are generating negative profit?
-- ============================================================

SELECT
    p.product_name,
    p.category,
    p.sub_category,
    ROUND(SUM(f.sales),2) AS total_sales,
    ROUND(SUM(f.profit),2) AS total_profit
FROM marts.fact_sales f
JOIN marts.dim_product p
    ON f.product_key = p.product_key
GROUP BY
    p.product_name,
    p.category,
    p.sub_category
HAVING SUM(f.profit) < 0
ORDER BY total_profit ASC
LIMIT 20;

-- ============================================================
-- 6. Profit by customer segment
-- Business question:
-- Which customer segments are most profitable?
-- ============================================================

SELECT
    c.segment,
    ROUND(SUM(f.sales),2) AS total_sales,
    ROUND(SUM(f.profit),2) AS total_profit,
    ROUND((SUM(f.profit) / NULLIF(SUM(f.sales), 0)) * 100,2) AS profit_margin_percentage
FROM marts.fact_sales f
JOIN marts.dim_customer c
    ON f.customer_key = c.customer_key
GROUP BY c.segment
ORDER BY total_profit DESC;

-- ============================================================
-- 7. Shipping mode performance
-- Business question:
-- Which shipping modes are used most and how profitable are they?
-- ============================================================

SELECT
    f.ship_mode,
    COUNT(*) AS total_orders,
    ROUND(AVG(f.shipping_days), 2) AS avg_shipping_days,
    ROUND(SUM(f.sales), 2) AS total_sales,
    ROUND(SUM(f.profit), 2) AS total_profit
FROM marts.fact_sales f
GROUP BY f.ship_mode
ORDER BY total_orders DESC;