{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
) }}

SELECT
    c.customer_key,
    d.date_key,
    s.store_key,
    p.product_key,
    e.employee_key,
    ol.Unit_price,
    ol.Quantity,
   (ol.quantity) * (ol.unit_price) as dollars_sold
FROM {{ source('oliver_landing', 'orderline') }} ol
INNER JOIN {{ source('oliver_landing', 'orders') }} o ON o.order_ID = ol.order_ID
INNER JOIN {{ ref('oliver_dim_product') }} p ON ol.product_ID = p.product_ID
INNER JOIN {{ ref('oliver_dim_store') }} s ON s.store_ID = o.store_ID
INNER JOIN {{ ref('oliver_dim_customer') }} c ON o.Customer_ID = c.customer_id 
INNER JOIN {{ ref('oliver_dim_employee') }} e ON e.employee_ID = o.employee_id 
INNER JOIN {{ ref('oliver_dim_date') }} d ON d.date_key = o.order_date
