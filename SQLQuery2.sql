use startersql ;
select * from orders;

----- sql window functions  enable advance calculations across sets of  rows
-----related to the current row  without  resorting  to complex  subqueires or joins.
---this script demonstarates the fundamentals and key claused  of windows  including the  over  , partitiion , order , and  clauses as well 
-- as  common rules and group by  use case.


---sql function basics 
-- task 1 :
select 
      sum(sales) as total_sales
from orders;


--- calculate the total sales for each  product
select 
      productid,
      sum(sales)  
from orders
group by productid;

SELECT 
    ProductID,
    sum(sales) as product_total,
    sum(SUM(Sales)) over() AS gran
    dtotal
FROM Orders
group by productid;


--- task 
--- find the total sales acoross  all orders,
--- additionally providing  details such  as orderid and orderdate

select
      orderid,
      orderdate
      sales,
      sum(sales) over() as total_sales
from orders;

--- sql window function 
----find  the total sales acoross all orders and for each product , 
--- addtionally providing details such as orderid and  orderdate

select 
      orderid,
      orderdate,
      productid,
      sales,
      sum(sales) over () as total_sales,
      sum(sales) over (partition by productid) as sales_by_product
from orders;


task5
--find the total sales  acorss all orders for  each product, and 
--for  each combination of product and order status,
--additionally providng details such as ordderid and orderdate

select 
     orderid,
     orderstatus,
     productid,
     sum(sales) over() as totalsales ,
     sum(sales) over(partition by productid ) as sales_by_product,
     sum(sales) over ( partition by productid , orderstatus ) as [sales by product status]
from orders;


--- task 
-- rank each order by sales  from highest to lowest 
select 
      orderid,
      orderdate,
      sales,
      rank() over ( order by sales desc ) as rank_sales 
from orders;

---- frame  clause

-- calcualte total sales order status for  current and  next two orders

select 
       orderid,
       orderdate,
       productid,
       orderstatus,
       sales,
       sum(sales) over (partition by orderstatus order by orderdate 
                        rows between current row and 2 following ) 

                        as total_sales
from orders;


---- window function can not  be  nested 

--sql window functions group by 
----rank customers by their total sales 

select 
      customerid,
      sum(sales) as totalsales,
      rank() over( order by sum(sales) desc ) as rank_customers 
from orders
group by customerid;

---- sql  window  aggregate funcitons
-- these function allow you to  perform aggregate calculations over a set of  rows  without the need for complex subqueries .
--- they enable  you to compute counts, sums, averages , averages , and  maximums while still retaining
--- access to indivisual row details 


---table of contents 
1. count
2. sum
3. avg
4.max, min
5. rolling sum & average use  case 

--- sql window aggregations

find the total number  of  orders and  total number of orders for each customers

select 
      orderid,
      orderdate,
      customerid,
      count(*) over() as total_orders,
      count(*) over( partition by customerid) as orderbycustomers
from orders

--- find  the total number of  customer
select * from orders
 
select *,
     count(*) over () as totalcustomerstar,
     count(1) over () as  totalcustomersone,
     count(score) over() as totalsales ,
     count(country) over() as totalcountries 
from customers

---check whether the table 'orderarchieve' contains  any duplicate rows
select *
from ( select *,
       count(*) over ( partition  by orderid ) as  checkduplicates
       from  orders ) t
where  checkduplicates >1


-- sql window aggregation | sum

-- find the total sales across all orders
-- find the total sales for each productnt 
--- find the percentage contribution of each product's sales  to the total sales 
select 
     productid,
     sum(sales) over() as totalsales ,
     round(cast(sales as float)/ sum(sales) over() * 100 , 2 ) as percentageoftotal
from orders



SELECT
    OrderID,
    ProductID,
    Sales,
    SUM(Sales) OVER () AS TotalSales,
    ROUND(CAST(Sales AS FLOAT) / SUM(Sales) OVER () * 100, 2) AS PercentageOfTotal
FROM Orders--------- doubt here  i want the  percentage by group by producct id 

----- sql window  aggregation |  avg

-- find the average sales across all orders 
--- find the average sales for  each product 

select 
      orderid,
      orderdate,
      sales,
      productid,
      avg(sales) over () as avgsales ,
      avg(sales  ) over ( partition by productid ) as avgsalesbyproduct 
from orders




----find the avg score of  customers

select 
      customerid,
      lastname,
      score,
      coalesce ( score ,0 ) as  customerscore ,
      avg(score) over() as avgscore ,
      avg(coalesce( score, 0)) over () as avgscorewithoutnull
from customers


select * from customers;
---- find all orders where  sales exceed the average sales across all orders

select
*
from(select 
       orderid,
       productid,
       sales,
       avg(sales) over() as  avgsales
       from orders)t
where sales> avgsales


---- min/max

--task 9
select 
      min(sales) as minsales ,
      max (sales ) as maxsales
from orders


---- show the employees who have the  highest salaries  

exec sp_help 
select * 
from ( select 
             max(salary) over() as highestsalary
             from employees ) t 
where salary = highestsalary

select * from employees;


---------- use of rolling sum and average 
 -- calculate the moving average of sales for each product over time 

 select 
      orderid,
      productid,
      orderdate,
      sales,
      avg(sales) over ( partition by productid ) as avgbyproduct,
      avg(sales) over ( partition by  productid order by orderdate ) as movingavg
from orders

--- sql window ranking 
-- these function allow you to rank and order rows within a result set without the need for
--for complex joins or subqueries . They enable you to assign unique or non-unique ranking ,
--group rows into buckets and anlyze data distribution on orders 

--1
--rank orders based on sales from highest  to lowest 

select 
         orderid,
         productid,
         sales,
         row_number () over(  order by sales  desc ) as salesrank_row,
         rank() over( order by sales desc ) as salesrank_rank,
         dense_rank() over( order by sales desc) as salesrank_dense
from orders 

use  top-n analysis find the  highest sales for  each product 

select *from (
select 
        orderid,
        productid,
        sales,
        row_number () over ( partition by productid order by sale desc )
        as rankbyproduct


--- divide orders into groups based on sales 

select 
      productid,
      orderid,
      sales ,
      ntile(1) over ( order by sales) as onebucket,
      ntile(2) over ( order by sales ) as twobucket ,
      ntile (3) over ( order by sales ) as threebucket,
      ntile (2) over ( partition by productid order by sales ) as twobucketbyproducts
from orders;----- need to check again

----- sql window ranking cume_dist
-- find the  products that fall within highest 40% of  the prices 
select * from products
select 
      product,
      price,
      distrank,

------ sql window  value functions
-- these functions let you reference and comparre value from other rows in a result 
--set without complex joins or subqueries , enabling advanced analysis on ordered data

1.lead()
2.lag()
3.first_value
4.last_value

lead and lag 





select 
        month(orderdate) as ordermonth ,
        sum(sales) as currentmonthsales,
        lag(sum(sales)) over ( order by month( orderdate)) as  previousmonthsales 
from orders
group by month(orderdate)  ----as monthlysales;


task2
-- customer loyalty analysis-- rank customers based on the  average  days between their orders
select 
     customerid ,
     avg(daysuntilnextorder) as avgdays,
     rank() over ( order by coalesce(avg,== alsjdljadsldkfjfalksjdflakjsddflkj  


select 
      orderid,
      customerid,
      orderdate as currentorder,
      lead(orderdate) over  (  partition by customerid order by orderdate ) as nextorder,
      datediff( day , orderdate , lead(orderdate) over ( partition by cusotmerid order by orderdate )
      as  daysuntilnextorder
from orders 

















