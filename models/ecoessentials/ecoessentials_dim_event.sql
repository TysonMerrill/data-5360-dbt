{{ config(
    materialized = 'table',
    schema = 'dw_ecoessentials'
    )
}}

select
emaileventid as event_key,
emaileventid as email_event_id,
eventtype as event_type
FROM {{ source('ecoessentials_marketing', 'marketingemails') }}