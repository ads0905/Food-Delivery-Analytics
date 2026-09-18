
## 1 Buisness Problem

What is the distribution of payment methods?


## Objective

To know the distribution of payments that had been done by the customers for the orders.


## Sql Qyery

select payment_method,count(*) from 
payments group by  payment_method;

## Key Points 
1. count() fnc is used to count the mode of different payments.
2. using group by fnc to group payment_method rows.

## Output

f![Query output]
(screenshots1
payment_method_output.png)


## Insights 

The payment distribution is fairly balanced across all payment methods, with no single method dominating customer transactions.

Cash on Delivery (COD) is the most preferred method with 855 orders (21.4%).
Net Banking and Card each account for 798 orders (20.0%).
Wallet contributes 784 orders (19.6%), while UPI has the lowest share at 765 orders (19.1%).
Overall, the difference between the highest and lowest payment methods is only 90 orders, indicating that customers use a wide variety of payment options.


## Recommendation

Maintain all payment options while promoting digital payment methods through cashback, discounts, and targeted offers. This can gradually increase digital transactions while retaining COD for customers who prefer it.



## 2 Buisness Problem

 Which payment method generates the highest revenue?


## Objective

which is the only payment method from which company generates highest revenue.


## Sql Query

select p.payment_method,
sum(total_amt) as highest_revenue
from payments as p join
orders as o on
p.order_id=o.order_id
group by payment_method
order by highest_revenue desc limit 1;


## Key Points
1. using sum() fnc  to calculate revenue.
2. using inner join to get the similar outputs from both the table.
using group by  for grouping the payment_method rows and 
order by to sort the records according highest_revenue in desc.


## Output

f![Query output] 
(screenshots1
highest_payment_revenue_output.png)


## Insights

Cash on Delivery (COD) is the only payment method identified as generating the highest revenue of ₹590,183.

This indicates that although payment methods were relatively balanced in terms of order volume, COD customers contribute the highest overall revenue. This could mean that COD orders may have a higher average order value compared with other payment methods.


## Recommendations

Maintain COD as a key payment option while analyzing order value by payment method. Introduce targeted incentives for UPI and card payments to encourage digital adoption while retaining COD customers.



## 3 Buisness Problem

 Which Restaurants have the average customer rating less than 4?


## Objective

To find out those restaurants where average rating by customer is less than 4.


## Sql Query


select o.restaurant_id,o.customer_id,
round(avg(rating)) as average_customer_rating
from orders as o join
ratings as r on
o.order_id=r.order_id
group by rating_id
having average_customer_rating<4;

## Key Points

1. using avg() fnc to know the avg rating.
2. use group by  which group the rows of rating_id
and using having clause to filter ratinh less than 4.


## Output

![Query output - part 1]
(screenshots1
avg_rating_output1.png)


![Query output - part 2]
(screenshots1
avg_rating_output2.png)


## Insights 

The analysis shows that several restaurants have an average customer rating below 4, with some restaurants receiving ratings as low as 1–2. This indicates that these restaurants are experiencing customer dissatisfaction and may have issues related to food quality, service, delivery experience, or overall customer experience.

## Recommendations

Restaurants with ratings below 4 should identify the main reasons behind negative customer feedback and take corrective actions. They can improve food quality, order accuracy, delivery time, and customer service. Restaurants with ratings of 1–2 should be prioritized for immediate improvement, while continuously monitoring ratings after corrective actions.



## 4 Buisness Problem

Which restaurants have high revenue but low customer rating?


## Obhejtive

To find and know that restaurants which have doing good in terms of generating revenue,
but in terms of customer feedback those restaurants are getting low respone in terms of ratings.


## Sql Query


with restaurants_revenue as (
select restaurant_id,sum(total_amt) as 
high_revenue from orders 
group by restaurant_id
order by high_revenue desc
),

less_rating as (
select rating_id,rating,o.restaurant_id from ratings as r
join orders as o on r.order_id=o.order_id

)
select rr.restaurant_id,rr.high_revenue ,lr.rating 
from restaurants_revenue as rr join less_rating as lr
on rr.restaurant_id=lr.restaurant_id
having rating<4;


## Key Points

1. using sum() fnc to calculate the high_revenue using order by sorting.
2. using CTE's for query complexity.
3. Taking a value (4)  for filtering using having clause ,bcs we considering ratings<4
   it means low rating.


## Output

![Query output - part 1]
(screenshots1
revenue_low_rating_output1.png)


![Query output - part 2]
(screenshots1
revenue_low_rating_output2.png)

## Insights

The analysis highlights a revenue–customer satisfaction gap, where several high-revenue restaurants are receiving ratings below 4.0. Restaurants such as 209 and 18 stand out because they generate substantial revenue while receiving only 2-star and 1-star ratings respectively. This indicates a need to investigate customer complaints, food quality, service efficiency, and delivery experience. Addressing these issues can help restaurants improve customer satisfaction while protecting their existing revenue performance.


## Recommendations

Management should prioritize high-revenue restaurants with low customer ratings for detailed feedback analysis and operational improvements. By identifying the major causes of negative reviews and improving food quality, service consistency, delivery experience, and complaint resolution, the company can work toward improving customer satisfaction while maintaining the restaurants' existing revenue performance.




