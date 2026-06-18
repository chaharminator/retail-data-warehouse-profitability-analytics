{{ config(
    materialized='table',
    schema='marts'
) }}

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

FROM {{ ref('stg_superstore_sales') }} s

LEFT JOIN {{ ref('dim_customer') }} c
    ON s.customer_id = c.customer_id

LEFT JOIN {{ ref('dim_product') }} p
    ON s.product_id = p.product_id

LEFT JOIN {{ ref('dim_region') }} r
    ON s.country_region = r.country_region
    AND s.region = r.region
    AND s.state_province = r.state_province
    AND s.city = r.city
    AND s.postal_code = r.postal_code