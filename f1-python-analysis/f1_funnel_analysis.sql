-- Funnel: Qualified top 5 → Finished top 5 → Podium → Won

with qualify_top_5 as (
    select raceId, driverId, position
    from qualifying
    where position <= 5
),
funnel as (
    select q.driverId,
    count(case when q.position <= 5 then q.raceId end) as qualify_top_5,
    count(case when r.positionOrder <= 5 then r.raceId end) as pos_top_5,
    count(case when r.positionOrder <= 3 then r.raceId end) as podium,
    count(case when r.positionOrder = 1 then r.raceId end) as won   
    from qualify_top_5 q
    left join results r on q.raceId = r.raceId and q.driverId = r.driverId
    group by q.driverId
)
select f.driverId,
concat(d.forename, ' ', d.surname) as driver_name,
qualify_top_5,
pos_top_5,
round((pos_top_5 * 1.0)/nullif(qualify_top_5,0),2) as top_5_conversion_rate,
podium,
round((podium * 1.0)/nullif(pos_top_5,0),2) as podium_conversion_rate,
won,
round((won * 1.0) / nullif(podium,0),2) as won_conversion_rate
from funnel f
left join drivers d on f.driverId = d.driverId
order by qualify_top_5 desc, pos_top_5 desc, podium desc, won desc;

