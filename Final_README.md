**Overview**

We designed and implemented a full end-to-end data warehousing solution for Eco Essentials, transforming raw marketing data into a structured, automated, and analytics-ready platform.
This included designing an enterprise data warehouse, building ELT pipelines in Snowflake using Fivetran and dbt, implementing data quality and scheduling processes, and delivering a business-facing dashboard to support decision-making around sales performance and marketing campaign success. Below we will describe the project broken out into four parts.

---
**Part 1: Enterprise Data Warehouse Design**

First, we were given a business problem for eco essentials. That was “Eco Essentials, an eco friendly cookware company, seeks to optimize its data infrastructure to gain deeper insights into its operations and customer behavior. The dimensional model will enable Eco Essentials to analyze sales trends and make informed business decisions.”

We identified the two business processes they had in order to solve this problem. They had both sales data and email marketing data that needed to be combined into a dimensional model for decision making. The grain of these problems were an individual sale at an individual point of time.

To create this model we created a star schema that would give insight into sales and email marketing. We then combined these schemas with conformed dimensions so we could see the cause-and-effect these have on one another. Below is the final schema we ended up using showing the database structure we needed to create to solve their business problem.

<img width="1060" height="597" alt="Screenshot 2026-04-23 at 5 16 37 PM" src="https://github.com/user-attachments/assets/49df969b-2b80-4e52-a2e9-1eccebdc6987" />

---
**Part 2: ELT Pipeline Development (Fivetran + Snowflake + dbt)**

Second, we created a pipeline to pull in the raw data, transform it, and load it into a space where it could be used. We extracted our data from a PostgreSQL transaction database and an S3 bucket using Fivetran.

After which we loaded the raw data into Snowflake using landing tables. Once the raw data was in Snowflake we could inspect the data and make sure that all of our connections and business assumptions were correct. Taking this time with the raw data was very helpful. And the lack of time spent on certain tables made future decisions a lot harder.

We had to make a couple iterations to our initial schema based on feedback given after part 1. We realized we had not conformed the Customer and time dimensions correctly. The customer table also had subscribers and we needed to make sure there was a distinction between the two. Time was also tricky. We found out that both operational databases had timestamps but they would sometimes import wrong through fivetran. Making a conformed dimension of date and time separately ended up giving us a more detailed and flexible grain.

We then used dbt to transform and import our data into Snowflake following our schema design outlined in part 1. After connecting our tables through primary and foreign key relationships under a star schema, we added two .yml files to describe both our source and new schema data. **All code used to do the transforming is in this github.**

A large issue we ran into was creating the customer dimension. We found out that not all customers had unique id’s. Additionally, we needed to make sure we included all customers and subscribers. But we did not want to duplicate a person if they were both a customer and a subscriber. In order to fix this we ended up creating a surrogate key based on the combination of first and last name. We created a CTE in order to create a full join on the customer and subscriber tables. This allowed us to find all people (customers and subscribers), give them a unique identifier and find out accurately which ones were subscribers and which weren’t.

Another issue we had was with the date and time dimension. For the date, we realized we could use a CTE and a dbt_get function to pull all the fields we would need for our grain. Time was a little trickier. In order to connect it to both databases we ended up pulling the timestamps from both tables and joining them with a UNION. After which we selected the distinct keys and parsed them into the useful time measures (like hour or minutes).

Finally we wrote three sample business questions to ensure our data warehouse was navigable. 

---
**Part 3: Testing and Scheduling**

We ensured data quality by building test cases in dbt, checking for unique, not_null, accepted_values, and relationships between tables. Because of this testing, we discovered that there were duplicates in the customer table. We were able to fix this issue by adding a DISTINCT clause, and with that successfully implemented our database. These tests also helped us confirm that our conformed dimensions were created properly.

We set up two connections through Fivetran to sync every 24 hours. Next we created a job to run every time the connection syncs, to go through each test case we wrote earlier and make sure our data is properly formatted. This ensures that the model is always up to date, and that it doesn't lose functionality/encounter uncaught errors on future updates. 

---
**Part 4: Data Visualization and Communication**
Finally, we imported our data into Tableau through a live connection to Snowflake. With this, we created graphs outlining the success of various ecoessentials marketing campaigns. We created a calculated field for revenue and built bar charts, heat maps, and a geospatial heatmap showing revenue per state. We combined these graphs into a dashboard that filters each graph by state the user clicked on in the geographical map. We then presented this dashboard to Eco-Essential leaders. 

**Overview Dashboard:**

<img width="1463" height="882" alt="Screenshot 2026-04-23 at 5 33 54 PM" src="https://github.com/user-attachments/assets/0da1533b-506c-4901-b8e9-a94c4a32bd92" />

**Filtered Down to California:**

<img width="1459" height="885" alt="Screenshot 2026-04-23 at 5 34 03 PM" src="https://github.com/user-attachments/assets/7d6a9423-9960-4916-a74f-96eec7e00855" />

