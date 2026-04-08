# Week 1

## learnings Day 4

> LC 1225: Report Contiguous Dates : Islands question. For this my main lesson was to understand the logic using two clock method where the actual date is the master clock and the row_number is the local clock. The local clock should reset on each partition while the master clock should move continuously

> LC 1454: Active Users : Island question. For this my main lesson was to think which cte are at each step and how will rach row look in them and write the column names in each cte beforehand

> Consecutive numbers : Island problem. I solved it using my lag value, indicator and rolling sum to find group id approach. Lesson here if the consecutive value is 3 or 4 then use lead, lag instead of making groups to make the query faster.

## Learnings Day 5

> "Consecutive Numbers — LAG/LEAD approach. Find middle row where num = lag AND num = lead. Filter with WHERE not GROUP BY. **GROUP BY destroys consecutiveness.**"

## Learnings Day 6

Gaps and Islands two versions:

```sql

Version 1: value - rn
-> Use when dates, sequential integers like ids that keep on increasing
-> Example: attendance_streaks, contiguous date ranges

Version 2: rn_overall - rn_per_num

-> Use when: repeating values, status codes, same number consecutive
-> Example: LC 180 Consecutive Numbers, seat numbers, server downtime
```

> "Gaps and Islands is always about two clocks. When both clocks tick together the difference is constant — same island. When one clock skips the difference shifts — new island. Version 1 uses date and rn as the two clocks. Version 2 uses rn_overall and rn_per_num as the two clocks."

And remember in version 1 the master clock existed and we just have to create the local clock but in version 2 we have to create both the clocks

## Learnings Day 7

> One drill to add from next week: after writing each query, read it line by line top to bottom before running it. Give yourself 60 seconds of review. Catch your own errors before the interpreter does. In an interview this habit alone saves you from looking shaky on problems you actually know.

# Week 2

## Learnings Day 10

```
LC 1204 — Last Person to Fit in Bus
Pattern: Running Sum
Skeleton: SUM(value) OVER (ORDER BY sequence) AS cumulative
Find cutoff: WHERE cumulative <= limit, ORDER BY cumulative DESC, LIMIT 1
Key insight: Running sum accumulates state row by row.
Filter finds everything within limit.
Last row of that filtered set is the answer.
```

## Learnings Day 11

```
-- Step 1: Join lookup tables to get filter flags
-- Step 2: Filter on those flags
-- Step 3: Conditional aggregation for the metric
```

This pattern appears constantly in product company interviews — calculating rates, percentages, and ratios after filtering specific user segments.

---

## Add to learnings.md

```
LC 262 — Trips and Users
Pattern: Multi-join filtering + Conditional Aggregation
Skeleton:
  CTE: Join lookup table twice with different aliases to get flags
  Final: WHERE on flags, ROUND(SUM(CASE WHEN)/COUNT(*), 2)
Key insight: When same table is a lookup for two different
foreign keys, join it twice with different aliases.
Typo watch: be consistent with column names across CTEs.
```

### Optimized Way for this

```
Optimization rule: Filter inside JOIN conditions
rather than WHERE when possible.
Eliminates rows before intermediate results are built.
LIKE 'cancelled%' cleaner than multiple OR conditions
when values share a prefix.

```

> Problem - Overlapping Meetings

```
Overlapping Meetings — Running Sum Pattern
Skeleton:
  Step 1: UNION ALL — entry = +1, exit = -1
  Step 2: SUM(value) OVER (ORDER BY event_time, value ASC)
  Step 3: Filter WHERE running_sum > threshold

Key insight 1: Running sum = current occupancy at any moment.
Key insight 2: ORDER BY value ASC processes exits before
entries at same timestamp — prevents false inflation.
Key insight 3: Never name a CTE 'values' — reserved keyword.
```

> Pattern Recognition

```
How to classify SQL problems — 3 trigger questions:
1. Are rows connected across time/sequence? → window function
2. Does something start AND end? → event stream + running sum
3. Consecutive same values or streaks? → Gaps & Islands
Otherwise → ranking or aggregation

Language triggers:
simultaneously/overlapping/concurrent → running sum
consecutive/streak/in a row → gaps & islands
top N/rank/highest per group → dense_rank
rate/ratio/percentage → conditional aggregation
next/previous value → lag/lead

Physical metaphor trick: ask "what is being counted
in the real world?" — that thing is your running sum.
```

## Learnings Day 12

### LC 601 — Human Traffic of Stadium

```
"What is the sequential thing here — dates, IDs, or timestamps?"
In this problem it was the id as visit_date has some missing dates

Also remember to use order by in the final query if it is mentioned in the question or
the data can be sorted.
```

# Revision Until Now

```
My 5-Pattern SQL Library:

1. Gaps & Islands V1 — date/id - rn (local clock only)
2. Gaps & Islands V2 — rn_overall - rn_per_num (build both clocks)
3. Window Ranking — DENSE_RANK partition by group
4. Running Sum — event stream +1/-1 cumulative
5. Conditional Aggregation — SUM(CASE WHEN)/COUNT(*)

Bonus tool: LAG/LEAD — neighbour row comparison

Decision: start and end? → 4
          consecutive/streak? → 1 or 2
          top N per group? → 3
          rate/ratio? → 5
          previous/next value? → LAG/LEAD

```

## Day - 13

> Revision

```
Attendance query -
That is it. Gaps & Islands Version 1. work_date - rn partitioned by emp_id.

1454

dedup fix - DISTINCT on id and login_date in a CTE first
Then ROW_NUMBER on the deduped result

1225

contiguous dates
union all
date - rn logic and use partition by type

180

First Approach
lead value = current row and lag value = current row


Second Approach
rn_overall - rn_per_num

1204

WHERE cumulative_sum <= 1000
ORDER BY cumulative_sum DESC
LIMIT 1

601

id - row_number
instead of visit_date as it is not sequential
```

# Week - 3

## Day - 17

```
F1 Podium Streak Query — Key learnings:
1. ROW_NUMBER() OVER () — brackets after ROW_NUMBER always
2. Date - integer needs INTERVAL in PostgreSQL
3. ORDER BY streak_length DESC for "longest ever" questions
4. LIMIT 10 for top N results
5. CONCAT(forename, ' ', surname) for full driver name
```

## Day - 29

```
NULLIF for division by zero: round(numerator * 1.0 / NULLIF(denominator, 0), 2) Use whenever denominator could be zero. Returns NULL instead of error — cleaner than CASE WHEN.
```

## Day - 30

Always run SELECT column_name FROM information_schema.columns WHERE table_name = 'results' before writing to confirm exact names.
