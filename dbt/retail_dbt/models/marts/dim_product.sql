{{ config(
    materialized='table',
    schema='marts'
) }}

SELECT
    ROW_NUMBER() OVER (ORDER BY product_id) AS product_key,
    product_id,
    MAX(product_name) AS product_name,
    MAX(category) AS category,
    MAX(sub_category) AS sub_category
FROM {{ ref('stg_superstore_sales') }}
GROUP BY product_id