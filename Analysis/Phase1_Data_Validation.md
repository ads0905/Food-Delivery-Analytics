# Phase 1 — Data Exploration \& Validation

This phase focuses on understanding and validating the food delivery database before performing business analysis.


## 1 Business Problem

How many records are present in each table of the food delivery database?

## Objective

To understand size of each tables present in the dataset before performing buisness analysis.

## SQL Query

select 'customers' as table_name, count(*)

as record_count from food_delivery.customers

UNION ALL

select 'restaurants',

count(*)  from food_delivery.restaurants

UNION ALL

select 'menuitems',count(*)

from food_delivery.menuitems

UNION ALL

select 'orders',count(*)

from food_delivery.orders

UNION ALL

select 'orderitems',count(*)

from food_delivery.orderitems

UNION ALL

select 'delivery_partners',count(*)

from food_delivery.delivery_partners

UNION ALL

select 'payments',count(*)

from food_delivery.payments

UNION ALL

select 'ratings',count(*)

from food_delivery.ratings;


## Output





|Table_Name|Record_Count|
|-|-|
|customers |       1530|
|delivery_partners| 60 |
|menuitems|        7000|
|orderitems|       8000|
|orders|           4000|
|payments|         4000|
|ratings|          1000|
|restaurants|       350|



##  Insights

The Record_count for all the tables in this database is sufficient to perform data analysis.
And The database contains records across all major tables, with the Orderitems table containing the highest number of records among the tables analyzed.



## 2 Buisness Problem

What percentage of orders have complete transaction records, including a payment, delivery partner, and customer rating?

##  Objective

To determine what proportion of orders contain complete payment, delivery, and customer feedback information.


## Sql Query

select 

round(count(distinct o.order_id) * 100/

(select count(*) from

food_delivery.orders)) as order_percent

from food_delivery.orders as o join

food_delivery.payments as p on

o.order_id=p.order_id  join

food_delivery.delivery_partners as dp

on o.partner_id=dp.partner_id

join food_delivery.ratings as r

on o.order_id=r.order_id

where o.order_id is not null

and p.payment_id is not null

and dp.partner_id is not null

and r.order_id is not null;


(Here i use distinct to remove the duplicate values).

(Here i use round() fnc bcs its actually takes round off value).

(Here i use count() aggregate fnc  to count order\_id).

(Here i apply JOINS Concept within the tables).


## Output



|Order_Percent|
|-|
|25|


## Insights

Only 25% of orders have complete transaction records  including payment,delivery partner and ratings. This indicates that  75% of orders are missing atleast one of these records, highlighting significant data completeness.

## Recomendation

Improve data completeness by implementing validation checks and ensuring proper synchronization between order, payment, delivery, and rating records. Investigate the 75% of orders with missing associated records to identify the root causes.


## 3 Buisness Problem

Are there any orders with missing or inconsistent releated records?



1. How many orders are missing payment records?

## Objective

To basically find out the missing records of orders in the payments table or records.


## Sql Query

select count(*) as missing_orders from

food_delivery.orders as o left join

food_delivery.payments as p

on o.order_id=p.order_id

where p.order_id is null;



using count fnc to get the number of orders records.

using IS NULL by which we get the missing records of orders.

using Left Join.


## Output



|missing_orders|
|-|
|0|


## Insights

After Validating the data between these records , their are (0) missing orders in payment records as their are 4000 order placed and 4000 payment have been occured.

2. How many orders are missing customer rating records ?

## Objective

To validate or find out the missing orders records in the ratings records table.


## Sql Query

select count(*) as missing_ordersfrom_rating from

food_delivery.orders as o

left join food_delivery.ratings as r

on o.order_id = r.order_id

where r.order_id is null;



using count fnc to get the number of orders records.

using IS NULL by which we get the missing records of orders.

using Left Join.


## Output

|missing_ordersfrom_rating|
|-|
|3000|


## Insights

After validating the records it has shown that 75% of orders records are missing from the ratings table as only 25% of orders get the ratings by the customers.

## Recomedation

Improve the post-delivery feedback process and implement validation checks to ensure customer ratings are consistently captured and linked to the corresponding orders,and connect with delivery partners so they ask directly for feedback from the customer.



3. How many orders are missing delivery partner records?


## Objective

To validate or find out the missing orders records in the delivery partners records table.


## Sql Query

select count(o.order_id) as missing_orders

from food_delivery.orders as o left join

food_delivery.delivery_partners as dp

on o.partner_id = dp.partner_id

where o.order_id is null;


## Output

|missing_orders|
|-|
|0|


## Insights

After validating the records it has shown that None of orders records are missing from the delivery\_partners table as 100% of orders delivered by the riders to customers.



## 4 Buisness Problem

Are there any duplicate order records in the Orders table?


## Objective

To find out the duplicate entries of orders in the dataset.



## Query

select *,count(*)

as duplicate_orders

from food_delivery.orders

group by order_id

having duplicate_orders>1;



Here we use count() agregate functions to count the duplicate records.

Then we apply group by on column order\_id to make the group of order\_id rows.

using Having filter for filtering the records after applying group by.







## Output

The orders table do not contain any duplicate records as (no) same order\_id repeated once.


## Insights

After Analysis None duplicate records identified in the orders table and it indicates thatsame order  cannot be placed .

And each order is uniquely recorded.It will reduces the affect of revenue and other buisness analysis.


## 5 Buisness Problem

Are there any duplicate order records in the customers table?


## Objective

To find out the duplicate entries of Customers in the dataset.


## Query


with duplicate_customers as(

 select customer_name,cust_city,cust_phn,

 row_number() over(partition by customer_name,cust_phn,cust_city

 order by customer_id)

 as rwn from food_delivery.customers

)



select * from duplicate_customers

where rwn>1;



Here we use CTE's because it makes complex query looks better.

Inside the CTE's i apply window function using (row_number) which assign data a row number .

Uses Order by for sorting the duplicate data in asc order.

the temporary table name is duplicate_customers.



## Output

The query identified 30 duplicate customer records.


* A sample of the duplicate records is shown below:

![Duplicate customer output](../Screenshots1/Customer_duplicate%20records.png)

Note: The complete result contains 30 duplicate records.


## Insights

30 duplicate customer records were identified based on matching customer details.

This indicates potential data-quality issues in the Customers table and may lead to.

Inaccurate customer counts or customer-level analysis if duplicates are not handled.



## Recomendation

Review and clean the 30 identified duplicate customer records.

Implement data-validation rules for key customer attributes such as

mobile number and email to prevent future duplicates.










