use SQL_Projects 
select * from customer
select * from orders
select * from salesman1

-- Write a SQL statement to make a list for the salesmen who either work for one or more customers or yet to join any of the customer.
-- The customer, may have placed,either one or more orders on or above order amount 2000 and must have a grade,
-- or he may not have placed any order to the associated supplier.
-- conditions-
-- 1)create a stored procedures
-- 2)push stored procedure data in a new table
-- 3)Data gather by including current time stamp in a new column

alter procedure cust_orderdetails
@salesman_name varchar(30),
@cust_name varchar(30),
@ord_no int,
@purch_amt money,
@grade int
as 
begin
	select c.salesman_id,c.cust_name,c.city,c.grade, s.names as "Salesman", o.ord_no, o.ord_date, o.purch_amt 
	from customer c right join salesman1 s on c.salesman_id=s.salesman_id 
	left join orders o on o.cust_id=c.cust_id 
	where o.purch_amt>=2000 and c.grade is not null
end
exec cust_orderdetails @salesman_name ='James Hoog',
					   @cust_name ='Nick Rimando',
					   @ord_no =70001,
					   @purch_amt =150.5,
					   @grade =100

create table new_cust 
(salesman_id int,cust_name varchar(30),city varchar(30),grade int,salesman_name varchar(30),ord_no int,ord_date date,purch_amt money,)

insert into new_cust exec cust_orderdetails @salesman_name ='James Hoog',
											@cust_name ='Nick Rimando',
											@ord_no =70001,
											@purch_amt =150.5,
											@grade =100

alter table new_cust 

add current_date_time datetime not null default current_timestamp

select * from new_cust

insert into new_cust(salesman_name,cust_name,ord_no,purch_amt,grade) values('akshay','priya',70022,459.20,300)
delete from new_cust where ord_no=70022

ALTER TABLE new_cust alter column ord_no int NOT NULL
ALTER TABLE new_cust ADD PRIMARY KEY (ord_no)

alter procedure cust_orderdetails
	@Cust_name varchar(30),
	@grade int,
	@salesman_name varchar(20),
	@ord_no int ,
	@purch_amt money
as
begin
	if exists (select * from new_cust where ord_no=@ord_no)
		update new_cust set Cust_name=@Cust_name,grade=@grade,salesman_name=@salesman_name,purch_amt=@purch_amt 
		where ord_no=@ord_no
	else
		insert into new_cust(cust_name,grade,salesman_name,ord_no,purch_amt) values(@cust_name,@grade,@salesman_name,@ord_no,@purch_amt)
end

