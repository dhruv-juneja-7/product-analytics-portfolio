-- what % of drivers who scored points in there debut season keep scoring the subsequent seasons.

with points_agg as (
	select driverId, ra.year as season, sum(points) as total_points
	from races ra
	join results re on ra.raceId = re.raceId
	group by driverId, year
),
debut as (
	select driverId, min(season) as debut_season 
	from points_agg
	group by driverId
),
debut_match_scorers as  (
	select d.driverId, debut_season, season, pa.total_points
	from debut d 
	join points_agg pa on d.driverId = pa.driverId and d.debut_season = pa.season
	where pa.total_points > 0
),
subsequent_scorers as (
	select d.driverId, debut_season, p.season - debut_season as seasons_since_debut, p.total_points
	from debut_match_scorers d 
	join points_agg p on d.driverId = p.driverId
)
select debut_season, seasons_since_debut, count(distinct driverId) as cohort_drivers,
count(distinct case when total_points > 0 then driverId else null end) as drives_keep_scoring,
round((count(distinct case when total_points > 0 then driverId else null end)*100.0)/count(distinct driverId),2) as retention_pct
from subsequent_scorers
group by debut_season, seasons_since_debut
order by debut_season desc, seasons_since_debut;