{{ config(
    materialized = 'table',
    schema = 'dw_ecoessentials'
    )
}}


select
p.campaign_id as campaign_key,
p.campaign_id,
p.campaign_name,
p.campaign_discount,
o.promotional_campaign,
FROM {{ source('ecoessentials_landing', 'promotional_campaign') }} p
INNER JOIN {{ source('ecoessentials_landing', 'order_line') }} o ON p.campaign_ID = o.campaign_ID