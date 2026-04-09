17_ecoessentialsscheduling Deliverable:

**Deliverable 2 Changes:**

We finished conforming the customer dimension by creating a surrogate key using the first and last names in customer/subscriber. We also included the subscriber id so that we can tell who is a subscriber and who is not.
We also fixed our joins to the fact tables by joining them on the first and last names, making our fact tables accurate. We also fixed duplicate values in dim promotion campaign and dim customer. 
The code for these changes have been pushed to main from Final_Part_2 & Final_Part_3 and can be seen there :)

**Deliverable 3 Screenshots:**

Tyson Merrill's Screenshots

A screenshot of the sync settings for both fivetran connectors showing the sync frequency of 24 hours for both partners

<img width="1909" height="1072" alt="Screenshot 2026-04-09 at 12 48 58 PM" src="https://github.com/user-attachments/assets/c8a72f4e-ba0a-40be-9ca3-c202c739eaab" />
<img width="1908" height="1074" alt="Screenshot 2026-04-09 at 12 50 25 PM" src="https://github.com/user-attachments/assets/3ce6d334-91c8-45e8-bb54-6fbf455620da" />

A screenshot of your dbt job configuration before clicking 'save' that shows the commands used to build the models and the schedule you chose to run it on for both partners. 

<img width="1901" height="1079" alt="Screenshot 2026-04-09 at 12 54 10 PM" src="https://github.com/user-attachments/assets/4b62f45d-8cee-49e4-8f2e-ab506aba431d" />

A screenshot of a successful job completion for the newly created job showing all of the models and tests that completed successfully for both partners. 

<img width="1916" height="1079" alt="Screenshot 2026-04-09 at 12 56 45 PM" src="https://github.com/user-attachments/assets/67dcd5e7-cd4e-434b-9cfd-60bdb1ea82f1" />

Taz Johnson's Screenshots

Fivetran Sync Frequency
<img width="2559" height="1331" alt="image" src="https://github.com/user-attachments/assets/c54b8670-43c2-4d89-893d-8996429286f9" />
<img width="2558" height="1336" alt="image" src="https://github.com/user-attachments/assets/b90bb9d7-9446-4bf9-b93b-6d573211fe3e" />

dbt Job Configuration:
<img width="2559" height="1388" alt="image" src="https://github.com/user-attachments/assets/b5d965e0-b18b-4833-8a49-1cc5af3cfae1" />

Successful Job Run: 
<img width="2559" height="1388" alt="image" src="https://github.com/user-attachments/assets/4d29001e-178d-4733-b0fa-0c3b765b9453" />
