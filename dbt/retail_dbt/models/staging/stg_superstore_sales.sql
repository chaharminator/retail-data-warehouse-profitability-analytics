{{ config(
    materialized='table',
    schema='staging'
) }}

SELECT
    row_id,
    order_id,

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

    TO_DATE(ship_date, 'MM/DD/YYYY') - TO_DATE(order_date, 'MM/DD/YYYY') AS shipping_days,

    CASE
        WHEN sales = 0 THEN NULL
        ELSE ROUND((profit / sales) * 100, 2)
    END AS profit_margin_percentage

FROM {{ source('raw', 'superstore_sales') }}