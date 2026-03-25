{{ config(
    materialized = 'table',
    schema = 'dw_ecoessentials'
    )
}}


select
product_id as product_key,
product_id,
product_type,
product_name
FROM {{ source('ecoessentials_landing', 'product') }}