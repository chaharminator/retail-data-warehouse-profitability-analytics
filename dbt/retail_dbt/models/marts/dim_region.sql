{{ config(
    materialized='table',
    schema='marts'
) }}

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
    FROM {{ ref('stg_superstore_sales') }}
) AS locations