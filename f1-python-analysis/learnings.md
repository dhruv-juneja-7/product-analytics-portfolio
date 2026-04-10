# Day 32

## The Key Lesson — Most Important Part

Write this in learnings.md:

```
Pandas vs SQL — The JOIN Multiplication Problem

In SQL, window functions like RANK() OVER (PARTITION BY...)
deduplicate rows before aggregation.

In Pandas, groupby().first() is the equivalent —
it picks one row per group based on sort order.

Pattern for deduplication in Pandas:
df.sort_values('rank_column').groupby(['key1','key2']).first().reset_index()

This is equivalent to:
WHERE rn = 1 after RANK() OVER (PARTITION BY key1, key2 ORDER BY rank_column)

Always check: does my groupby have one row per group I expect?
Print df.groupby(['key1','key2']).size() to verify before aggregating.
```

# Day 40

> Users doing X after doing Y

```
The mental model for these problems:
Any "did user do X after doing Y" question follows this structure:

CTE 1: find the anchor event (first order, signup, first purchase)
CTE 2: join back to same table to find subsequent events within a window
Filter: event date > anchor date AND event date <= anchor date + window
```
