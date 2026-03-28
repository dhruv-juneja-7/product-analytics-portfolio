-- SELECT * from f1.races;

-- set search_path to f1, public;

-- At which race does the F1 champion become mathematically uncatchable each season?




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
