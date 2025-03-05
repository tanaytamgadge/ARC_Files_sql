-- Table Employees --
create table employees(employeeid serial primary key, firstname varchar, lastname varchar, department varchar, city varchar ,managerid int, salary int);

copy employees(employeeid, firstname, lastname, department, city, managerid, salary)
	from 'C:/Users/Ankush/Desktop/ARC Technologies Nagpur/SQL/task3/employees.csv'
	delimiter ',' csv header;

-- Table Customers --
create table customers(customerid serial primary key, customername varchar, contactnumber varchar);

copy customers(customerid, customername, contactnumber)
	from 'C:/Users/Ankush/Desktop/ARC Technologies Nagpur/SQL/task3/customers.csv'
	delimiter ',' csv header;

-- Table Products --
create table products(productid serial primary key, productname varchar, category varchar);

copy products(productid, productname, category)
	from 'C:/Users/Ankush/Desktop/ARC Technologies Nagpur/SQL/task3/products.csv'
	delimiter ',' csv header;

-- Table Sales --
create table sales(saleid serial primary key, productid int references products(productid), quantitysold int, saledate timestamp);

copy sales(saleid, productid, quantitysold, saledate)
	from 'C:/Users/Ankush/Desktop/ARC Technologies Nagpur/SQL/task3/sales.csv'
	delimiter ',' csv header;

-- table Orders --
create table orders(orderid serial primary key, customerid int references customers(customerid), orderdate timestamp, totalamount numeric(18,7));

copy orders(orderid, customerid, orderdate, totalamount)
	from 'C:/Users/Ankush/Desktop/ARC Technologies Nagpur/SQL/task3/orders.csv'
	delimiter ',' csv header;

-- Table Events --
create table events(eventid serial primary key, eventname varchar, eventdate timestamp);

copy events(eventid, eventname, eventdate)
	from 'C:/Users/Ankush/Desktop/ARC Technologies Nagpur/SQL/task3/events.csv'
	delimiter ',' csv header;

-- Table Participants --
create table participants(participantid serial primary key, participantname varchar, score int);

copy participants(participantid, participantname, score)
	from 'C:/Users/Ankush/Desktop/ARC Technologies Nagpur/SQL/task3/participants.csv'
	delimiter ',' csv header;

-- ================================================================================================================================================================== --

-- Q1 --
select * from employees where department = 'IT' and salary > 50000;

-- Q2 --
select * from orders o join customers c on o.customerid = c.customerid;
select c.customerid, c.customername, c.contactnumber, o.orderid, o.orderdate, o.totalamount from orders o join customers c on o.customerid = c.customerid;

-- Q3 --
select productid, sum(quantitysold) from sales group by productid order by productid;
select s.productid, p.productname, sum(quantitysold) from sales s join products p on p.productid = s.productid group by s.productid, p.productname order by s.productid;

-- Q4 --
select to_char(saledate, 'Month YYYY') as month_and_year, round(avg(quantitysold), 2) as avg_quantity_sold from sales group by month_and_year;

-- Q5 --
select productid, upper(productname) as productname, category from products;

-- Q6 --
select * from events where eventdate between current_date and current_date + interval '30 days';

-- Q7 --
select * from employees where salary > (select avg(salary) from employees);

-- Q8 --
create table product_log(logid serial primary key, old_data json, new_data json, date timestamp default current_timestamp);

create or replace function product_modify()
returns trigger as
$$
	begin
		insert into product_log(old_data, new_data) values (to_jsonb(old), to_jsonb(new));
		return new;
	end;
$$ language plpgsql;

create or replace trigger product_trigger
after update on products
for each row
execute procedure product_modify();

update products set category = 'Electronics' where productid = 1;

-- Q9 --
create or replace view activecustomers as
select c.customerid, customername, contactnumber, orderid, orderdate, totalamount from customers c join orders o on c.customerid = o.customerid 
where orderdate between '01-01-2024' and '31-12-2024';

select * from activecustomers;

-- Q10 --
select count(*) from sales where totalamount is null;

-- Q11 --
select dense_rank() over(order by score desc), * from participants;

-- Q12 --
select employeeid, department, sum(salary) over(partition by department order by employeeid) as cummulative_salary from employees;

-- Q13 --
select productid, quantitysold, saledate, sum(quantitysold) over (partition by productid order by saledate) as running_total_quantity
	from sales order by productid, saledate;

-- Q14 --
update table products set price = price * 1.10 where category = 'Electronics';

-- Q15 --
delete from customers where city = 'Delhi';
