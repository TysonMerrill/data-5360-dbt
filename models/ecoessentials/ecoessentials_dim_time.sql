{{ config(
    materialized = 'table',
    schema = 'dw_ecoessentials'
) }}

with all_times as (
    select time(order_timestamp) as time_key
    from {{ source('ecoessentials_landing', 'order') }}

    union distinct

    select time(eventtimestamp) as time_key
    from {{ source('ecoessentials_marketing', 'marketingemails') }}
)

select distinct
    time_key,
    extract(hour from time_key)    as hour_of_day,
    extract(minute from time_key)  as minute_of_hour,
    case
        when extract(hour from time_key) < 12 then 'AM'
        else 'PM'
    end                            as am_pm,
    case
        when extract(hour from time_key) between 6  and 11 then 'Morning'
        when extract(hour from time_key) between 12 and 16 then 'Afternoon'
        when extract(hour from time_key) between 17 and 20 then 'Evening'
        else 'Night'
    end                            as time_of_day_period

from all_times
where time_key is not null