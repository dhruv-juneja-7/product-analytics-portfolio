-- Statement - For each season, find the top 3 drivers based on number of race wins, using DENSE_RANK.

with wins_cte as (
    select r.year as season, rs.driverid, count(*) as wins
    from results rs
    join races r on rs.raceid = r.raceid
    where rs.positionOrder = 1
    group by r.year, rs.driverid
),
ranks_cte as (
    select wc.season, wc.driverid, concat(d.forename,' ', d.lastname) as driver_name, wc.wins
    , dense_rank() over(partition by season order by wins desc) as rn
    from wins_cte wc
    join drivers d on wc.driverid = d.driverid
)
select season, driver_name, wins as wins_per_season, rn
from ranks_cte
where rn <= 3
order by season desc, wins_per_season desc;