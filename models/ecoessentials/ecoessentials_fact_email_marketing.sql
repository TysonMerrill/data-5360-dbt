{{ config(materialized = 'table', schema = 'dw_ecoessentials') }}

select
    e.event_key,
    em.email_key,
    coalesce(c.customer_key, -1) as customer_key,
    s.subscriberid,
    d.date_key,
    t.time_key

from {{ source('ecoessentials_marketing', 'marketingemails') }} s

inner join {{ ref('ecoessentials_dim_event') }} e
    on s.emaileventid = e.email_event_id

inner join {{ ref('ecoessentials_dim_email') }} em
    on s.emailid = em.email_id

left join {{ ref('ecoessentials_dim_customer') }} c
    on try_to_number(nullif(trim(to_varchar(s.customerid)), 'NULL')) = c.customer_id

inner join {{ ref('ecoessentials_dim_date') }} d
    on cast(s.eventtimestamp as date) = d.date_key

inner join {{ ref('ecoessentials_dim_time') }} t
    on cast(s.eventtimestamp as time) = t.time_key