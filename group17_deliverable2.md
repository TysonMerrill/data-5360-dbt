Group 17 Deliverable 2 by Tyson and Taz
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Populated dimensional Model:

<img width="537" height="295" alt="Screenshot 2026-03-26 at 12 14 01 PM" src="https://github.com/user-attachments/assets/879cbf39-4999-46ab-902c-38f74c79a982" />
<img width="528" height="289" alt="Screenshot 2026-03-26 at 12 14 30 PM" src="https://github.com/user-attachments/assets/af71d87e-d3c3-47e2-8efe-08804b04c254" />

Lineage Screenshot:
<img width="646" height="443" alt="Screenshot 2026-03-26 at 12 15 29 PM" src="https://github.com/user-attachments/assets/fc8b6e7e-302d-4455-a7f9-60bd4ce20205" />

Repo Links:
https://github.com/TysonMerrill/data-5360-dbt
https://github.com/TazJohnson/data-5360-dbt

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Business Questions and Answers:

1. Which promotional campaign was most successful in sales?
-- fact sales, promotional campaign. Multiply quanity by price after discount. Group by promotional campaign name.

SELECT
p.campaign_name,
SUM(fs.quantity * fs.price_after_discount) AS total_sales
FROM ecoessentials_fact_sales fs
JOIN ecoessentials_dim_promotion_campaign p
    ON fs.campaign_key = p.campaign_key
GROUP BY p.campaign_name
ORDER BY total_sales DESC;
<img width="1297" height="878" alt="Screenshot 2026-03-26 at 11 55 55 AM" src="https://github.com/user-attachments/assets/4810b015-4e4f-494f-b3aa-022bfffc6adf" />


--2. How much of each product is bought on each day of the week?
-- Fact sales, dim_product, dim_date

SELECT d.day_of_week, p.product_name, SUM(QUANTITY) AS ProductsBought
FROM ecoessentials_fact_sales fs JOIN ecoessentials_dim_product p
    ON fs.product_key = p.product_key JOIN  ecoessentials_dim_date d
    ON fs.date_key = d.date_key
GROUP BY d.day_of_week, p.product_name
ORDER BY d.day_of_week, ProductsBought DESC;
<img width="1465" height="877" alt="Screenshot 2026-03-26 at 12 09 34 PM" src="https://github.com/user-attachments/assets/af1dbeaf-1f12-4932-9106-5c350dad3941" />

3. Which campaigns led to the most product bought in each city?
-- Fact sales, dim_product, dim_customer, dim_promotional_campaign

   SELECT
    c.customer_city,
    pc.campaign_name,
    SUM(fs.quantity) AS total_products_bought
FROM ecoessentials_fact_sales fs
JOIN ecoessentials_dim_customer c
    ON fs.customer_key = c.customer_key
JOIN ecoessentials_dim_promotion_campaign pc
    ON fs.campaign_key = pc.campaign_key
GROUP BY c.customer_city, pc.campaign_name
ORDER BY total_products_bought DESC;
<img width="1467" height="879" alt="Screenshot 2026-03-26 at 12 02 58 PM" src="https://github.com/user-attachments/assets/ec0dab4e-b532-42cc-a79e-346d3a8c9ba7" />
