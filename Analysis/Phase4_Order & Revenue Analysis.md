
## 1 Buisness Problem
 
What is the average order value that customers is placing?


## Objective

To find out the average value which customers spend on atleast on a single order.


## Sql Query

select avg(total_amt) as avg_order_value
from orders;

## Key Point
1. Uisng avg() fnc which is used to calculate the average.


## Output

f![Query output]
(screenshots1
avg_order_value_output.png)


## Insights 

The Average Order Value (AOV) is ₹694.74, which means customers spend approximately ₹695 per order on average. This indicates a reasonably strong average customer spend per transaction and provides a useful benchmark for evaluating order value and revenue performance.

## Recommendations 

The business should focus on increasing the AOV further through strategies such as combo offers, meal bundles, cross-selling complementary items, and minimum-order-value discounts. For example, offering a discount or free delivery above a certain threshold can encourage customers to add more items to their orders, thereby increasing revenue per transaction.


## 2 Buisness Problem

What are the top 10 largest orders?


## Objective 

To find those 10 orders who placed with the highest amount and how much difference is their between these
 orders in terms of amount.


## Sql Query

select * from 
(select order_id,order_date,
sum(total_amt) as largest_orders,
rank() over(order by sum(total_amt) desc) as rnk
from orders
group by order_id
) as highest_orders
where  rnk<=10;

## Key Points

1. Using window fnc ,rank() to rank top 10 orders in terms of ranking.
2. using group by to group the orders  and order by with sum(total_amt) in desc 
to get the highest number of orders first.


## Output

![Query output - part 1]
(screenshots1
top_10_highest_orders_output1.png)


![Query output - part 2]
(screenshots1
top_10_highest_orders_output11.png)


## Insight

1. The highest-value order was ₹2,932, while the 10th-highest order was ₹2,544.
2. Therefore, the difference between the highest and lowest order among the Top 10 is ₹388, indicating that these high-value orders are relatively close in value
3. Overall, the Top 10 orders fall within a relatively narrow range of ₹2,544–₹2,932, suggesting a consistent high-value customer/order segment.


## Recommendations

1. Identify the drivers behind high-value orders
   Analyze the restaurants, menu items, order quantities, and customer segments associated with these orders to determine what factors are contributing to orders above ₹2,500.
2. Create a high-value customer segment
   Customers who frequently place large orders can be classified as a premium/high-value segment and targeted with exclusive loyalty benefits, early access to offers, or personalized promotions.



## 3 Buisness Problem

 How does revenue vary by month?


## Objective

The objective was to find out how much revenue we are generating every month.


## Sql Query

select monthname(order_date) as months ,year(order_date) 
,sum(total_amt)
as monthly_order_revenue
from orders 
group by months,month(order_date),year(order_date)
order by month(order_date);

## Key Points
1. using date fnc,monthname() to fetch out months.
2. using sum() fnc for calculating total revenue .
3. using group by for grouping through months and year,
   and using order by for sorting according the month.


## Output

![Query output - part 1]
(screenshots1
monthly_revenue_output1.png)


![Query output - part 2]
(screenshots1
monthly_revenue_output2.png)


![Query output - part 3]
(screenshots1
monthly_revenue_output3.png)


## Insights

1. July 2026 generated the highest monthly revenue at ₹2,74,101, making it the strongest revenue-performing month in the available period.
2. December 2025 recorded the lowest revenue at ₹2,07,090, indicating a relatively weaker revenue performance compared with the other months.
3. Revenue fluctuated throughout the period rather than showing a consistent upward trend. For example, revenue increased from ₹1,99,721 in February 2026 to ₹2,31,282 in March, then declined slightly in April before reaching the yearly peak in July.
4. May 2026 (₹2,46,357) and July 2026 (₹2,74,101) were particularly strong months, suggesting there may be seasonal, promotional, or customer-demand factors contributing to higher revenue.


## Recommendations

1. Analyze what happened during May and July—such as order volume, AOV, popular menu items, restaurants, and promotions—to identify strategies that can be replicated in weaker months.
2. December and February had relatively lower revenue. The company could introduce targeted discounts, promotional campaigns, special combos, or customer reactivation campaigns during weaker periods.
3. Use monthly revenue as a KPI for performance monitoring,
   Track monthly revenue, order count, and AOV together rather than looking at revenue alone. This helps determine whether revenue changes are caused by more orders or higher customer spending.



## 4 Buisness Problem

Which day of the week generates the most orders?


## Objective

To know which days of a week were generating most orders .


## Sql Query

select dayname(order_date) as peak_days,
count(*) as number_of_orders
from orders 
group by peak_days
order by number_of_orders desc;

## Key Points
1. using dayname() fnc to know the dayname as peak_days.
2. using count() fnc to count number of orders.


## Output

![Query output - part 1]
(screenshots1
peak_days_orders_output1.png)


![Query output - part 2]
(screenshots1
peak_days_orders_output2.png)


## Insights

1. Wednesday is the peak order day, with 615 orders, making it the strongest day for customer demand.
2. Saturday ranks second with 583 orders, followed by Friday with 577 orders. This shows that demand is also relatively strong toward the weekend.
3. Tuesday has the lowest overall order volume at 519 orders, indicating comparatively weaker customer demand on this day.


## Recommendations

1. Increase operational capacity on peak days,
   Ensure sufficient restaurant availability, delivery partners, and customer support on Wednesday, Friday, and Saturday to handle higher order volumes efficiently.
2. Run targeted promotions on low-order days,
   Use offers, discounts, or loyalty rewards on Tuesday and Sunday to stimulate demand and balance order volume across the week.
3. Plan inventory according to demand,
   Restaurants can be encouraged to maintain adequate inventory of popular menu items before peak days to reduce stock-outs and missed orders.



## 5 Buisness Problem

What are the peak ordering hours?


## Objective 

To find out between which hrs orders are getting maximum placed.


## Sql Query


select hour(order_time) as peak_ordering_hrs,
count(*) as number_of_orders
from orders 
group by peak_ordering_hrs
order by number_of_orders desc;

## Key Points
1. using time fnc ,hour() where it shows only hrds from the whole time.
2. using count() fnc to calculate the orders.
3. using group by for grouping  and order by  for sorting.


## Output

![Query output - part 1]
(screenshots1
peak_hrs_orders_output.png)


## Insights

1. 21:00 (9 PM) is the peak ordering hour, with 350 orders, making it the highest-demand time slot.
2. 11:00 AM ranks second with 346 orders, followed by 3 PM with 344 orders and 2 PM with 339 orders.
3. The difference between the highest (9 PM) and fifth-highest hour (12 PM, 337 orders) is only 13 
   orders,indicating that these peak hours have fairly similar order volumes.


## Recommendations

1. Increase delivery capacity around 9 PM,
   Since 9 PM has the highest order volume, ensure sufficient delivery partners, restaurant capacity, and customer support during this period to minimize delays.
2.Optimize restaurant inventory before peak hours,
  Restaurants should prepare popular ingredients and menu items in advance of the 11 AM–3 PM and 9 PM peaks to handle increased demand efficiently.



## 6 Buisness Problem

What is the average order value by a restaurant?


## Objective

To find out the restaurants with their average order value to see the restaurant market value
according AOV.


## Sql Query

select r.restaurant_id,r.restaurant_name,
avg(total_amt) as avg_order_value
from restaurants as r join
orders as o on
r.restaurant_id=o.restaurant_id
group by restaurant_id;


## Key Points
1. using avg() fnc to count AOV.
2. Using group by for restaurant_id.


## Output

![Query output - part 1]
(screenshots1
restaurants_aov_output1.png)


![Query output - part 2]
(screenshots1
restaurants_aov_output2.png)


## Insights

1. The top 5 restaurants have AOVs above ₹1,090, suggesting that these restaurants attract 
   comparatively higher-value orders.
2. The difference between the highest AOV (₹1,389.50) and the fifth-highest (₹1,092.13) is approximately ₹297.37.
   This analysis helps identify restaurants with strong customer spending per transaction, but AOV alone should not be treated as a restaurant's complete "market value." A restaurant can have a high AOV but relatively few orders.


## Recommendations

1. Promote high-AOV restaurants
   Restaurants such as Cafe Tadka 114 can be considered strong candidates for premium offerings and featured placements, as their customers already demonstrate higher spending per order.
2. Study what drives their higher AOV
   Analyze their menu items, order quantities, cuisine/category, and combinations to identify what is causing customers to spend more.
3. Replicate successful strategies
   If high-AOV restaurants have effective combos, premium items, family meals, or add-ons, similar strategies can be encouraged among lower-AOV restaurants.