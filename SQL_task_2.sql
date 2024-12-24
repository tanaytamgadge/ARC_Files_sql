-- 1 - JOINS
-- Task 2 - 1
 select customer_name,city, order_date from customers c
 join orders o on c.customer_id = o.customer_id where extract (year from o.order_date) = 2023;

-- Task 2 - 2
 select product_name,category,total_price from customers c
 join orders o on c.customer_id = o.customer_id
 join order_items oi on o.order_id = oi.order_id
 join products p on oi.product_id = p.product_id where c.city = 'Mumbai'

-- Task 2 - 3
 select customer_name, order_date,total_price from customers c
 join orders o on c.customer_id = o.customer_id
 join order_items oi on o.order_id = oi.order_id
 where o.payment_mode = 'Credit Card'

-- Task 2 - 4
 select product_name,category,total_price from orders o
 join order_items oi on o.order_id = oi.order_id
 join products p on oi.product_id = p.product_id
 where o.order_date between '2023-01-01' and '2023-06-30';

-- Task 2 - 5
 select customer_name,sum(oi.quantity) total_pro_ordered from customers c
 join orders o on c.customer_id = o.customer_id
 join order_items oi on o.order_id = oi.order_id group by customer_name;

-- 2 - DISTINCT 
-- Task 2 - 2.1
 select distinct city from customers;

-- Task 2 - 2.2
 select distinct supplier_name from products;

-- Task 2 - 2.3
 select distinct payment_mode from orders;

-- Task 2 - 2.4
 select distinct category from products; 

-- Task 2 - 2.5
 select distinct supplier_city from products;

-- 3 - ORDER BY
-- Task 2 - 3.1
 select * from customers order by customer_name;

-- Task 2 - 3.2
 select * from order_items order by total_price desc;

-- Task 2 - 3.3
 select * from products order by price,category desc; 

-- Task 2 - 3.4
 select order_id, customer_id, order_date from orders order by order_date desc;

-- Task 2 - 3.5
 select city, count (order_id) from customers c
 join orders o on c.customer_id = o.customer_id group by city order by city asc;

-- 4 - LIMIT AND OFFSET
-- Task 2 - 4.1
 select * from customers order by customer_name limit 10;

-- Task 2 - 4.2
 select * from products order by price desc limit 5;

-- Task 2 - 4.3
 select * from customers order by customer_id limit 10 offset 10;

-- Task 2 - 4.4
 select order_id, order_date, customer_id from orders where extract (year from  order_date) = 2023 order by order_date limit 5;

-- Task 2 - 4.5
 select distinct delivery_city from  orders limit 10 offset 10;

-- 5 - AGGREGATE FUNCTIONS
-- Task 2 - 5.1
 select count(order_id) from orders;

-- Task 2 - 5.2
 select sum(order_amount) from  orders where payment_mode = 'UPI'

-- Task 2 - 5.3 
 select avg(price) from products;

-- Task 2 - 5.4 
 select min(total_price), max(total_price) from order_items oi
 join orders o on oi.order_id = o.order_id where extract (year from order_date) = 2023;

-- Task 2 - 5.5
 select product_id, sum(quantity) from order_items group by product_id;

-- 6 - SET OPERATIONS
-- Task 2 - 6.1
 select customer_name from customers where customer_id in (select customer_id from orders where extract (year from order_date) = 2022
 intersect 
 select customer_id from orders where extract (year from order_date) = 2023);

-- Task 2 - 6.2
 select product_name from products where product_id in (select product_id from orders o join order_items oi on o.order_id = oi.order_id  where extract (year from order_date) = 2022
 Except
 select product_id from orders o join order_items oi on o.order_id = oi.order_id  where extract (year from order_date) = 2023);

-- Task 2 - 6.3 
 select supplier_city from products
 except
 select city from customers;

-- Task 2 - 6.4 
 select supplier_city from products
 union
 select city from customers;

-- Task 2 - 6.5
 select product_name from products where product_id in (select product_id from products
 intersect
 select product_id from order_items oi join orders o on o.order_id = oi.order_id where extract(year from order_date) =2023);

-- 7 - SUBQUERIES
-- Task 2 - 7.1
 select customer_name from customers where customer_id in (
 select o.customer_id from orders o join order_items oi on o.order_id = o.order_id 
 group by customer_id having sum(total_price) > (select avg (total_price) from order_items))

-- Task 2 - 7.2 
 select product_name from products where product_id in (
	select product_id from order_items group by product_id having count(*) > 1
 )

-- Task 2 - 7.3
 select product_name from products where product_id in (
	select product_id from order_items oi join orders o on oi.order_id = o.order_id
	join customers c on o.customer_id = c.customer_id where c.city = 'Pune'
 )

-- Task 2 - 7.4
 select order_id,delivery_city,payment_mode from orders where order_id in (
 select order_id from order_items group by order_id order by sum(total_price) desc limit 
 )

-- Task 2 - 7.5
 select customer_name from customers where customer_id in (
 select customer_id from orders o join order_items oi on o.order_id = oi.order_id
 join products p on oi.product_id = p.product_id where p.price > 3000
 )

