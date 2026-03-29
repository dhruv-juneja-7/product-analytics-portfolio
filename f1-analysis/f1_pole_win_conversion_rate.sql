set search_path to f1, public;

with wins_cte as (
    select r.year as season, rs.driverid, count(*) as wins
    from results rs
    join races r on rs.raceid = r.raceid
    where rs.positionOrder = 1
    group by r.year, rs.driverid
),
ranks_cte as (
    select wc.season, wc.driverid, concat(d.forename,' ', d.surname) as driver_name, wc.wins
    , dense_rank() over(partition by season order by wins desc) as rn
    from wins_cte wc
    join drivers d on wc.driverid = d.driverid
)
select season, driver_name, wins as wins_per_season, rn
from ranks_cte
where rn <= 3
order by season desc, wins_per_season desc;




create table qualifying (
qualifyId	int,
raceId	int,
driverId	int,
constructorId	int,
number	int,
position	int,
q1	time,
q2	time,
q3 time
);

create table constructors (
constructorId	int,
constructorRef	text,
name	text,
nationality	text,
url text
);

with qualifying_cte as (
    select raceid, constructorid, driverid, position, rank() over(partition by raceid, constructorid order by position) as rn,
    case when position = 1 then 1 else 0 end as pole_ind
    from qualifying
),
filtered_qualifying as (
    select raceid, constructorid, driverid, position as pole_position, pole_ind
    from qualifying_cte
    where rn = 1
),
results_cte as (
    select raceid, constructorid, driverid, positionOrder, rank() over(partition by raceid, constructorid order by positionOrder) as rn,
    case when positionOrder = 1 then 1 else 0 end as win_ind
    from results
),
filtered_results as (
    select raceid, constructorid, driverid, positionOrder as win_position, win_ind
    from results_cte
    where rn = 1
),
pole_win_cte as (
    select r.year as season, r.name as race_name, fq.constructorid as pole_constructor, fq.driverid as pole_driverid,
    fq.pole_ind, fr.constructorid as winner_constructor, fr.driverid as winner_driverid,
    fr.win_ind, 
    case when pole_ind = 1 and win_ind = 1 then 1 else 0 end as pole_to_win_ind
    from filtered_qualifying fq
    join filtered_results fr on fq.raceid = fr.raceid and fq.constructorid = fr.constructorid
    join races r on fq.raceid = r.raceid
)
select season, pole_constructor, sum(pole_ind) as pole_wins, sum(pole_to_win_ind) as pole_to_race_wins, 
round((sum(pole_to_win_ind) * 1.0)/nullif(sum(pole_ind),0),2) as pole_to_win_conversion_rate
from pole_win_cte
group by season, pole_constructor
having sum(pole_to_win_ind) > 0
order by season desc, pole_to_win_conversion_rate desc;