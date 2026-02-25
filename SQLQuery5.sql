USE STARTERSQL ;
SELECT * FROM ORDERS;
SELECT * FROM EMPLOYEES;
SELECT * FROM USERS;

# THIS SCRIPTS DEMONSTAATES VARAIOUS SUBQUERY TECHNIQUES IN SQL IT COVVERS RESULT TYPES , 
SUBQUERIES IN THE  FORM CLAUSE , IN SELECT , IN THE  IN JOIN CLAUSES WITH COMPARISON, IN , ANY , CORRELATED SUBQUERIES AND EXISTS

1. SUBQUERY RESULT TYPES
2. SUBQUERY  FROM CLAUSE
3. SUBQUERY SELECT 
4. SUBQUERY JOIN 
5. SUBQUEY COMPARISON OPERATOR
6. SUBQUERY IN OPERATOR
7. SUBQUERY ANY OPERATOR 
8. SUBQUERY CORRELATED 
9. SUBQUERY EXISTS OPERATOR 

SUBQUERY  RESULT TYPES 
--- SCALER QUERY
SELECT AVG(SALES )
FROM ORDERS;

--- ROW  QUERY
SELECT 
       CUSTOMERID 
FROM ORDERS;

--- TABLE QUERY
SELECT  ORDERID,
        ORDERDATE
FROM ORDERS;

--- SUBQUERY FROM CLAUSE
find the  product that have a price higher than the  average  price of all product .
select *
from (select 
      productid,
      sales ,
      avg(sales) over () as avg_sales 
from orders ) t 
where sales> avg_sales;

---- rank customers based on their total amount of sales
select * ,
rank() over( order by totalsales desc ) as customerrank
from (select 
       customerid,
       sum(sales) as totalsales
from orders 
group by customerid)  t 

-- subquery select 
show the produt ids , product names , prices and total number of orders 

select * from products;

select productid,
       product,
       price,
       (select count(*) from orders ) as totalorders 
from  products;

subquery join clause 

task 4 
show customers details aloing with their total sales 

main query 
select 
      c.*,
      t.totalsales
from customers as c
left join ( select 
                  customerid,
                  sum(sales) as totalsales 
                  from orders 
                  group by customerid ) t 
on c.customerid= t.customerid;

--- show all the  customer details and the total orders of each customer

select
      c.*,
      o.totalorders 
from customers as c
left join ( select 
            customerid,
            count(*) as totalorders
            from orders 
            group by customerid) o
on c.customerid = o.customerid

---- subquery comparison operator

find the products that have a price higher than the average  price of all product 

select 
      productid,
      price ,
      ( select avg(price) from products) as avgprice 
from products
where price  > ( select avg(price) from products);

---- subquery  in operator 
-- show details of orders made by customers in germany.
select 
      * 
from orders
where customerid in ( select 
             customerid
             from customers
             where country='germany');


subquery any operator 

-- find the female employees whose  salaries are  greater than the salaries of  any male  employees
select 
      employeeid,
      firstname,
      salary
from employees
where gender='f'
and salary> any( select salary
                from employees 
                where gender='m');

--- show all customer detials and the total orders for each customer using a correlated 
--- subquery
select *,
       ( select count(*)
       from orders o
       where o.customerid= c.customerid) as totalsales
from customers c

subquery | exists operator

show  all details of  orders made by customers in germany

select * 
from orders as o
where exists (  select 1 
                from customers as c
                where country= 'germany'
                and  o.customerid= c.customerid );
select * from customers

----- table of content
1. non- recursive  cte
2. recursive cte-- generate sequence
3. recursive cte-- bild hierarchy

non- recursive cte
--step 1 find the  total sales per customer (  standalone cte)
with cte_total_sales as (
                         select 
                         customerid,
                         sum(sales) as totalsales 
                         from orders 
                         group by customerid )

, cte_last_order as 
( select 
        customerid,
        max(orderdate) as last_order 
        from orders
        group by customerid)

--step3 : 
 --rank customers based on total sales per customer ( cte) 
, cte_customer_rank as 
( select 
          customerid,
          totalsales,
          rank() over ( order by totalsales desc ) as customerrank 
          from cte_total_sales )

--- segment customers based on their total sales  ( nested cte) 
, cte_customer_segment as 
( select 
        customerid,
        totalsales,
        case 
             when totalsales > 100 then 'high'
             when totalsales > 80 then 'medium'
             else 'low'
        end as customersegments
        from cte_total_sales )


----- main query 
select 
      c.customerid,
      c.firtname,
      c.lastname,
      ctc.totalsales,
      clo.last_order,
      ccr.customerrank,
      ccs.customersegments
from customers as c 
left join cte_total_sales cts
on cts.customerid =  c.customerid


-- recursive  cte generate sequence

task 2 
genrate a sequence of numbers from 1 to 20

with series as ( 
-- anchor query
select 1 as mynumber 
union all
select mynumber +1
from series
where mynumber < 20 )

--- main query
select * from series 

------generate a sequence of numbers from 1 to 20

with series as  (
select  1 as mynumber 
union all
select mynumber + 1
from series 
where mynumber < 1000 )

select * from series 
option ( maxrecursion 5000)



select 
         employeeid,
          firstname,
           managerid,
          1 as level 
from employees
where managerid is null 
union all 
select 
      e.employeeid,
      e.firstname,
      e.managerid,
      level + 1 
from employees as e
inner join 



---- sql views 
this  script demonstrate various view use cases in sql sever it 
include examples for creating , dropping andd modifying views hiding query cmplexity and
and implementing data security by controlling data acess
-- create drop and modify
-- use  case hide complexity
-- use  case data security

-- create drop modify view
-- create a view that  summarizes monthly sales by aggregating:
--- order month ( truncate to month)
--- total sales , total orders , and total quantity

use startersql;
create view v_monthly_summary as 
( select  
        datetrunc(month , orderdate ) as ordermonth , 
        sum(sales) as totalsales ,
        count ( orderid ) as totalorders,
        sum(quantity) as totalquatities 
        from orders 
        group by datetrunc( month , orderdate) 
);
go

---query the view 
select * from v_monthly_summary;

---drop view if  it  exists
if object_id('v_monthly_summary' , 'v' ) is  not null
     drop view v_monthly_summary;
go 

---- recreate the logic with modified logic 
create view v_monthly_summary as 
select 
      datetrunc ( month , orderdate ) as ordermonth,
      sum(sales) as totalsales,
      count(orderid) as totalorders
from orders 
group by datetrunc ( month , orderdate );
go

select * from v_monthly_summary


---view use  case | hide complexity
-- create a view that combines details from orders , product , customers
-- and employee
--- this view abstract the complexity of  multiple table join 

create view v_order_details_eu as 
( select 
          o.orderid,
          o.orderdate,
          p.product ,
          p.category ,
          coalesce ( c.firstname , ' ' ) + ' ' + coalesce ( c.lastname , ' ' ) as 
          customername , 
          c.country as customercountry ,
          coalesce ( e.firstname , '' ) + ' ' + coalesce ( e.lastname , ' ') as salesname,
          e.department , 
          o.sales,
          o.quantity
          from orders as o
          left join products as p on p.productid= o.productid
          left join customers as c on c.customerid= o.customerid
          left join employees as e on employeeid= o.salespersonid
          );
          go


select * from v_order_details;

--- view  use case data  security

-- create a view  for  the eu sales that  combines details from all
---tables but excludes data related to the usa

create view v_order_details_eu   as----- error in this code tell(doubt) 
( select 
         o.orderid,
         o.orderdate,
         p.product,
         p.category,
         coalesce ( c.firstname, ' ' + ' ' + coalesce ( c.lastname, ' ') as customername,
         c.country as customercountry,
         coalesce ( e.firstname,' ') +' ' + coalesce( e.lastname , ' ') as salesname,
         e.department,
         o.sales,
         o.quantity
         
         from orders o
         left join product p on p.productid= o.productid
         left join customers c on c.customerid = o.customerid
         left  join employees  e on e.employeeid= o.salespersonid
         where c.country != 'usa'
 );
 go

 --create temporary tables 
 select * 
 into #orders 
 from orders;

 step 2 clean data in temporary table

 delete from #orders
 where orderstatus = 'delivered';

 select * from #orders


 --- load  clean into the permanent table 

 select * 
 into orderstest
 from #orders;

-- sql stored procedures 
-- this scrip shows how tot work with stored proceddures in sql server , 
-- sophisticated techniques.
  
--table of content

-- basic stored procedure
--- define stored procedure

create procedure getcustomersummary as 
begin
select
            count(*) as totalcustomers,
            avg(score) as avgscore
            from customers
            where country = 'usa'
end 
go 
--execute stored procedure
exec getcustomersummary;

parameters in store procedures

alter procedure getcustomersummary @country nvarchar(50) = 'usa' as 
begin 
select 
      COUNT(*) as totalcustomers ,
      AVG(score) as avgscore
      from Customers
      where Country = @country
end 
go 

execute stored procedures
exec getcustomersummary @country='germany';
exec getcustomersummary;
exec getcustomersummary @country='usa'


--- multiple queries in stored procedures
alter procedure getcustomersummary @country nvarchar(50) ='usa' as 
begin 
select 
      COUNT(*) as totalcustomers,
      AVG(score) as avgscore
      from Customers
      where Country= @country
-- find the total nr of orders and total sales 
select 
       COUNT(orderid) as totalorders,
       SUM(sales) as totalsales
       from Orders as o
       inner join Customers as c
       on c.CustomerID= o.CustomerID
       where c.Country = @country;
end 
go 

exec getcustomersummary;

alter procedure getcustomersummary @country nvarchar(50) = 'usa' as
begin 
---declare variable
   declare @totalcustomers int , @avgscore float;
-- find the total nr. of customers and the average score  
    select 
           @totalcustomers = COUNT(*),
           @avgscore = AVG(score)
           from  customers 
           where Country= @country;
    print( 'total customers from ' + @country + ':' + cast(@totalcustomers as nvarchar ));
     PRINT('Average Score from ' + @Country + ':' + CAST(@AvgScore AS NVARCHAR));

end 
go

exec getcustomersummary;

alter procedure getcustomersummary @country nvarchar(50) = 'usa' as
begin 
---declare variable
  declare @totalcustomers int , @avgscore float;
-- find the total nr. of customers and the average score  
    select 
           @totalcustomers = COUNT(*),
           @avgscore = AVG(score)
           from  customers 
           where Country= @country;
    --print( 'total customers from ' + @country + ':' + cast(@totalcustomers as nvarchar ));
---PRINT('Average Score from ' + @Country + ':' + CAST(@AvgScore AS NVARCHAR));

end 
go



















