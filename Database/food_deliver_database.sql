create database food_delivery;
use food_delivery;

create table customers(customer_id int Auto_increment primary key
,customer_name varchar(20),cust_phn varchar(15),
cust_city varchar(20),cust_email varchar(30),
cust_address varchar(50),cust_signupdate date);


create table restaurants(restaurant_id int auto_increment primary key
,restaurant_name varchar(30),rest_location varchar(20),rest_city varchar(15)
,rest_contact varchar(15),rest_rating decimal(2,1), rest_openingtime time
,rest_closingtime time);


create table delivery_partners(partner_id int primary key,partner_name varchar(20)
,contact_no varchar(15),vehicle_type varchar(10),joining_date date,
is_active varchar(10));

alter table delivery_partners add primary key(partner_id);

create table menuitems(item_id int primary key,reataurant_id int
,item_name varchar(50),category varchar(10),
price decimal(10,2),availability varchar(10)); 


create table orders(order_id int primary key,customer_id int 
,restaurant_id int,partner_id int ,order_date date,order_time time 
,total_amt decimal(10,2),order_status varchar(15));

create table orderitems(orderitem_id int primary key ,order_id int 
,item_id int ,quantity int ,orderitem_price int ,
subtotal decimal(10,2));

create table payments(payment_id int primary key,order_id int,
payment_method varchar(15),payment_status varchar(10)
,payment_date date);

create table ratings(rating_id int primary key,
order_id int ,customer_id int,
restaurant_id int ,rating int ,review varchar(20));

alter table restaurants drop column rest_rating;

show tables;
desc customers;
desc restaurants;
desc orderitems;
desc menuitems;
desc orders;
desc delivery_partners;
desc ratings;
desc payments;



alter table menuitems
add constraint fk_menu_restaurant
foreign key(restaurant_id)
references restaurants(restaurant_id);


alter table ratings
add constraint fk_ratings_restaurant
foreign key(restaurant_id)
references
restaurants(restaurant_id);




show create table ratings;
show create table orderitems;















