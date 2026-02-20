use startersql;

select * from employees;

select 
employeeid,
firstname 
from employees;

--- where  
select * from 
employees
where employeeid = '5';

select * from employees 
where employeeid= 5 
   or  employeeid=3;


-- order by 
select * from 
employees
where department ='sales'
order by employeeid desc;

select * from employees
-- group by 

-- find the total salary for each department 
select
       firstname,
       department,
       sum(salary) as totalsalary 
from employees 
group by department ;

select * from employees
-----having 
select 
      department ,
      avg(salary ) as avg_salary
group by salary  
having avg(salary)> 50000

select * from customers;

select 
        country,
        avg(score) as avg_score
from customers
group by country
having avg(score) > 430
       
select distinct country 
from customers 


select 
top 5* 
from customers 
order by score desc;


select top 
3 * from 
customers
order by score asc ;


all together 

select 
      country,
      avg(score) as avg_score 
from customers 
where score <> 0
group by country
having avg(score)> 430
order by avg(score ) desc;





--- create a table names persons with columns : id , person_name, birth_date, and phone 
create table persons ( 
id  int ,
person_name varchar(50),
birth_date varchar(50),
phone varchar(50) ,
constraint pk_person primary key (id));


alter table persons
add email varchar(50) unique not null ;

alter table persons

drop column phone ;


drop table persons;


-----data manipulation language
inset , update , delele 

insert into persons   
values (6 , 'anna', 'usa', null ),
       (7 , 'minal', null , 100 );

insert into customers ( id , firstname , country , score )
values ( 8 , 'max' , 'usa' , null )

---- insert dat using select  moving data fromm one table to another 
-- copying the data from customer table to persons
--- update
update customers
set score = 0
where id = 6


update customers
set score = 0,
    country ='uk'

where id = 10

update all customers with a null score by setting their score to 0

update customers
set score = 0
where score is null 
select * from customers
---- delete 
select * from 
customers
where customerid > 5 

--delete all customer with id greate than 4
delete from  customers
where customerid > 5;

--delete all data from the persons table 
delete from persons

--faster method to delete all rows , especially useful for large tables
truncate table persons

---sql filtering data 
1. comparison operator
- = ,<>, > ,>= ,< ,<=

2. logical operator 
and , or , not

3. range filtering 
between 
4.set filtering 
 IN

5. PATTERN MATCHING 
LIKE

COMPARISON OPERATOR 

SELECT * 
FROM CUSTOMERS 
WHERE COUNTRY='GERMANY'

SELECT *
FROM CUSTOMERS
WHERE COUNTRY <> 'GERAMANY'

--- RETRIEVE ALL THE CUSTOMERS WITH A SCORE GREATER THAN 500
SELECT *
FROM CUSTOMER
WHERE SCORE > 500


---- RETRIEVE ALLTHE CUSTOMERS WITH A SCORE OR MORE .
SELECT * 
FROM CUSTOMERS 
WHERE SCORE >= 500

-- LOGICAL OPERATORS
-- /* COMBINING CONDITION USING AND , OR , AND NOT */
SELECT * 
FROM CUSTOMERS
WHERE COUNTRY='USA' AND SCORE> 500

--- RETIEVE ALL CUSTOMER WHO ARE EITHER FROM THE USA OR HAVE A SCORE GREATER THAN 500
SELECT * 
FROM CUSTOMER WHERE 
COUNTRY ='USA' OR SCORE > 500

-- RETIEVE ALL CUSTOMERS WITH A SCORE NOT LESS THAN 500

SELECT * 
FROM CUSTOMERS 
WHERE SCORE BETWEEN 100 AND 500

SELECT * 
FROM CUSTOMERS 
WHERE SCORE >= 100 AND SCORE <= 500

---SET FILTERING - IN 

SELECT * 
FROM CUSTOMERS 
WHERE COUNTRY IN ('GERMANY','USA')

--- FIND ALL CUSTOMERS WHOSE FIRST NAME STARTS WITH 'M'
SELECT * 
FROM CUSTOMERS
WHERE FIRSTNAME LIKE 'M%'
--- FIND ALL CUSOTMERS WHOSE FIRST NAME STARTS WITH 'N'
SELECT *
FROM CUSTOMERS
WHERE FIRSTNAME LIKE '%N'

SELECT *
FROM CUSTOMERS
WHERE FIRST_NAME LIKE '__R%'

SELECT * FROM CUSTOMERS;
SELECT * FROM ORDERS;

---INNER JOIN 
-- GET ALL CUSTOMERS ALONG WITH THEIR ORDERS, BUT ONLY CUSTOMERS WHO HAVE  PLACED AN ORDER
SELECT 
      C.CUSTOMERID,
      C.FIRSTNAME,
      O.ORDERID,
      O.SALES
FROM CUSTOMERS AS C
INNER JOIN ORDERS AS O 
ON C.CUSTOMERID= O.CUSTOMERID

-----LEFT JOIN 
--- GET ALL CUSTOMERS ALONG WITH THEIR ORDERS, INCLUDING THOSE WITHOUT ORDERS
SELECT 
       C.CUSTOMERID,
       C.FIRSTNAME,
       O.ORDERID,
       O.SALES
FROM CUSTOMERS AS C
LEFT JOIN ORDERS AS O
ON C.CUSTOMERID= O.CUSTOMERID


---- RIGHT JOIN 


SELECT 
     C.CUSTOMERID,
     C.FIRSTNAME,
     O.ORDERID,
     O.SALES
FROM ORDERS AS O
LEFT JOIN CUSTOMERS AS C
ON C.CUSTOMERID= O.CUSTOMERID



---------------------------------------------------------------------------------

-----------------------------------------------------------------------------------


SELECT
    c.customerid,
    c.firstname,
    o.orderid,
    o.sales
FROM customers AS c 
RIGHT JOIN orders AS o 
ON c.customerid = o.customerid


-----------------------------------------------------------------------------------

select
      c.customerid,
      c.firstname,
      o.orderid,
      o.sales
from customers as c
full  join orders as o
on c.customerid = o.customerid
-----------------------------------------------------------------------
----advanced joins
left anti join 
select *
from customers as c 
left join orders as o
on c.customerid= o.customerid
where o.customerid is null

--- right anti join 
select * 
from orders as o
left join customers as c 
on c.customerid= o.customerid
where  c.customerid is null 

SELECT *
FROM customers AS c
RIGHT JOIN orders AS o
ON c.customerid = o.customerid
WHERE c.customerid IS NULL


-- full anti join -- find the customers without order andd orders without customer
select 
     c.customerid ,
     c.firstname ,
     o.orderid,
     o.sales
from customers as c
full join orders as o
on c.customerid= o.orderid
where o.customerid id null or c.cutomerid is null


---  cross join 
select * 
from customers
cross join orders


--- multiple about joins(tables)
---task: using salesdb retrieve a list of all orders , along with the realted 
-- orderid , customer name , product name , sales amount , product price sales


create database salesdb;
select 
       o.orderid,
       o.sales,
       c.firstname as customerfirstname,
       c.lastname as customerfirstname,
       p.product as productname,
       p.price ,
       e.firstname as employeefirstname,
       e.lastname as employeelastname
from sales.order as o
left join sales.customers as c
on o.customerid= c.customerid


-----sql set operations

--- sql set operations enable you to combine results from multiple queries into a single
---- into a single result set this script demonstrates the rules and usage of set operations, including 
--- including union , union all , except  and intersent 

-- table of content
1. sql operation rule

select 
      firstname,
      lastname,
      country
from sales.customers
union 
select firstname,
       lastname,
       from sales.employees;

-----
select customerid,
       lastname
from sales.customers
union
select firstname,
       lastname  
from sales.employees;


---find employees who are not customers using except

select 
       firstname,
       lastname
----------------------------------------------------------------------------------------
SELECT
    FirstName,
    LastName
FROM Sales.Employees
INTERSECT
SELECT
    FirstName,
    LastName
FROM Sales.Customers;
-------------------------------------------------------------------------------------
--sql  set operations

---sql operations enable you to combine results form multiple quaries into a single result set. this  script 
---sql operation rules , union , union all , except , intersect 

select 
       firstname,
       lastname,
       country
from sales.customers
union
select 
      firstname,
      lastname
from sales.employees;


use datawarehouse ;
select * from bronze.crm_cust_info;

select * from employees;

exec sp_help;

use startersql;
select* from employees;

select
      firstname,
      lastname
from customers
union
select 
     firstname,
     lastname
from employees
---data types
select 
      customerid,
      lastname
from customers
union
select 
      firstname,
      lastname
from employees;

------- the column names in the result set are  determined by the column names
select 
     customerid,
     lastname
from customers 
union
select 
     firstname,
     lastname
from employees

---rule:column order 
--- the order of the columns in each query must  be the same 
select 
       lastname,
       customerid
from customers
union
select
       employeeid,
       lastname
from  employees;

    
select 
      customerid as id,
      lastname as last_name
from customers
union
select 
       employeeid,
       lastname
from employees



select
      firstname,
      lastname
from customers
union
select
      lastname,
      firstname
from employee;

------ union, unionall , except ,intersect 
select 
      firstname,
      lastname
from customers
union
select 
      firstname,
      lastname
from employees;
-----------------------------------------------------------------------------------------
select
      firstname,
      lastname
from employees
except
select
      firstname,
      lastname
from customers;


select * from employees
select * from customers

----  task: 5 
--combine order data from orders and orderarchive into one report without duplicate

select 
      'orders' as sourcetable,
      orderid,
      productid,
      customerid,
      salespersonid,
      orderdate,
      shipdate,
      orderstatus,
      shipaddress,
      billaddress,
      quantity,
      sales,
      creationtime
select * from orders;
union
select 


--# this document provides an overview of sql string functions , which allows manipulatinon 
--transformation , and extraction of text data efficiently
use startersql;
select * from customers;
---- concatination of two columns
select 
       concat(firstname ,'-', country ) as full_info
from customers

--- lower and uppper case transformation
--- convert the first name to lower case 
select 
     lower(firstname) as lower_case_name
from customers;

select upper(country) as upper_country_name
from customers;

---- trim() -- remove white spaces
--- find customers whose first name contains leading or trailing spaces
select 
        len(firstname) len_name ,
        len(trim(firstname)) len_trim_name,
        len(firstname)- len(trim(firstname)) flag
from customers
where len(firstname) <> len(trim(firstname))

-----replace-- replace or remove  old  value with new one 
select 
'123-456-7890' as phone ,
replace ( '123-456-7890' , '-',' ' )

---- replace file extension form csv  to text 
select 
'report.csv' as old_filename , 
replace ( 'report.csv' , 'csv','txt') as new_filename

---- len () -- string length and trimming

-- calculate the length of each customers first name 
select 
      firstname,
      len(firstname) as name_length 
from customers

---- left () and right()

select 
       firstname,
       left(trim(firstname) , 2) as first_2_chars 
from customers;

---retrieve the last tow  characters for characters of each first name 
select 
      firstname ,
      right(firstname ,2 ) as last_2_chars
from customers;

---------------------------------------------------
---substring---extraction substring
--- retrieve the list of customers first names after removing the firt character 
select 
      firstname,
      substring(trim(firstname),2,len(firstname) ) as trimmed_names
from customers;----- why its trimming only the one letter of the string as it mentioned for two still


-----nested functions
select 
firstname,
upper(lower(firstname)) as nesting
from customers;

--- round()
select 3.516 as original_number,
round(3.516 , 2 ) as round_2,
round(3.516 , 1) as round_1,
round(3.516 , 0) as round_0;

--- absolute value
--demonstrate absolute value function
select 
     - 10 as original_value,
     abs(-10) as absolute_value_negative , 
     abs(10.001) as absolute_v

--- sql data andd time fuctions
-- this script demonstrates various date and time fuctions in sql.
--- it cover function such getdata , datetrunc , datename , datepart
-- year, month , day , eomonth , format ,  convert , cast , dateadd, datediff
-- and isdate

select 
      orderid,
      creationtime,
      '2025-08-20' as hardcoded,
      getdate() as today
from orders;

--- datepart extractions
--(datetrunc , datename , datepart , year , month , day )
select 
      orderid,
      creationtime,
      datetrunc(year , creationtime) as year_dt,
      datetrunc(month , creationtime) as month_dt,
      datetrunc(day , creationtime) as day_dt,
      datetrunc(minute, creationtime) as minute_dt
      --datetrunc(day , 
from orders;
use startersql;
select * from orders;
---- date name function 
select 
      orderid,
      creationtime ,
      datename( year , creationtime) as month_dn,
      datename( weekday , creationtime) as weekday_dn,
      datename( day, creationtime) as day_dn   ---# if want to check the data type after adding the new column as day_dn
from orders;

select
Select SQL_VARIANT_property (datename(day,creationtime),'Basetype') as returndatatype
from orders;


-------- datepart examples 
select 
     orderid,
     creationtime,
     --datepart( year , creationtime) as year_dp,
     --datepart( month , creationtime) as month_dp,
     datepart(day , creationtime) as day_dp
     --datepart( hour , creationtime) as hour_dp,
     --datepart( quarter , creationtime) as quater_dp,
     --year(creationtime) as year,
     --month(creationtime) as month,
     --day(creationtime) as day


from orders;

-----aggregate orders by year using datetrunc on creationtime.
select  
      datetrunc( year , creationtime) as year ,
      count(*) as ordercount
from orders
group by datetrunc( year , creationtime)

---eomonth()
--- display orderid , creationtime, and the endofmonth date for creationtime.

select 
      orderid,
      creationtime,
      datepart(day,eomonth (creationtime))--------- how to appy this logic here 
      --eomonth(dt) as endofmonth
from orders;

---- date parts use case 
--- how many orders placed each years

select 
       year(orderdate) as orderyear,
       count(*) as totalorders
from orders
group by year(orderdate)

--- how many orders were placed each month ( using friendly month names)
select 
      datename( month , orderdate) as month_name,
      count (*) as totalorders
from orders
where datename(month , orderdate) = 'February'
group by datename( month , orderdate);

-- show all orders that were placed during the month of february
select * from orders
where datename(month , orderdate) = 'February';

----- format()
----- format creationtime into various string representations
select* from orders;
alter table orders
alter column creationtime datetime2 ;

use startersql;
select 
      orderid,
      orderdate,
      format(orderdate, 'MM-dd-yyyy') as usa_format,
      format( orderdate , 'dd-MM-yyyy') as euro_format,
      format( orderdate, 'dd') as dd,
      format( orderdate , 'ddd') as ddd,
      format( orderdate , 'dddd') as dddd,
      format( orderdate , 'MMM') as mmm

from orders;

SELECT * FROM ORDERS
--- hwo many orders were placed each year formatted by month and year(eg.jan 25)
select 

       format( ORDERDATE , 'MMM yy') as NEW_FORMAT , 
       count(*) as totalorders
from orders 
group by 
       format(ORDERDATE,'MMM yy');



SELECT 
    FORMAT(orderdate, 'MMM yy') AS new_format,
    COUNT(*) AS totalorders
FROM orders
GROUP BY 
    FORMAT(orderdate, 'MMM yy');

---convert funtion 
--- demonstrate conversion using convert 

select 
      convert ( int , '123') as [string to int convert ],
      convert ( date , '2025-08-20') as [ usa std. style : 32],
      creationtime ,
      convert( date , creationtime) as [ datetime to date convert ],
      convert   ( varchar , creationtime , 101) as [ usa std. style : 32 ],
      convert ( varchar , creationtime , 103) as [ euro std. style: 34]
from orders;

-------cast()

---convert the date type using cast
select 
      cast( '123' as int) as [ string to int ],
      cast ( 123 as varchar ) as [ int to string ],
      cast ('2025-08-20' as date ) as [string to date],
      cast ( '2025-08-20' as datetime2 ) as [ string to datetime ],
      cast ( '2025-08-20' as datetime) as [ string to datetime ]

from orders ;

--- perform date arithmetic on orderdate

select 
      orderid,
      orderdate,
      dateadd( day , -10 , orderdate) as  tendaysbefore,
      dateadd( month , 3 , orderdate ) as threemonthslater
from orders;


--- calculate the age of employee
select * from orders;
select * from employees;
select 
      employeeid,
      birthdate,
      datediff( year , birthdate , getdate()) as  age 
from employees;
      
---find  the average shipping duration in days for each month
select 
      month(orderdate ) as ordermonth,
      avg(datediff(day , orderdate , shipdate)) as avgship
from orders
group by month(orderdate);


--- time gap analysis find the number of days between each order and the previous
--- order 
select 
      orderid,
      orderdate as currentorderdate


exec sp_help orders;
select 
day_dn , data_type

-------null functions
----- handle null- data aggregation
-- handle null -- mathematical operators
---handle null --- sorting data
----nullif--division by zero 
--- is null-- is not  null
--left anti join 
-- nulls vs empty string vs blank spaces 
---------------------------------------------------------------------
 --handle null-- aggregation data
 use startersql ;
 select * from customers;

 select 
       customerid,
       score,
       coalesce( score , 0 ) as score2,
       avg(score) over () as avgscores,
       avg(coalesce(score , 0 )) over () as avgscores2
from customers;

--- handle null- mathematical operators
 
 -- display the full name of the customers in a single field by merging 
 ---first and last names , and add 10 bonus points to each customers score 

 select * from customers;

select 
       firstname ,
       lastname,
       concat(firstname,' ',lastname ) as  fullname,
       score,
       score + 10 as updatedscore 
   
from customers;

----handle null - sorting data
-- sort the customers from lowest to highest scores , 
--- with null values appearing last .
select customerid,
       score
from customers 
order by score  asc ;

SELECT
    CustomerID,
    Score
FROM Customers
ORDER BY CASE WHEN Score IS NULL THEN 1 ELSE 0 END, score;

--- nullif - division by zero

--- find the sales price for each order by dividing sales by quantity
-- uses null if to avoid division by zero 

-- is null - is not null
select * from customers
where score is null;

select * from 
customers 
where score is not null;

select * from customers;
select 
      c.*,
      o.orderid
from customers as c
left join orders as o
on c.customerid= o.customerid
where o.customerid is null

 ----method to handle the null
use startersql 

create a report showing total sales for each category:
-- high: sales over 50
--- medium sales between 20 and 50 
--- low sales 20  or less
---the result are  sorted from the highest to lowest 

select * from orders;

select
      category,
      sum(sales) as totalsales
from (select 
     orderid,
     sales,
     case
     when sales > 50 then 'high'
     when sales > 20 then 'medium'
     else 'low'

     end as category
from orders ) as t
group by category
order by sum(sales) desc;


--- use mapping 

--- retrieve customer detials with abbreviated country codes 
select * from customers
select distinct country
from customers;

select 
      customerid,
      country ,
case 
      when country= 'germany' then 'gm'
      when country= 'usa' then' us'
      else 'na'
      end as countryabbr
from customers


----quick form syntax
select 
      customerid,
      country,
case country
     when 'germany' then 'de'
     when 'usa' then 'us'
     else 'na'
     end as countryabbr

from customers;
     
--- task 4 
-- calculate the average score of customers , treating null as 0 ,
--- and provide customerid and lastname details.
select 
      customerid,
      lastname,
      score,
case 
      when score is null then 0
      else score 
      end as scoreclean,
    avg( 
    case 
        when score is null then 0
        else score 
        end ) over() as avgcustomerclean,
        avg(score) over () as avgcustomer
from customers;


----- conditional aggreagationn 
--- count how many orders each customer made with sales greater than 30
use startersql;

select * from orders;

select 
       customerid,
       sum( case 
                 when sales > 30 then 1 
                 else 0 
                 end ),
                 count(*) as totalorders 
from orders
group by customerid;

------sql functions

select 
      count(*) as total_customers
from customers

select 
       sum(sales) as total_sales
from orders

select 
      avg(sales ) as avg_sales 
from orders;

---- find the highest score among customer

select max(score) as max_score 
from customers;

--- find the lowest score  among the customers
select 
      min(score) as min_score
from customers ;

-----group by aggregation 
select * from orders 

select 
      customerid ,
      sum(sales) as [total sales],
      avg(sales) as [avg sales],
      max(sales) as [ max sales],
      min(sales) as [min sales]
from orders
group by customerid;
      

--- sql window function 

---  window  basics 
select * from orders

select 
      sum(sales) as total_sales 
from orders;

---- sql over  function over  clause 

-- find the total sales acoross all orders,
-- additionally providing details such as orderid and orderdate 

select 
      orderid,
      orderdate,
      productid,
      sales,
      sum(sales ) over () as total_sales
from orders

--sql window functin partition clause

-- find the total sales across all order for each product, additionally 
-- providing details such as orderid and orderdate 

select 
      orderid , 
      orderdate,
      productid,
      sales,
      sum(sales) over() as total_sales ,
      sum(sales) over( partition by productid) as sales_by_product
from orders;


---- find the total sales across all orders , for each product
and for each combination of product
--- and order status , additionally providing details such as 
orderid and orderdate
     select * from orders  

select 
       orderid,
       orderdate,
       productid,
       orderstatus,
       sales,
       sum(sales) over() as total_sales ,
       sum(sales) over ( partition by productid ) as sales_by_product,
       sum(sales) over (partition by productid , orderstatus ) as sales_by_product_status
from orders;

--- window function order clause 
--- rank each order by sales  from highest to lowest 
select 
      orderid,
      orderdate,
      sales,
      rank() over ( order by sales desc) as  rank_sales 
from orders ;

--- sql window  fuction | frame clause 

--- calculate total sales by order status for current andd next two order 
select
      orderid,
      orderdate,
      productid,
      orderstatus ,
      sales,
      sum(sales ) over( partition by orderstatus order by orderdate 
                        rows between current row and 2 following )
as total_sales 
from orders;
        
-- calculate total sales by order status for  current and previous two orders

select 
      orderid,
      orderdate,
      productid,
      orderstatus,
      sales,
      sum(sales) over( partition by orderstatus  order by orderdate 
                       rows between 2 preceding and current row ) as total_sales 
from orders 

--- calculate total  sales by order status from previous two orders only 
select 
      orderid,
      orderdate,
      productid,
      orderstatus,
      sales,
      sum(sales) over( partition by orderstatus order by orderdate rows  
                        2 preceding ) as total_sales 
from orders ;


--- task 10
-- calculate  cumulative total sales by order  status up to the current 
-- order 

select 
      orderid,
      orderstatus ,
      orderdate,
      productid,
      sales ,
      sum(sales) over( partition by orderstatus order by orderdate 
                       rows between unbounded preceding and current row)
                       as [total sales]
from orders;

--- sql window  functins -- group by 
select 
      customerid,
      sum(sales) as total_sales ,
      rank() over ( order by sum(sales ) desc ) as rank_customers
from orders
group by customerid 































