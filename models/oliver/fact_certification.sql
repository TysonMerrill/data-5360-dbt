{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
)}}

select
    d.date_key,
    e.employee_key,
    stg.certification_name,
    stg.certification_cost,
FROM {{ ref('stg_employee_certifications') }} stg
INNER JOIN {{ ref('oliver_dim_employee') }} e ON stg.employee_ID = e.employee_ID
INNER JOIN {{ ref('oliver_dim_date') }} d ON d.date_key = stg.certification_awarded_date

