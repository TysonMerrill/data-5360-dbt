{{ config(
    materialized = 'table',
    schema = 'dw_ecoessentials'
) }}

select
    c.customer_key,
    p.product_key,
    cam.campaign_key,
    d.date_key,
    t.time_key,
    ol.quantity,
    prod.price,
    ol.price_after_discount,
    o.order_id
from {{ source('ecoessentials_landing', 'order_line') }} ol
-- source joins
inner join {{ source('ecoessentials_landing', 'order') }} o
    on ol.order_id = o.order_id
inner join {{ source('ecoessentials_landing', 'product') }} prod
    on ol.product_id = prod.product_id
inner join {{ source('ecoessentials_landing', 'promotional_campaign') }} pc
    on ol.campaign_id = pc.campaign_id
-- dimension joins 
inner join {{ ref('ecoessentials_dim_customer') }} c
    on o.customer_id = c.customer_id
inner join {{ ref('ecoessentials_dim_product') }} p
    on prod.product_id = p.product_id
inner join {{ ref('ecoessentials_dim_promotion_campaign') }} cam
    on pc.campaign_id = cam.campaign_id
inner join {{ ref('ecoessentials_dim_date') }} d
    on cast(o.order_timestamp as date) = d.date_key
inner join {{ ref('ecoessentials_dim_time') }} t
    on time(o.order_timestamp) = t.time_key