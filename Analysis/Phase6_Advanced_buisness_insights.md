
## 1 Buisness Problem

Who are the top 10 customers based on lifetime value?



## Objective 
(Customer lifetime value = Total spend by customers)
To find actually those 10 customers who are value to our company ,
on the basis of orders and revenues.


## Sql Query

with highest_revenue as(
select c.customer_id,c.customer_name,
sum(total_amt) as total_revenue
from customers as c join
orders as o on
c.customer_id=o.customer_id
group by c.customer_id,c.customer_name
order by total_revenue desc

),
ranked_ones as (
select customer_id,customer_name,total_revenue,
row_number() over(order by total_revenue desc) as rwn
from highest_revenue

)
select customer_id,customer_name,total_revenue,rwn
from ranked_ones
where rwn<=10
order by rwn asc limit 10;

## Key Points
1. Using two CTE's for this query.
2. using sum() aggregate fnc,and window fnc row_number 
for getting top 10 customers.
3. using order by for sorting with limit to get exact number of customers.


## Output

![Query output - part 1]
(screenshots1
customer_lifetime_value_output1.png)


![Query output - part 2]
(screenshots1
customer_lifetime_value_output2.png)


## Insights

1. The Top 10 customers generated between ₹6,254 and ₹8,136 in total revenue, indicating that these customers have contributed significantly to the company's revenue.
2. Rohan Arora has the highest lifetime spend of ₹8,136, followed by Sneha Kaur (₹7,573) and Harsh Joshi (₹7,252).
3. The difference between the highest and lowest customer spend is ₹1,882, showing that the top 10 customers have relatively strong and comparable spending levels.


## Recommendations

1. Prioritize customer retention
Of fer loyalty benefits, personalized discounts, and exclusive offers to retain these high-value customers.
2. Create a VIP/Loyalty segment
Introduce a rewards program where higher-spending customers receive benefits such as free delivery, cashback, or priority offers.
3. Increase their future spending
Use personalized recommendations, combo offers, and cross-selling to encourage these customers to place higher-value orders.
4. Monitor customer behavior regularly
Track their spending and order frequency over time so that a decline in activity can be identified early and retention campaigns can be triggered.



## 2 Buisness Problem

Rank the restaurants within each category based on revenue?


## Objective

To know restaurant revenue within the ctaegory and rank them according to their  revenue.


## Sql Query

with restaurant_category_revenue as (
select mi.category,o.restaurant_id,
sum(oi.subtotal) as revenue
from orders as o join orderitems as oi
on o.order_id = oi.order_id
join menuitems as mi on mi.item_id = oi.item_id
group by o.restaurant_id,mi.category
)

select restaurant_id,category,revenue ,
rank() over(partition by category order by revenue desc) as rnk
from restaurant_category_revenue

order by rnk,category;

## Key Points
1. Using CTE's to ease the query.
2. using sum() aggregate fnc to calculate total revenue.
3. use group by to group rows of restaurant and category 
and order by to male revenue in desc order to get highest revenue first.
4.Use window fnc rank() to assign ranks to restaurants.


## Output

![Query output - part 1]
(screenshots1
customer_lifetime_value_output1.png)


![Query output - part 2]
(screenshots1
customer_lifetime_value_output2.png)


![Query output - part 3]
(screenshots1
customer_lifetime_value_output3.png)


## Insights

Revenue ranking within categories identifies the leading restaurants in each food segment. Main Course restaurants show the highest revenue among the displayed results, led by Restaurant 56 with ₹18,612. The business can use these category-level rankings to benchmark restaurant performance, replicate successful practices, and provide targeted promotional support to lower-revenue restaurants.


## Recommendations

Your output ranks restaurants by revenue, but if your objective specifically says "on the basis of orders and revenues," you should ideally include total_orders alongside revenue. This would let you identify whether a restaurant's high revenue comes from many orders, higher-value orders, or both.



## 3 Buisness Problem

Find the top 3 menu items for each restaurant?


## Objective

To find top 3 items from each restaurant to analyze which items are priotizing 
by customers from the different restaurants on the basis of quantity.


## Sql Query 

  select * from 

	   (select mi.restaurant_id
	   ,mi.item_i
        mi.item_name,
        sum(oi.quantity) as total_quantity,

         row_number() 
         over(partition by restaurant_id order by sum(oi.quantity) desc )
         as rwn
         from menuitems as mi 
         join orderitems as oi
         on mi.item_id=oi.item_id 
         group by mi.restaurant_id,mi.item_id ) 
         as t
         where rwn<=3;


## Key Points
1. Using window fnc ,row_number() to asssign rows.
2. using sum() aggregate fnc to know the total quantity.
3. use partition by and order by to sort the revenue in desc and 
group by to group the rows.


## Output

![Query output - part 1]
(screenshots1
3menuitems_restaurant_output1.png)


![Query output - part 2]
(screenshots1
3menuitems_restaurant_output2.png)


## Insights

1. The top 3 items for each restaurant represent the most frequently purchased menu items based on quantity, indicating strong customer preference for these products.
2. Customer preferences vary across restaurants, suggesting that each restaurant has its own set of high-demand items.
3. Items with consistently high quantities can be considered key demand drivers and may contribute significantly to a restaurant's overall order volume.


## Recommendations

1. Prioritize high-demand items: Restaurants should ensure that their top-selling items remain consistently available and maintain adequate inventory.
2. Promote popular items: High-quantity items can be highlighted in menus, offers, combo meals, and recommendations to increase order volume.
3. Optimize inventory: Stock levels for frequently ordered items should be monitored closely to reduce the risk of stock-outs and missed sales.



## 4 Buisness Question

identify the customers who are frequent but low value customers ?


## Objective

To know those customers who are low value customers in terms of -:
1. High freuency+High Spending -  " VIP"
2. High Frequency+Low Spending -  "Frequent Low-Value
3. Low Frequency+High Spending -  "Occasional high value
4. Low Frequency+Low Spending  -  "Low Engagement

Note: Seprate this judgement as "customer_identidication"


## Sql Query

With customers_revenue AS (
    Select
        c.customer_id,
        c.customer_name,
        SUM(o.total_amt) AS total_revenue
    From customers AS c
    Join orders AS o
        On c.customer_id = o.customer_id
    Group by c.customer_id, c.customer_name
),

avg_revenue as (
    Select
        avg(total_revenue) AS avg_revenue
    From customers_revenue
),

customers_orders AS (
    Select
        c.customer_id,
        c.customer_name,
        Count(o.order_id) AS total_orders
    From customers AS c
    Join orders AS o
        on c.customer_id = o.customer_id
    group by c.customer_id, c.customer_name
),

avg_orders AS (
    Select
        avg(total_orders) AS avg_orders
    From customers_orders
)

Select
    cr.customer_id,
    cr.customer_name,
    cr.total_revenue,
    co.total_orders,
    ar.avg_revenue,
    ao.avg_orders,
    Case
        WHENcr.total_revenue > ar.avg_revenue
             AND co.total_orders > ao.avg_orders
            THEN 'VIP'

        WHEN cr.total_revenue > ar.avg_revenue
             AND co.total_orders < ao.avg_orders
            THEN 'Occasional High Value'

        WHEN cr.total_revenue < ar.avg_revenue
             AND co.total_orders > ao.avg_orders
            THEN 'Frequent Low Value'

        WHEN cr.total_revenue < ar.avg_revenue
             AND co.total_orders < ao.avg_orders
            THEN 'Low Engagement'

        ELSE 'Average'
    END AS customer_identification

from customers_revenue AS cr
Join customers_orders AS co
    on cr.customer_id = co.customer_id
Cross join avg_revenue AS ar
Cross join avg_orders AS ao;


## Key Points

1. using sum(),avg() aggregate fnc to calculate revenue and average revenue.
2. using count(),avg() aggregate fnc to count total_orders and average order.
3. use "Case When" concept for customer_identification scenario.
4. use cross join to compare with avg(revenue) and avg(count).


## Output

![Query output - part 1]
(screenshots1
case_customer_segmentation_output1.png)


![Query output - part 2]
(screenshots1
case_customer_segmentation_output2.png)


## Insights

Customer segmentation reveals four distinct behavioral groups based on order frequency and spending. Frequent Low-Value customers show strong engagement but relatively low spending, while Occasional High-Value customers demonstrate strong spending potential but lower purchase frequency. Low Engagement customers show limited activity on both dimensions, making them the primary segment for reactivation efforts.


## Recommendations

The business should use segment-specific strategies rather than applying the same promotion to all customers. Frequent Low-Value customers should be targeted with upselling and cross-selling, Occasional High-Value customers with repeat-order incentives, and Low Engagement customers with reactivation campaigns. VIP customers should primarily receive retention-focused benefits to maintain their engagement and spending.



## 5 Buisness Problem

Which restaurants should the buisness priotize for improvent?


## Objective

To know those restaurants where our buisnees priotize for improving in different areas in terms of -:
1. High Revenue+Low  Rating -  "Customer Experience Risk"
2. Low  Revenue+Low  Rating  -  "Needs Improvement"

Note: Seprate this judgement as "restaurant_identidication"


## Sql Query

WITH restaurants_revenue AS (
    SELECT
        r.restaurant_id,
        r.restaurant_name,
        SUM(o.total_amt) AS total_revenue
    FROM restaurants AS r
    JOIN orders AS o
        ON r.restaurant_id = o.restaurant_id
    GROUP BY r.restaurant_id, r.restaurant_name
),

avg_revenue AS (
    SELECT
        AVG(total_revenue) AS avg_revenue
    FROM restaurants_revenue
),

restaurants_rating AS (
    SELECT
        r.restaurant_id,
        r.restaurant_name,
        AVG(rt.rating) AS avg_rating
    FROM restaurants AS r
    JOIN orders AS o
        ON r.restaurant_id = o.restaurant_id
    JOIN ratings AS rt
        ON o.order_id = rt.order_id
    GROUP BY r.restaurant_id, r.restaurant_name
),

avg_rating AS (
    SELECT
        AVG(avg_rating) AS avg_rating
    FROM restaurants_rating
)

SELECT
    rr.restaurant_id,
    rr.restaurant_name,
    rr.total_revenue,
    ROUND(rt.avg_rating, 2) AS avg_rating,

    CASE
        WHEN rr.total_revenue > ar.avg_revenue
             THEN 'Customer Experience Risk'

        WHEN rr.total_revenue < ar.avg_revenue
             THEN 'Needs Improvement'
    END AS restaurant_identification

FROM restaurants_revenue AS rr
JOIN restaurants_rating AS rt
    ON rr.restaurant_id = rt.restaurant_id
CROSS JOIN avg_revenue AS ar
CROSS JOIN avg_rating AS at

WHERE rt.avg_rating < at.avg_rating;


## Key Points

1. using sum(),avg() aggregate fnc to calculate revenue and average revenue.
2. using,avg(rating) aggregate fnc to find average of  ravg(rating)
3. use "Case When" concept for restauarant_identification scenario.
4. use cross join to compare with avg(rating) and avg(count).


## Output

![Query output - part 1]
(screenshots1
case_restaurant_segmentation_output1.png)


![Query output - part 2]
(screenshots1
case_restaurant_segmentation_output2.png)


## Insights

The analysis identifies two restaurant groups requiring business attention. Restaurants with high revenue but low ratings represent a Customer Experience Risk, as strong demand is accompanied by poor customer feedback. Restaurants with both low revenue and low ratings fall into the Needs Improvement segment, indicating challenges in both customer satisfaction and business performance.


## Recommendations

The business should prioritize customer-experience improvements for high-revenue/low-rated restaurants to protect existing revenue, while low-revenue/low-rated restaurants should undergo broader operational and service improvements. Review analysis, food quality, delivery performance, menu optimization, and customer feedback can be used to identify the specific causes and track improvement over time.

