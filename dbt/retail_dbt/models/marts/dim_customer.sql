{{ config(
    materialized='table',
    schema='marts'
) }}

SELECT
    ROW_NUMBER() OVER (ORDER BY customer_id) AS customer_key,
    customer_id,
    MAX(customer_name) AS customer_name,
    MAX(segment) AS segment
FROM {{ ref('stg_superstore_sales') }}
GROUP BY customer_id