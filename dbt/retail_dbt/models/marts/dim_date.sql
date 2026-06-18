{{ config(
    materialized='table',
    schema='marts'
) }}

WITH date_range AS (
    SELECT GENERATE_SERIES(
        (SELECT MIN(order_date) FROM {{ ref('stg_superstore_sales') }}),
        (SELECT MAX(ship_date) FROM {{ ref('stg_superstore_sales') }}),
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
FROM date_range