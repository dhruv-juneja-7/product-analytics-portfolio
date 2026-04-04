### Question - Attendance Streak

You have a table of employee login records. Find each employee's consecutive attendance streaks — meaning, group the days they came in without any gap, and show the start date, end date, and length of each streak.
Table name - attendance
columns - emp_id, work_dates

### Question - Increasing Streak

![alt text](Increasing_Streak.jpeg)

```sql
with lagged_amount as (
    select user_id, date, amount as curr_amount,
    lag(amount) over(partition by user_id order by date) as prev_amount
    from users
),
indicators as (
    select user_id, date, curr_amount, prev_amount,
    case when prev_amount is null or prev_amount < curr_amount then 0 else 1 end as ind
    from lagged_amount
),
groups as (
    select user_id, date, curr_amount, prev_amount, ind, sum(ind) over(partition by user_id order by date) as groups
    from indicators
),
streaks as (
    select user_id, count(groups) as streak_count
    from groups
    group by user_id, groups
)
select distinct user_id
from streaks
where streak_count >= 3
```

### Question

> Write an SQL query to display the records [in the Stadium table] with three or more rows with consecutive id’s, and the number of people is greater than or equal to 100 for each. Return the result table ordered by visit_date in ascending order.

```sql
with lagged_table as (
    select id, visit_date, people, lag(id) over(order by id) as lag_id,
    case when lag(id) over(order by id) is null or lag(id) over(order by id) + 1 = id then 0 else 1 end as ind
    from stadium
    where people >= 100
),
groupings as (
    select id, visit_date, people, sum(ind) over(order by id) as groups
    from lagged_table
),
grouped_data as (
    select groups, count(*) as count_all
    from groupings
    group by groups
    having count(*) >= 3
)
select id, visit_date, people
from groupings l
join grouped_data g on l.groups = g.groups
order by visit_date
```

```sql
with ranks as (
    select emp_id, work_date, row_number() over(partition by emp_id order by work_date) as rn,
    work_date - row_number() over(partition by emp_id order by work_date) as group_id
    from attendance
)
select emp_id, min(work_date) as start_date, max(work_date) as end_date, count(*) as streak_length
from ranks
group by emp_id, group_id
```

## LC 1454 Active Users

> Question - Active users are those who logged in to their accounts for five or more consecutive days.
> Write a solution to find the id and the name of active users.
> Return the result table ordered by id.

> Tables - accounts - id, name

            logins - id, login_date

```sql
with rankings as (
    select id, login_date, row_number() over (partition by id order by login_date) as rn
    from logins
),
groupings as (
    select id, login_date, login_date - rn * Interval '1 day' as groups
    from rankings
),
streaks as (
    select id, min(login_date) as streak_start_date, max (login_date) as streak_end_date, count(*) as streaks
    from groupings
    group by id, groups
    having count(*) >= 5
)
select distinct a.id, a.name
from accounts a
join streaks s on a.id = s.id
```

## Suspicious Raid Transactions

> Correct but not optimised

```sql
with intervals as (
    select a.user_id, a.txn_time as start_time,
    b.txn_time, a.amount
    from transactions a
    join transactions b
    on a.user_id = b.user_id and (b.txn_time >= a.txn_time and b.txn_time <= a.txn_time + INTERVAL '10 minutes')
)
select user_id, start_time, max(txn_time) as end_time, count(*) as txn_count
from intervals
group by user_id, start_time
having count(*) >= 3

```

> Optimised using window functions

```sql
with burst_counts as (
    select user_id, txn_time,
    count(*) over (
        partition by user_id
        order by txn_time
        range between current row and interval '10 minutes' following
    ) as bursts,
    max(txn_time) over(
        partition by user_id
        order by txn_time
        range between current row and interval '10 minutes' following
    ) as end_time
    from transactions
)
select user_id, txn_time as start_time, end_time, bursts
from burst_counts
where bursts >= 3
order by user_id, start_time
```

### LC 1225 Report Contiguous Dates

```sql
with combined as (
    select 'failed' as period_state, date
    from failed
    union all
    select 'succeeded' as period_state, date
    from succeeded
),
markings as (
    select period_state, date,
    row_number() over (order by date) as rn,
    date - row_number() over (order by date) * INTERVAL '1 day' as streak_start_date
    from combined
),
groupings as (
    select period_state, date,
    concat(left(period_state, 1), streak_start_date) as groups
    from markings
)
select period_state, min(date) as start_date, max(date) as end_date
from groupings
group by period_state, groups
order by start_date
```

### Lesson

> In the above query the row_number will continue event if the period state changes, making two failed states with a gap a part of the same group.

> So, we have to use a partition by because we want the row_number (our local clock) to stop when the state is not the same while the actual dates ( the master clock) continues. This will treat two same period_states as part of different groups.

### LC 180 Consecutive Numbers.

```sql
with lag_table as (
    select id, num, lag(num) over(order by id) as lag_num
    from logs
),
indicators as (
    select id, num, lag_num,
    case when lag_num is null or num - lag_num = 0 then 0 else 1 end as ind
    from lag_table
),
groups as (
    select id, num, ind, sum(ind) over(order by id) as group_id
    from indicators
)
select distinct num
from groups
group by num, group_id
having count(*) >= 3
```

> Consecutive numbers using lead and lag approach

```sql
with lead_lag as (
select id, num,
lead(num) over (order by id) as lead_num,
lag(num) over (order by id) as lag_num
from logs
)
select distinct num
from lead_lag
where num = lead_num and num = lag_num;
```

### LC 1204 Last Person to Fit on the Bus

```sql
with cumulative_sum as (
    select person_id, person_name, person_weight,
    sum(person_weight) over (order by turn) as total_weight
    from queue
)

select person_name
from cumulative_sum
where total_weight <= 1000
order by total_weight desc

```

## LC 1867 Orders With Maximum Quantity Above Average

```sql
with groupings as (
    select order_id, max(quantity) as max_qty, (sum(quantity)*1.0)/count(distinct product_id) as avg_qty
    from orderdetails
    group by order_id
),
max_avg as (
    select max(avg_qty) as max_avg_qty from groupings
)
select distinct order_id
from groupings g
cross join max_avg m
where max_qty > max_avg_qty
```

## LC 185 Department Top 3 Salaries

```sql
with ranks as (
    select id, name, salary , department_id,
    dense_rank() over(partition by department_id order by salary desc) as rn
    from employee
)
select d.name as department, r.name as employee, salary
from ranks r
join department d on r.department_id = d.id
where rn <= 3
order by department, salary desc, name
```

## LC 262 — Trips and Users

```sql
with banned_filter as (
    select id, client_id, driver_id, status, request_at, u.banned as client_banned, u2.banned as driver_banned
    from trips t
    left join users u on t.client_id = u.user_id
    left join users u2  on t.driver_id = u2.user_id
    where request_at >= '2013-10-01' and request_at <= '2013-10-03'
)
select request_at as day, round((sum(case when status = 'cancelled_by_client' or status = 'cancelled_by_driver' then 1 else 0 end)*1.0)/count(*),2) as cancellation_rate
from banned_filter
where client_banned = 'No' and driver_banned = 'No'
group by request_at
order by day
```

> Optimized Query

```
SELECT
    request_at AS day,
    ROUND(SUM(CASE WHEN status LIKE 'cancelled%' THEN 1 ELSE 0 END) * 1.0 / COUNT(*), 2) AS cancellation_rate
FROM trips t
JOIN users c ON t.client_id = c.user_id AND c.banned = 'No'
JOIN users d ON t.driver_id = d.user_id AND d.banned = 'No'
WHERE request_at BETWEEN '2013-10-01' AND '2013-10-03'
GROUP BY request_at
ORDER BY day;
```

## LC 1454 Variant — Overlapping Meetings

```sql

-- exits are processed before entries

with single_table as (
    select start_time as event_time, 'entry' as type, 1 as value
    from meetings
    union all
    select end_time as event_time, 'exit' as type, -1 as value
    from meetings
),
running_totals as (
select event_time, sum(value) over(order by event_time, value) as running_sum
from single_table
)
select event_time
from running_totals
where running_sum > 2
order by event_time
```

## LC 601 — Human Traffic of Stadium

```sql
with groupings as (
    select id, visit_date, people ,
    visit_date - row_number() over (order by id) as group_id
    from stadium
    where people >= 100
),
streaks as (
    select group_id
    from groupings
    group by group_id
    having count(*) >=3
)
select id, visit_date, people
from groupings g
join streaks s on s.group_id = g.group_id
order by id
```

# F1 SQL Questions

> "Find each driver's consecutive race podium streaks (top 3 finishes) — who had the longest unbroken run in F1 history?"

```sql
with groupings as (
    select re.driverId, re.raceId, ra.date, re.positionOrder,
    ra.date - (row_number() over (partition by re.driverId order by date) * INTERVAL '1 day') as group_id
    from results re
    join races ra on re.raceId = ra.raceId
    where positionOrder in (1,2,3)
),
streaks as (
    select driverId, group_id, min(date) as streak_start_date, max(date) as streak_end_date, count(*) as streak_length
    from groupings
    group by driverId, group_id
)
select s.driverId, concat(d.forename, ' ', d.surname), streak_start_date, streak_end_date, streak_length
from streaks s
join drivers d on s.driverid = d.driverid
order by streak_length desc
```
