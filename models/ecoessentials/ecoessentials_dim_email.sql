{{ config(
    materialized = 'table',
    schema = 'dw_ecoessentials'
    )
}}

select
emailid as email_key,
emailid as email_id,
emailname as email_name
FROM {{ source('ecoessentials_marketing', 'marketingemails') }}