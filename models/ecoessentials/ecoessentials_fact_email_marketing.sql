{{ config(
    materialized = 'table',
    schema = 'dw_ecoessentials'
) }}

with cleaned as (

    select
        s.*,
        try_to_number(nullif(trim(s.customerid), 'NULL')) as customerid_clean
    from {{ source('ecoessentials_marketing', 'marketingemails') }} s

)

select
    e.event_key,
    em.email_key,
    c.customer_key,
    cam.campaign_key,
    d.date_key,
    t.time_key

from cleaned s

inner join {{ ref('ecoessentials_dim_event') }} e
    on s.emaileventid = e.email_event_id

inner join {{ ref('ecoessentials_dim_email') }} em
    on s.emailid = em.email_id

left join {{ ref('ecoessentials_dim_customer') }} c
    on s.customerid_clean = c.customer_id

inner join {{ ref('ecoessentials_dim_promotion_campaign') }} cam
    on s.campaignid = cam.campaign_id

inner join {{ ref('ecoessentials_dim_date') }} d
    on cast(s.eventtimestamp as date) = d.date_key

inner join {{ ref('ecoessentials_dim_time') }} t
    on cast(s.eventtimestamp as time) = t.time_key