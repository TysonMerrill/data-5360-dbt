{{ config(
    materialized = 'table',
    schema = 'dw_ecoessentials'
    )
}}

with cust_source as (
    select
    customer_id,
    customer_first_name,
    customer_last_name,
    customer_phone,
    customer_address,
    customer_city,
    customer_State,
    customer_zip,
    customer_country
    FROM {{ source('ecoessentials_landing', 'customer') }}
)

, subscriber_source as (      
        select 
        subscriberid,
        subscriberfirstname,
        subscriberlastname
    from {{ source('ecoessentials_marketing', 'marketingemails') }}
)

, final as (
    select
        db.customer_id,
        cs.subscriberid,
        coalesce(db.customer_first_name, cs.subscriberfirstname) as firstname,
        coalesce(db.customer_last_name, cs.subscriberlastname) as lastname,
        db.customer_phone,
        db.customer_address,
        db.customer_city,
        db.customer_state,
        db.customer_zip,
        db.customer_country
   
    from cust_source db
    full join subscriber_source cs
        on db.customer_first_name = cs.subscriberfirstname
        and db.customer_last_name = cs.subscriberlastname

)

select distinct
    {{ dbt_utils.generate_surrogate_key(['firstname', 'lastname']) }} as customer_key,
    *
from final