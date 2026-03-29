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
select c.name, sum(pole_ind) as pole_wins, sum(pole_to_win_ind) as pole_to_race_wins, 
round((sum(pole_to_win_ind) * 1.0)/nullif(sum(pole_ind),0),2) as pole_to_win_conversion_rate
from pole_win_cte pwc
join constructors c on pwc.pole_constructor = c.constructorid 
group by c.name
having sum(pole_to_win_ind) > 0
order by pole_to_win_conversion_rate desc;


