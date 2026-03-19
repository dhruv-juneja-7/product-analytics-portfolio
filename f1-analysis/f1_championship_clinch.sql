-- SELECT * from f1.races;

-- set search_path to f1, public;

-- At which race does the F1 champion become mathematically uncatchable each season?

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

create table driver_standings (
driverStandingsId	int,
raceId	int,
driverId	int,
points	float,
position	int,
positionText	text,
wins int
);

select * from driver_standings limit 10;




with races_total as (
    select ra.year as season, count(distinct ra.raceId) as total_races, max(re.points) as max_point_per_season
    from races ra
    join results re on ra.raceId = re.raceId
    group by ra.year
),
position_1_driver as (
    select ds.raceId, ds.driverId as position_1_driverId, ds.points as position_1_points, concat(d.forename, ' ', d.surname) as position_1_driver_name
    from driver_Standings ds
    join drivers d on ds.driverId = d.driverId
    where position = 1
),
position_2_driver as (
    select ds.raceId, ds.driverId as position_2_driverId, ds.points as position_2_points, concat(d.forename, ' ', d.surname) as position_2_driver_name
    from driver_Standings ds
    join drivers d on ds.driverId = d.driverId
    where position = 2
),
joined_drivers as (
    select r.year as season, r.date, p1.raceid, r.name, p1.position_1_driverId, p1.position_1_driver_name, p1.position_1_points, p2.position_2_driverId, p2.position_2_driver_name, p2.position_2_points
    from position_1_driver p1
    join position_2_driver as p2 on p1.raceid = p2.raceid
    join races r on r.raceId = p1.raceid
),
races_total_joined_drivers as (
    select rt.season, rt.total_races, rt.max_point_per_season, jd.raceId, jd.name, jd.date, jd.position_1_driverId, jd.position_1_driver_name, jd.position_1_points, jd.position_2_driverId, jd.position_2_driver_name, jd.position_2_points,
    sum(1) over(partition by rt.season order by date) as races_subtractor 
    from races_total rt
    join joined_drivers jd on rt.season = jd.season
),
points_gap as (
    select season, total_races, max_point_per_season, raceId, name, date, position_1_driverId, position_1_driver_name, position_1_points, position_2_driverId, position_2_driver_name, position_2_points, races_subtractor, (total_races - races_subtractor) as races_left, max_point_per_season * (total_races - races_subtractor) as max_remaining_points_this_season,
    position_1_points - position_2_points as gap_btw_1_and_2_driver
    from races_total_joined_drivers
),
rankings as (
select season,  position_1_driver_name, raceId, name, races_left, rank() over(partition by season order by races_left desc) as rn
from points_gap
where max_remaining_points_this_season < gap_btw_1_and_2_driver
)
select season,  position_1_driver_name as champion, name as clinch_race, races_left
from rankings
where rn = 1
order by season desc;
