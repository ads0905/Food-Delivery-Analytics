# 🍽️ Food Delivery Analytics & RFM-Oriented Customer Segmentation

> **SQL-based business analytics project for a food-delivery platform**
> An end-to-end MySQL project focused on customer behavior, restaurant
> performance, menu-item demand, revenue trends, payment behavior,
> ratings, and customer segmentation.

------------------------------------------------------------------------

## 📌 Project Overview

This project analyzes a food-delivery database designed around a
Swiggy/Zomato-style business model.

The goal is to transform transactional data into **business insights and
actionable recommendations** using SQL.

The analysis covers:

-   Customer behavior and spending
-   Customer lifetime value
-   Customer frequency and monetary segmentation
-   Restaurant revenue and order performance
-   Menu-item demand
-   Category-level restaurant revenue
-   Average Order Value (AOV)
-   Monthly revenue trends
-   Peak ordering days and hours
-   Payment-method distribution and revenue
-   Customer ratings and restaurant experience
-   Data completeness and validation

The project progresses from **data exploration and validation →
descriptive analytics → advanced business analysis and segmentation**.

------------------------------------------------------------------------

## 🎯 Business Objectives

The project was built to answer practical business questions such as:

1.  How large and complete is the food-delivery database?
2.  Which customers place the most orders?
3.  Which customers generate the highest revenue?
4.  Which customers have high frequency but relatively low value?
5.  Which restaurants generate the most revenue?
6.  Which restaurants have high order volume but relatively low revenue?
7.  Which menu items are most frequently purchased?
8.  Which menu items generate the highest revenue?
9.  What is the average order value?
10. How does revenue vary by month?
11. Which days and hours have the highest order demand?
12. Which payment method is most frequently used?
13. Which payment method generates the highest revenue?
14. Which restaurants have lower customer ratings?
15. Which restaurants have high revenue but low customer ratings?
16. Which restaurants lead within each food category?
17. Which customers have the highest lifetime spend?
18. How can customers and restaurants be segmented for targeted business
    actions?

------------------------------------------------------------------------

## 🗂️ Database Structure

The database contains **8 interconnected tables**:

  Table                 Purpose                           Records
  --------------------- ------------------------------- ---------
  `customers`           Customer master information         1,530
  `restaurants`         Restaurant information                350
  `menuitems`           Restaurant menu and pricing         7,000
  `orders`              Customer order transactions         4,000
  `orderitems`          Items contained in each order       8,000
  `delivery_partners`   Delivery partner information           60
  `payments`            Payment transactions                4,000
  `ratings`             Customer ratings and reviews        1,000

The database structure and relationships are represented in the
project's ER diagram.

### 🔗 Main Relationships

-   `customers` → `orders`
-   `restaurants` → `orders`
-   `delivery_partners` → `orders`
-   `orders` → `orderitems`
-   `menuitems` → `orderitems`
-   `orders` → `payments`
-   `orders` → `ratings`

------------------------------------------------------------------------

## 🧩 ER Diagram

Add the ER diagram to your repository and keep the following section:

[Food_delivery Analysis](<../OneDrive/Desktop/Food_Delivery Analysis/Database/EER Diagram>)


------------------------------------------------------------------------

# 🔎 Project Analysis

## Phase 1 --- Data Exploration & Validation

The first phase validates the database before business analysis.

### Key Checks

-   Record counts across all tables
-   Transaction completeness
-   Missing payment records
-   Missing rating records
-   Missing delivery-partner records
-   Duplicate order records
-   Duplicate customer records

### Important Finding

The database contains **4,000 orders and 4,000 payment records**, while
only **1,000 ratings** are present.

The complete transaction check shows that 25% of orders contain
payment, delivery-partner and rating information together**, meaning 75%
of orders are missing at least one of these associated records.

This highlights an important **data-completeness issue**, especially
around customer ratings.

### Business Recommendation

Improve synchronization and validation between order, payment, delivery
and rating systems. The rating process should also be strengthened so
that customer feedback is consistently captured.

------------------------------------------------------------------------

# 👥 Phase 2 --- Customer Analysis

This phase focuses on understanding customer ordering and spending
behavior.

### Analyses Performed

-   Top 10 customers by order frequency
-   Top 3 customers by total spending
-   High-AOV customers from Noida
-   High-value customers above average spending
-   Customers with multiple orders but low AOV

### Key Findings

The highest-frequency customers include:

-   Rahul Chopra --- 9 orders
-   Nisha Rao --- 9 orders
-   Tanya Chopra --- 8 orders
-   Rohan Goyal --- 8 orders
-   Karan Kapoor --- 8 orders

Several frequent customers are from **Noida and Ghaziabad**, showing
strong repeat-order behavior in these cities.

The Noida high-AOV analysis identified customers with average order
values above **₹1,500**, with Aditi Malhotra showing an AOV of
**₹2,430** in the provided output.

### Business Recommendations

-   Introduce loyalty rewards for frequent customers.
-   Use personalized recommendations and bundle offers.
-   Apply minimum-order-value promotions to encourage larger baskets.
-   Develop city-specific customer campaigns where repeat behavior is
    concentrated.

------------------------------------------------------------------------

# 💰 Phase 3 --- Restaurant & Menu Analysis

This phase evaluates restaurant performance and menu-item demand.

### Analyses Performed

-   Top 5 restaurants by revenue
-   Above-average revenue restaurants
-   High-order-volume / low-revenue restaurants
-   Restaurants receiving the highest number of orders
-   Most frequently ordered menu items
-   Highest-revenue menu items
-   Top 3 menu items for each restaurant
-   Restaurant revenue ranking within food categories

### Top Revenue Restaurants

The provided analysis identified:

    Rank Restaurant            Revenue
  ------ ------------------- ---------
       1 Flavor Kitchen 56     ₹20,694
       2 Flavor Palace 283     ₹18,763
       3 Wok Palace 93         ₹17,474
       4 Desi Cafe 161         ₹17,252
       5 Kitchen Route 153     ₹16,790

The five restaurants generated a combined **₹89,273** in the analyzed
output.

### High Order Volume but Lower Revenue

Some restaurants receive more than the average number of orders while
generating below-average revenue.

This indicates a potential **low-revenue-per-order / low-AOV
opportunity**.

### Business Recommendations

-   Introduce combo and meal deals.
-   Use upselling and cross-selling.
-   Promote add-ons such as beverages, sides and desserts.
-   Study successful high-revenue restaurants and replicate relevant
    practices.
-   Keep high-demand menu items available and optimize inventory.

------------------------------------------------------------------------

# 📈 Phase 4 --- Order & Revenue Analysis

This phase focuses on transaction value and demand patterns.

### Average Order Value

The overall AOV from the provided dataset is:

> **₹694.74 per order**

This provides a useful benchmark for evaluating order-value performance.

### Monthly Revenue

The highest monthly revenue in the provided analysis was:

> **July 2026 --- ₹2,74,101**

The lowest shown was:

> **December 2025 --- ₹2,07,090**

Revenue fluctuated over the analyzed period rather than following a
consistent upward trend.

### Peak Ordering Days

  Day           Orders
  ----------- --------
  Wednesday        615
  Saturday         583
  Friday           577
  Monday           574
  Thursday         570
  Sunday           532
  Tuesday          519

**Wednesday** recorded the highest order volume.

### Peak Ordering Hours

The leading ordering hours were:

     Hour   Orders
  ------- --------
    21:00      350
    11:00      346
    15:00      344
    14:00      339
    12:00      337

### Business Recommendations

-   Increase delivery capacity around peak hours.
-   Prepare inventory before high-demand periods.
-   Use promotions on relatively weaker days.
-   Track revenue, order count and AOV together as core KPIs.

------------------------------------------------------------------------

# 💳 Phase 5 --- Payment & Rating Analysis

## Payment Method Distribution

The payment data shows a relatively balanced distribution:

  Payment Method       Orders
  ------------------ --------
  Cash on Delivery        855
  Net Banking             798
  Card                    798
  Wallet                  784
  UPI                     765

Cash on Delivery is the most-used payment method in the provided output.

## Payment Method by Revenue

Cash on Delivery generated the highest revenue in the provided analysis:

> **₹5,90,183**

This indicates that payment-method order volume and payment-method
revenue do not necessarily have the same pattern.

### Customer Rating Analysis

Several restaurants have average customer ratings below 4.

The analysis identified restaurants receiving ratings as low as
**1--2**, indicating potential customer-experience issues.

### Revenue + Rating Segmentation

Restaurants were segmented into:

-   **Customer Experience Risk** → High revenue + low rating
-   **Needs Improvement** → Low revenue + low rating

Example outputs include restaurants such as:

-   Zaika Tadka 3 --- ₹8,748 revenue, 3.00 rating
-   Kitchen Kitchen 8 --- ₹10,568 revenue, 1.00 rating
-   Food Palace 218 --- ₹14,011 revenue, 4.00 rating in the provided
    segmentation output
-   Cafe Diner 229 --- ₹15,123 revenue, 3.00 rating

### Business Recommendations

For high-revenue restaurants with low ratings:

-   Investigate customer reviews.
-   Identify food-quality and order-accuracy issues.
-   Review delivery performance.
-   Improve complaint resolution.
-   Monitor ratings after corrective actions.

For low-revenue and low-rated restaurants:

-   Review overall operations.
-   Improve menu quality and service consistency.
-   Use customer feedback to identify root causes.

------------------------------------------------------------------------

# 🧠 Phase 6 --- Advanced Business Analysis

This phase converts the transactional analysis into decision-oriented
business segmentation.

## 1. Customer Lifetime Value

For this project:

> **Customer Lifetime Value = Total spend by the customer**

The top 10 customers generated between **₹6,254 and ₹8,136** in total
revenue.

Top customers in the provided output:

  Customer         Lifetime Spend
  -------------- ----------------
  Rohan Arora              ₹8,136
  Sneha Kaur               ₹7,573
  Harsh Joshi              ₹7,252
  Palak Jain               ₹7,098
  Ananya Arora             ₹7,038

Rohan Arora has the highest lifetime spend in the output.

### Recommendation

Create a high-value/VIP retention strategy using:

-   Loyalty benefits
-   Personalized offers
-   Combo recommendations
-   Cross-selling
-   Retention monitoring

------------------------------------------------------------------------

# 📊 RFM-Oriented Customer Segmentation

The project uses an **RFM-oriented approach**, with the current SQL
implementation focusing primarily on:

-   **Frequency** → number of orders
-   **Monetary** → total customer spending

> **Note:** A traditional RFM model also includes **Recency**. The
> current implementation does not calculate a Recency score, so this
> project should be described as **Frequency + Monetary customer
> segmentation / RFM-oriented segmentation**, rather than a full
> three-component RFM score.

### Customer Segments

  -----------------------------------------------------------------------
  Segment           Frequency         Spending          Business Meaning
  ----------------- ----------------- ----------------- -----------------
  **VIP**           High              High              Highly engaged
                                                        and valuable

  **Frequent Low    High              Low               Orders frequently
  Value**                                               but spends less

  **Occasional High Low               High              High spending but
  Value**                                               lower frequency

  **Low             Low               Low               Limited activity
  Engagement**                                          and value

  **Average**       Around benchmark  Around benchmark  Middle segment
  -----------------------------------------------------------------------

The segmentation is implemented using SQL `CASE WHEN` logic by comparing
customer order frequency and total revenue against their respective
averages.

### Segment-Based Strategy

**VIP** - Focus on retention. - Offer loyalty benefits. - Maintain
engagement without unnecessary discounting.

**Frequent Low Value** - Use upselling. - Promote bundles and add-ons. -
Increase average order value.

**Occasional High Value** - Use repeat-order incentives. - Personalized
recommendations. - Encourage more frequent purchases.

**Low Engagement** - Run reactivation campaigns. - Offer targeted
incentives. - Analyze reasons for low activity.

------------------------------------------------------------------------

# 🍴 Restaurant Segmentation

Restaurants were also analyzed using revenue and customer-rating
benchmarks.

### Segments

**Customer Experience Risk** - Revenue above the benchmark - Customer
rating below the benchmark

**Needs Improvement** - Revenue below the benchmark - Customer rating
below the benchmark

This allows management to distinguish between restaurants where the key
issue is **protecting existing revenue while improving customer
experience** and restaurants requiring broader operational improvement.

------------------------------------------------------------------------

# 🛠️ SQL Concepts & Skills Demonstrated

This project demonstrates practical SQL skills including:

### Basic SQL

-   `SELECT`
-   `WHERE`
-   `ORDER BY`
-   `GROUP BY`
-   `HAVING`

### Aggregate Functions

-   `COUNT()`
-   `SUM()`
-   `AVG()`

### Joins

-   `INNER JOIN`
-   `LEFT JOIN`
-   `CROSS JOIN`

### Advanced SQL

-   Common Table Expressions (`CTE`)
-   Window functions
-   `ROW_NUMBER()`
-   `RANK()`
-   `DENSE_RANK()`
-   `PARTITION BY`
-   `CASE WHEN`
-   Subqueries

### Data Validation

-   Duplicate detection
-   Missing-record detection
-   Referential consistency checks
-   Transaction completeness checks

------------------------------------------------------------------------


# 📸 Key Project Outputs

### Customer Segmentation

![Customer
Segmentation](Screenshots/case_customer_segmentation_output1.png)

### Customer Lifetime Value

![Customer Lifetime
Value](Screenshots/customer_lifetime_value_output1.png)

### Restaurant Segmentation

![Restaurant
Segmentation](Screenshots/case_restaurant_segmentation_output1.png)

### Monthly Revenue

![Monthly Revenue](Screenshots/monthly_revenue_output1.png)

------------------------------------------------------------------------

# 📌 Key Business Insights

### Customer Insights

-   A small group of customers contributes substantially to total
    customer revenue.
-   Frequent customers are concentrated particularly across Noida and
    Ghaziabad in the provided output.
-   High-frequency customers do not always have high monetary value.
-   High-AOV customers represent an opportunity for premium and
    personalized offers.

### Restaurant Insights

-   Revenue is concentrated among a set of top-performing restaurants.
-   Some restaurants have high order demand but comparatively low
    revenue, indicating an AOV opportunity.
-   Some high-revenue restaurants have low customer ratings, creating a
    customer-experience risk.

### Order & Revenue Insights

-   Overall AOV is **₹694.74**.
-   July 2026 was the highest-revenue month in the provided analysis.
-   Wednesday was the highest-order day.
-   9 PM was the highest-volume ordering hour.

### Payment Insights

-   Payment-method usage is relatively balanced.
-   COD had the highest transaction count and highest revenue in the
    provided outputs.

### Data Quality Insights

-   The database contains complete payment records for the 4,000 orders.
-   Rating coverage is much lower, with 1,000 ratings against 4,000
    orders.
-   Only 25% of orders contain payment, delivery-partner and rating
    records together.

------------------------------------------------------------------------

# 💡 Overall Business Recommendations

Based on the combined analysis:

1.  **Improve customer retention**
    -   Build loyalty programs around high-value and VIP customers.
2.  **Increase customer AOV**
    -   Use combos, bundles, add-ons and cross-selling for frequent
        low-value customers.
3.  **Reactivate low-engagement customers**
    -   Use targeted offers and personalized campaigns.
4.  **Protect high-revenue restaurants**
    -   Investigate low ratings and improve food quality, delivery and
        service consistency.
5.  **Improve low-performing restaurants**
    -   Review menu strategy, customer feedback, operations and pricing.
6.  **Optimize peak-hour operations**
    -   Allocate sufficient delivery capacity and inventory around
        high-demand periods.
7.  **Use data-quality controls**
    -   Improve synchronization between orders, payments, delivery and
        ratings.
8.  **Monitor KPIs continuously**
    -   Revenue
    -   Total orders
    -   AOV
    -   Customer frequency
    -   Customer lifetime value
    -   Restaurant ratings
    -   Payment distribution

------------------------------------------------------------------------

# 📈 Potential Future Enhancements

The current project can be extended by adding:

-   Full **RFM scoring**, including Recency
-   Customer RFM score such as `R`, `F`, `M`
-   Cohort analysis
-   Customer retention/churn analysis
-   Restaurant profitability analysis
-   Delivery-partner performance analysis
-   City-level revenue dashboard
-   Power BI dashboard
-   Automated KPI reporting
-   Predictive customer churn modeling
-   Customer lifetime-value prediction
-   Recommendation system for menu items

------------------------------------------------------------------------

# 🎓 Learning Outcomes

Through this project, I strengthened my practical understanding of:

-   Relational database design
-   SQL querying
-   Data validation
-   Data aggregation
-   Joins and subqueries
-   CTEs
-   Window functions
-   Customer segmentation
-   Business KPI analysis
-   Revenue analysis
-   Translating SQL outputs into business insights
-   Converting data findings into actionable recommendations

------------------------------------------------------------------------

# 🧰 Tools & Technologies

  Tool                  Usage
  --------------------- ---------------------------------------
  **MySQL**             Database querying and analysis
  **MySQL Workbench**   SQL development and ER diagram
  **SQL**               Data analysis and business logic
  **GitHub**            Project version control and portfolio
  **Markdown**          Project documentation


------------------------------------------------------------------------



# 👨‍💻 Author

**Aditya Sachdeva**

B.Tech --- Electronics & Communication Engineering

### Areas of Interest

-   Data Analytics
-   SQL
-   Python
-   Power BI
-   Data Science
-   Machine Learning
-   Artificial Intelligence

------------------------------------------------------------------------

## ⭐ If you found this project useful

Feel free to explore the SQL queries, analysis phases and business
insights in the repository.

**This project demonstrates how SQL can be used not only to retrieve
data, but to convert transactional data into business decisions.**
