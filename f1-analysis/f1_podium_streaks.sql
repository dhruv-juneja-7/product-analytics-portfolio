
-- F1 SQL Questions

-- "Find each driver's consecutive race podium streaks (top 3 finishes) — who had the longest unbroken run in F1 history?"

with continuous_races as (
select raceId, date, row_number() over(order by date) as rn_overall
from races
),
groupings as (
    select re.driverId, re.raceId, ra.date, re.positionOrder,
    ra.rn_overall - row_number() over (partition by re.driverId order by rn_overall) as group_id
    from results re
    join continuous_races ra on re.raceId = ra.raceId
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
order by streak_length desc;

