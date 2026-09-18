
## 1 Buisness Problem

Which are the top  5 restaurants which generates the highest total revenue.


## Objective

To fetch those top 5 listed  restaurants which generates highest total revenue.


## Sql Query

with restaurants_total_revenue as (
select r.restaurant_id,r.restaurant_name,r.rest_location
,sum(total_amt) as total_revenue
from food_delivery.restaurants as r join
food_delivery.orders as o
on r.restaurant_id=o.restaurant_id
group by restaurant_id,restaurant_name
order by restaurant_id asc

),
ranked_restaurants as (
select restaurant_id,restaurant_name,rest_location,total_revenue
,rank() over(order by total_revenue desc) as rnk 
from restaurants_total_revenue

)

select restaurant_id,restaurant_name,rest_location,total_revenue,rnk
from ranked_restaurants
where rnk <=5
order by rnk asc limit 5;

## Key Points

1- Using sum() fnc to calculate total revenue by each restaurant  using 
group by.
2-Using window functions rnk() to assign ranks to to the restaurants .
3-Using where clause to get upto 5 rnk and using limit to get only 5 top 
restaurants.


## Output

We have got top 5 restaurants,listed below.

![Query output]
(screenshots1
top5_restaurants.png)


## Insights

Flavor Kitchen 56 is the highest revenue-generating restaurant, with total revenue of 20,694, followed by Flavor Palace 283 at 18,763.
The top 5 restaurants generated a combined revenue of 89,273, with Flavor Kitchen 56 contributing the largest amount.
There is a 3,904 revenue gap between the highest-performing restaurant (20,694) and the fifth-ranked restaurant (16,790), showing that the top 5 restaurants have relatively competitive revenue levels.


## Recommendations

Prioritize the top 5 restaurants for promotional campaigns and strategic partnerships because they are proven high-revenue contributors.
Analyze Flavor Kitchen 56's success factors—such as order volume, AOV, ratings, and customer demand—and apply those learnings to other restaurants.


##  2 Buisness problem

Which restaurants generate above-average of total_revenue?

## Objective

To find out the restaurants whose total_revenue is higher than the average_revenue.


## Sql Query

with restaurants_total_revenue as (
select r.restaurant_id,r.restaurant_name,r.rest_location
,sum(total_amt) as total_revenue
from food_delivery.restaurants as r join
food_delivery.orders as o
on r.restaurant_id=o.restaurant_id
group by restaurant_id,restaurant_name
order by restaurant_id asc

),

average_revenue as (
select avg(total_revenue) as avg_revenue from 
restaurants_total_revenue

)
select rs.restaurant_id,rs.restaurant_name,rs.rest_location,rs.total_revenue
,av.avg_revenue
from restaurants_total_revenue as rs cross join
average_revenue as av
where rs.total_revenue > av.avg_revenue;

# Key Points


1-using sum() fnc to find out restaurant_total_revenue.
2- using avg() fnc to find out avg of atalvg_of_total_revenue.
3- using CROSS JOIN for comparison with average_revenue.


## Output

![Query output - part 1]
(screenshots1
restaurants_avg output1.png)


![Query output - part 2]
(screenshots1
restaurants_avg output2.png)


## Insights


Street Palace 34 generates the highest revenue at ₹9,993, which is about ₹2,053 above the overall average of ₹7,939.88.

Curry House 29 has the lowest revenue at ₹8,320 among the displayed restaurants, but it is still above the overall average by ₹380.Street Palace 34 generates the highest revenue at ₹9,993, which is about ₹2,053 above the overall average of ₹7,939.88.

## Recommendations

Focus on restaurants closer to the average, such as Curry House 29, with targeted promotions and upselling strategies to increase revenue.
Use ₹7,939.88 as a performance benchmark and regularly monitor restaurants below this threshold to identify those needing promotional or operational support.



## 3 Buisness problem

Which restaurants  have high order volume but relatively low revenue?


## Objective 

To find out those restaurants who have maximum number of orders but the revenue they generate through 
this orders are relatively low.


## Sql Query


with order_volume as (
select r.restaurant_id,r.restaurant_name,r.rest_location,
count(*) as total_orders,sum(total_amt) as restaurant_revenue from food_delivery.restaurants as r
join food_delivery.orders as o 
on r.restaurant_id = o.restaurant_id
group by r.restaurant_id,restaurant_name
order by total_orders desc
),

low_revenue as (
select avg(restaurant_revenue) as avg_total_revenue
from order_volume

),

avg_order as (
select avg(total_orders) as average_orders_count
from order_volume

)

select ov.restaurant_id,ov.restaurant_name,ov.total_orders,
ov.restaurant_revenue,av.average_orders_count,lv.avg_total_revenue
from order_volume as ov cross join
avg_order as av cross join low_revenue as lv
where ov.total_orders > av.average_orders_count
and
ov.restaurant_revenue < lv.avg_total_revenue;

## Key Points

1-using sum() fnc to find out restaurant_revenue.
2- using avg() fnc to find out avg of avg_total_revenue and average_orders_count.
3- using CROSS JOIN for comparison with avg_total_revenue and average_orders_count.
4- using count() fnc to count total_orders.

## Output


![Query output - part 1]
(screenshots1
query3 output1.png)


![Query output - part 2]
(screenshots1
queryr3 output2.png)


## Insights

1-Some restaurants receive a higher-than-average number of orders but generate below-average revenue, indicating a relatively low revenue per order.
2-Strong Customer Demand but Low Monetization
  The high order count suggests strong customer demand; however, lower revenue indicates that these restaurants are not effectively converting their order volume into higher sales value.
3-Potentially Low Average Order Value
The combination of high order volume and low revenue suggests that customers may be purchasing lower-priced items or placing smaller orders.



## Recommendations

1-Introduce Combo and Meal Deals.

2-Create attractive combinations of main dishes, sides, and beverages to encourage customers to spend more per order.
  implement Upselling and Cross-Selling
3-Promote add-ons such as beverages, desserts, sides, and premium upgrades during the ordering process to increase average order value.



## 4 Buisness Problem 

Which restaurants receives the highest number of orders?


## Objective

To find out the restaurants who receives highest number of orders through the customers.


## Sql Query

select r.restaurant_id,r.restaurant_name,r.rest_location,
count(*) as total_orders from food_delivery.restaurants as r
join food_delivery.orders as o 
on r.restaurant_id = o.restaurant_id
group by r.restaurant_id,restaurant_name
order by total_orders desc;


## Key Points
1-Using count() fnc to count orders.

2- using  group by for grouping the rows and order by to sort the orders as from highest
to low number of orders.


## Output
![Query output - part 1]
(screenshots1
highest_orders output1.png)


![Query output - part 2]
(screenshots1
highest_orders output2.png)


## Insights

1. Four restaurants are tied for the highest order volume

Flavor Kitchen 56 – Raj Nagar: 22 orders
Food Hub 63 – Sector 76: 22 orders
Green House 177 – Sector 27: 22 orders
Flavor Palace 283 – Sector 74: 22 orders

These restaurants are the strongest performers in the visible results, indicating consistently high customer demand.

2. Restaurants generating 21–22 orders represent important high-demand partners for the food-ordering platform. Their strong order volumes can contribute significantly to overall platform activity.

3. However, high order count alone does not necessarily mean the restaurants generate the highest revenue or profit. Order volume should therefore be analyzed together with revenue, average order value, discounts, and customer ratings before making major business decisions.


## Recommendations

1. Prioritize high-performing restaurants
Strengthen partnerships with restaurants such as Flavor Kitchen 56, Food Hub 63, Green House 177, and Flavor Palace 283 because they are attracting high customer demand.

2. Use these restaurants as benchmarks
Compare lower-order restaurants with these high performers to identify opportunities for improvement in pricing, promotions, customer experience, and visibility.


## 5 Buisness problem 

Which menu items are the most frequently ordered?

## Objective

To basically finding out which are the menuitems that have been ordered frequently by the customers ,
so that we can try to channalize those menuitems as a prioriy in different offers.


## Sql Query

select oi.orderitem_id,oi.order_id,oi.item_id,mi.item_name,
sum(quantity) as frequently_asked
from orderitems as oi join 
menuitems as mi
on oi.item_id = mi.item_id
group by oi.orderitem_id,oi.order_id,oi.item_id
order by frequently_asked desc;


## Key Points

1. Using sum() fnc to calculate frequently_asked menuitems
2. Using group by for grouping the rows and order by for 
sorting the restaurant with max . menuitems.


## Output

![Query output - part 1]
(screenshots1
frequently_menuitems.png)


![Query output - part 2]
(screenshots1
frequently_menuitems1.png)


## Insights

1. Chole Bhature appears multiple times among the frequently ordered items.
It appears with different order_id/item_id combinations in the sample, indicating that this category of food has recurring customer demand.

2. Several items have a frequency of 3, including Kadhi Pakora, Rasmalai, Indian Combo, Lasagna, Onion Dosa, and Idli Sambar. These items also demonstrate repeated customer demand and can be considered secondary high-demand products.

3. Indian Combo is particularly noteworthy because it appears in both the frequency-4 and frequency-3 samples. This suggests that combo meals may have good potential for customer engagement and promotional campaigns.

## Recommendations 

1. Prioritize high-frequency items in promotional offers: Use frequently ordered items as the primary products in discounts, coupons, and limited-time offers.

2. Use popular items to attract customers: Feature high-frequency dishes prominently on the menu, homepage, and promotional banners.

3. Maintain sufficient availability: Frequently ordered items should have adequate inventory and preparation capacity to avoid missed sales due to unavailability.



## 6 Buisness Problem

Which 5 menu items generate the highest revenue?


## Objective 

To fetch out the five  menuitems which come out with highest revenue at last.


## Sql Query

select * from
( select oi.item_id,mi.item_name,
sum(oi.subtotal) as revenue,
row_number() 
over(order by sum(oi.subtotal)  desc) as rwn
from orderitems as oi 
join
menuitems as mi on
oi.item_id = mi.item_id
group by oi.item_id,mi.item_name
) as ranked_items
where rwn<=5;


## Key Points

1. Using window fnc concept to find out menuitems with maximum revenue through ranking.
2. Using sum() fnc to calculate revenue for orderitems .


## Output

f![Query output]
(screenshots1
five_max_menuitems_output.png)


## Insights

Insight: The analysis identifies the top five revenue-generating menu items, with Butter Naan leading at ₹5,837, followed by Veg Thali (₹5,388) and Veg Biryani (₹4,939). Together, these five items generated ₹25,489, highlighting their importance as key revenue contributors.


## Recommendations

The business should prioritize these high-revenue menu items in menu placement, promotions, and combo offerings while ensuring consistent availability. Revenue should also be analyzed alongside order frequency and profit margins to distinguish items that are both highly profitable and highly demanded.