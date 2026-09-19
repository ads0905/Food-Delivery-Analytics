## 1 Buisness Probelem 

Who are the the top 10 customers by total number of orders?


## Objective

To fetch out or find out the top 10 customers 
who have placed maximum orders.


## Sql Query

with customer_orders as (  
select c.customer_id,c.customer_name ,c.cust_city
,count(o.order_id) as total_orders
from food_delivery.customers as c join food_delivery.orders as o
on c.customer_id=o.customer_id
group by c.customer_id,c.customer_name

),

ranked_customers as (
select 
customer_id,customer_name,cust_city,
total_orders,
dense_rank() over(order by total_orders desc) as rnk
from customer_orders

)

select customer_id,customer_name,cust_city,total_orders,rnk
from ranked_customers where rnk<=10
order by rnk limit 10;


# Key Points
1- Using CTE's and make a temperory tables (customer_orders),(ranked_customers)
to make sure the query looks sorted and easy to understand.
2-Using window functions, (dense_rank()) to assign ranks to top 10 customers.
3- using count() fnc to count orders by each customers 
through group by and use limit for only 10 customers.


## output

Showcasing who are those to 10 customers according to their number of orders.

![Query output - part 1](../Screenshots1/top20%10_customers_output1.png)



![Query output - part 2](../Screenshots1/top20%10_customers_output2.png)


## Insights

Rahul Chopra and Nisha Rao are the most frequent customers, with 9 orders each, making them the highest-ranked customers in the output.
Noida has a strong presence among frequent customers — Rahul Chopra, Nisha Rao, Tanya Chopra, Rohan Goyal, Karan Kapoor, and Kavya Singh are all from Noida.
Ghaziabad also shows strong repeat-order behavior, with Aarohi Nair having 8 orders and Ananya Arora, Kabir Chopra, and Ravi Khanna having 7 orders each.


## Recommendations

Introduce loyalty rewards for frequent customers such as Rahul Chopra and Nisha Rao to encourage continued ordering and improve retention.
Target Noida and Ghaziabad with repeat-customer campaigns, since both cities have several customers with high order frequency.
Use personalized recommendations and bundle offers for frequent customers to increase their average order value, rather than focusing only on increasing order frequency.



## 2 Buisness Problem

Who are the top 3 customers by total spending?


## Objective 

To find out or fetch the top three customers who spends maximum money on the orders.


## Sql Query 

with customer_spending as (
select c.customer_id,c.customer_name,c.cust_city,
sum(o.total_amt) as total_spending from
food_delivery.customers as c join food_delivery.orders as o 
on c.customer_id=o.customer_id
group by c.customer_id,c.customer_name

),
ranked_customers as (
select customer_id,customer_name,cust_city
,total_spending,
row_number() over(order by total_spending desc ) as rnk
from customer_spending

)
select customer_id,customer_name,cust_city,total_spending,rnk
from ranked_customers 
where rnk<=3;


# Key Points
1- uses sum() aggregate fnc to find out total spending of the top three customers.
2- uses window fnc,(row_number()) to assign positions to the customers the find top three.
3- uses group by and order by for grouping and sorting.


## Output

![Query output](../Screenshots1/top20%3_customers_output1.png)


## Insights

Rohan Arora is the highest-spending customer, with total spending of ₹8,136, followed by Sneha Kaur (₹7,573) and Harsh Joshi (₹7,252).
All three top customers are from Ghaziabad, indicating that Ghaziabad has a strong concentration of high-value customers in this dataset.
The spending difference between the highest and third-highest customer is only ₹884, showing that these three customers have relatively similar spending levels.


## Recommendations

Create a VIP/loyalty program for these high-value customers with exclusive rewards to encourage retention and repeat purchases.
Analyze Ghaziabad customer behavior and consider targeted promotions in this city to attract more high-spending customers.
Use personalized offers and recommendations for these customers based on their previous orders to increase their lifetime value.


## 3 Buisness Problem

Find out he customers from noida whose average order value is more than 1500


## Objective 

To basically try to find out customers who belongs to noida and their average order_value for a order 
is above than 1500.


## Sql Query

select c.customer_id,c.customer_name,c.cust_city,avg(o.total_amt) as
avg_order_value
from food_delivery.customers as c join
food_delivery.orders  as o
on c.customer_id=o.customer_id
where c.cust_city='noida'
group by c.customer_id
having avg_order_value > 1500; 


# Key Points
1- uses (avg()) aggregate fnc for find out the averages.
2-Using joins and group by.
3- where filter to get only customers belongs to noida.


## Output

There are only 17 almost around (1.11%) customers from noida whose average order value is above than 1500.

![Query output - part 1](../Screenshots1/avg_order_value_noida20%output1.png)


![Query output - part 2](../Screenshots1/avg_order_value_noida20%output2.png)


## Insight

Aditi Malhotra has the highest average order value at ₹2,430, significantly higher than the other customers shown.
All identified high-AOV customers are from Noida, indicating a concentration of high-value ordering behavior within this city.
The average order value ranges from ₹1,585 to ₹2,430, showing a substantial difference in spending per order among these customers.


## Recommendation

Target Aditi Malhotra and other high-AOV customers with premium offerings, personalized recommendations, and exclusive deals to maintain their high spending behavior.
Introduce minimum-order-value-based promotions for customers with lower AOV, such as Rahul Sinha (₹1,585), to encourage larger purchases.


## 4 Buisness Problem

Which Customers are high value customers?
(As whose total spending is above than overall average customer spending)


## Objective

To basically find out those customers whose total_spending on the orders are more than
the average of total_spending by customers.


## Sql Query

with customer_spending as(
select c.customer_id,c.customer_name,
sum(o.total_amt) as total_spending
from food_delivery.customers as c
join food_delivery.orders as o
on c.customer_id=o.customer_id
group by customer_id

),

customer_average_spending as(
select 
avg(total_spending) as overall_avg_customerspending
from customer_spending

)
select cs.customer_id,cs.customer_name,cs.total_spending,av.overall_avg_customerspending
from customer_spending as cs cross join  customer_average_spending as av
where cs.total_spending>av.overall_avg_customerspending;

# Key points
1-using sum() fnc to find out total_spending.
2- using avg() fnc to find out avg of total_spending.
3- using CROSS JOIN for comparison with avg(total_spending).


## Output

There are 39.01% of customers are considered to be high value customers.

Some of the customers are listed below:

![Query output - part 1](../Screenshots1/high_value_customers20%output1.png)


![Query output - part 2](../Screenshots1/high_value_customers20%output2.png)


## Insight

Harsh Singh is the highest-spending customer in the displayed segment, with total spending of ₹5,460, which is significantly above the overall average of ₹1,990.66.
All six customers shown are above the overall average spending of ₹1,990.66, indicating that they qualify as high-value customers under this criterion.
There is a large difference in spending within the high-value segment — Harsh Singh spends ₹5,460, while Meera Mehta spends ₹2,010, showing that high-value customers can have very different spending levels.


## Recommendation

Use targeted upselling and cross-selling for customers only slightly above the average, such as Meera Mehta, to encourage them to increase their spending.
Segment high-value customers based on spending levels rather than treating them as one group—for example, VIP, premium, and emerging high-value customers.


## 5 Buisness Problem

Which customers have placed multiple orders but have low average order?


## Objective

The aim is to find those customers who placed number of orders but their avg.order value for 
the orders are low.


## Sql Query

with multiple_orders_customers as(
select c.customer_id,c.customer_name ,count(o.order_id) as total_orders,
avg(total_amt) as customer_avg_ordervalue
from food_delivery.customers as c join
food_delivery.orders as o
on c.customer_id=o.customer_id
group by c.customer_id

),
average_aov as (
select avg(total_amt) as avg_total_amt
from food_delivery.orders

)
select mo.customer_id,
       mo.customer_name,
       mo.total_orders,
       mo.customer_avg_ordervalue
from multiple_orders_customers as mo 
cross join average_aov as av
where mo.total_orders>2
and mo.customer_avg_ordervalue < av.avg_total_amt;

# Key Points

1-using sum() fnc to find out customer_avg_ordervalue.
2- using avg() fnc to find out avg of customer_avg_ordervalue.
3- using CROSS JOIN for comparison with avg_total_amt.


## Output

![Query output - part 1](../Screenshots1/multiple_orders20%output1.png)

![Query output - part 2](../Screenshots1/multiple_orders20%output2.png)


## Insights

27.32% of customers are repeat customers but have a low average order value, indicating good customer retention but limited spending per order.
These customers provide an opportunity to increase revenue without necessarily acquiring new customers.
Their repeated purchases suggest strong engagement, but there is potential to increase their basket size.


## Recommendations 

Use personalized offers and combo deals to encourage customers to add more items per order.
Introduce free-delivery thresholds or minimum-order discounts to increase average order value.
Recommend complementary/add-on products during checkout to encourage higher spending.








