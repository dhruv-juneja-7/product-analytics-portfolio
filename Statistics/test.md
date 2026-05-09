Based on THIS exact schema.

You will solve these like a real test.

📦 SCHEMA (recap in your head)
orders → multiple rows per order_id
returns → return flag
customers → customer info
products → product info
managers → region-level
🧪 PRACTICE SET (JOIN + GRAIN FOCUSED)
🔹 Q1 (WARM-UP — JOIN + FILTER)

👉 Get all returned orders with:

order_id
customer_id
order_date

```sql
select o.order_id, o.customer_id, o.order_date
from orders o
join returns r on o.order_id = r.order_id
where is_returned = 1
order by order_date desc, value desc;
```

🔹 Q2 (JOIN + AGGREGATION)

👉 Total revenue per customer

Output:

customer_id
total_revenue

```sql
select customer_id, sum(value) as total_revenue
from  orders
group by customer_id
order by total_revenue desc;
```

🔹 Q3 (GRAIN TRAP — VERY IMPORTANT)

👉 Top 5 orders by total value

⚠️ orders has multiple rows per order_id
Grain - one row per order_id

```sql
select order_id, sum(value) as total_value
from orders
group by order_id
order by total_value desc
limit 5;
```

🔹 Q4 (JOIN + FILTER + GROUP)

👉 Number of returned orders per customer

```sql
select o.customer_id, count(distinct o.order_id) as no_of_returns
from orders o
join returns r on o.order_id = r.order_id
where is_returned = 1
group by customer_id
order by no_of_returns;
```

🔹 Q5 (MULTI JOIN)

👉 Get:

customer_name
total orders
total revenue

```sql
select customerName, count(distinct order_id) as total_orders, sum(value) as total_value
from orders o
join customers c on o.customer_id = c.customer_id
group by customerName;
```

🔹 Q6 (PRODUCT ANALYSIS)

👉 Top 3 products by total sales (value)

```sql
select product_id, sum(value) as total_sales
from orders
group by product_id
order by total_sales desc
limit 3
```

🔹 Q7 (REAL ALOOBA STYLE — CRITICAL)

👉 Last 10 returned orders
Sort:

orderDate DESC
value DESC

Output:

order_id
customer_id
product_id

```sql
select o.order_id, o.customer_id, o.product_id
from orders o
join returns r
on o.order_id = r.order_id
where is_returned = 1
order by order_date desc, value desc
limit 10;
```

🔹 Q8 (ADVANCED FILTERING)

👉 Customers who have:

at least 3 orders
total spend > average customer spend

```sql
with cte as (
    select customer_id, count(distinct order_id) as total_orders, sum(value) as total_value
    from orders
    group by customer_id
)
select customer_id
from cte
where total_orders >= 3 and total_value > (select SUM(value) from orders) / (select count(distinct customer_id) from orders)
```

🔹 Q9 (REGION ANALYSIS)

👉 Total revenue per region

```sql
select c.region, sum(value) as total_revenue
from orders o
join customers c on o.customer_id = c.customer_id
group by c.region
order by total_revenue desc;
```

(Use customers → managers join)

🔹 Q10 (WINDOW FUNCTION)

👉 Rank customers by total spend

```sql
with cte as (
    select customer_id, sum(value) as total_spend
    from orders
    group by customer_id
)
select customer_id,
dense_rank() over(order by total_spend desc) as rn
from cte
order by rn;
```

## Assumptions

🔹 Q1

👉 Get customers who have placed orders

Output:

customer_id

given : customer_id should be returned only
not given: order to return
grain - distinct customers

```sql
select distinct customer_id from orders;
```

🔹 Q2

👉 Get customers who have placed at least one order worth more than 1000

given: customers with 1 order above 1000
not given: total value for order should be above 1000 or each row with same order id could also be above 1000
grain: customer_id in each row

```sql
select customer_id
from orders
group by order_id, customer_id
having sum(value) > 1000;
```

🔹 Q3

👉 Get total revenue for returned orders

given: total revenue for returned = 1
not given: what should be the final output look like
grain: single row with total revenue

```sql
select sum(value) as total_returned_revenue
from orders o
join returns r on o.order_id = r.order_id
where r.returned = 1
```

🔹 Q4

👉 Get top 5 customers by order count
given: top 5 by order count
not given: in waht order
grain: one row per customer

```sql
select customer_id, count(distinct order_id) as order_count
from orders
group by customer_id
order by order_count desc
limit 5
```

🔹 Q5 (TRAP)

👉 Get customers who have placed more orders than average

given - customers with orders more than average
not given - which order to be returned
grain - one row per customer_id

with cte as (
select customer_id, count(distinct order_id) as total_orders
from orders
group by customer_id
)
select customer_id
from cte
where order_count > (select avg(order_count) from cte);

👉 Question:
“Get customers with orders greater than 500”

select customer_id
from orders
group by customer_id
having count(disitnct order_id) > 500;

with cte as (
select customer_id, sum(value) as total_value
from orders
group by customer_id
)
select customer_id
from orders
where total_value > (select avg(total_value) from cte);

“Get customers who have at least one order with value > 500 AND total spend > 2000”

with above_500 as (
select distinct customer_id
from orders
where value > 500
)
select a.customer_id
from above_500 a
join orders o on a.customer_id = o.customer_id
group by customer_id
having sum(value) > 2000;

🔹 Problem 1 (Warm-up)

👉 Sum of Sales where Region = North

= SUMPRODUCT((A2:A6 = "North")\*(C2:C6))

🔹 Problem 2 (Multiple conditions)

👉 Sum of Sales where Region = North AND Category = A

= SUMPRODUCT((A2:A6 = "North")_(B2:B6 = "A")_(C2:C6))

🔹 Problem 3 (Condition + numeric filter)

👉 Sum of Sales where Profit > 15

= SUMPRODUCT((D2:D6 >= 15)\*(C2:C6))

🔹 Problem 4 (Advanced logic)

👉 Count number of rows where:

Region = North
AND Sales > 120

= SUMPRODUCT((A2:A6 = "North")\*(C2:C6 >= 120))

🔹 Problem 5 (Weighted average 🔥)

👉 Find average profit weighted by sales

Formula hint:

∑(Sales)
∑(Sales×Profit)

= SUMPRODUCT((D2:D6)\*(C2:C6))/SUM(C2:C6)
​

🔹 Problem 6 (Hard — OR condition)

👉 Sum of Sales where:

Region = North OR Category = B

⚠️ Trick: Avoid double counting

= SUMPRODUCT((A2:A6 = "North")+(B2:B6 = "B") \* ( C2:C6))
