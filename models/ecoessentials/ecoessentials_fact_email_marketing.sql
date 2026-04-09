-- ecoessentials_fact_marketing.sql
{{ config(
    materialized = 'table',
    schema = 'dw_ecoessentials'
) }}

select
    e.event_key,
    em.email_key,
    c.customer_key,
    d.date_key,
    t.time_key

from {{ source('ecoessentials_marketing', 'marketingemails') }} s

inner join {{ ref('ecoessentials_dim_event') }} e
    on s.emaileventid = e.email_event_id

inner join {{ ref('ecoessentials_dim_email') }} em
    on s.emailid = em.email_id

inner join {{ ref('ecoessentials_dim_customer') }} c
    on c.firstname = s.subscriberfirstname
   and c.lastname = s.subscriberlastname

inner join {{ ref('ecoessentials_dim_date') }} d
    on cast(s.eventtimestamp as date) = d.date_key

inner join {{ ref('ecoessentials_dim_time') }} t
    on cast(s.eventtimestamp as time) = t.time_key