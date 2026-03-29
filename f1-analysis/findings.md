# F1 Data — Key Findings

---

## 1. Consecutive Podium Streaks (All Time)

**Question:** Which F1 driver had the longest consecutive
podium finishing streak in history?

**Pattern Used:** Gaps & Islands V2 — rn_overall minus rn_per_driver

| Driver             | Consecutive Podiums | Period              |
| ------------------ | ------------------- | ------------------- |
| Michael Schumacher | 19                  | Sep 2001 – Oct 2002 |
| Lewis Hamilton     | 16                  | Sep 2014 – Jul 2015 |
| Max Verstappen     | 15                  | Nov 2022 – Sep 2023 |
| Fernando Alonso    | 15                  | Aug 2005 – Jun 2006 |
| Sebastian Vettel   | 11                  | Nov 2010 – Jul 2011 |

**Key Insight:** Every driver in the top 5 is a World
Champion — podium consistency and championships are
directly correlated.

**Technical Note:** Race dates have natural gaps between
seasons — standard date subtraction fails here. Used
rn_overall (overall race sequence number ordered
chronologically) as the master clock instead of date.

---

## 2. Championship Clinch Point (2021–2024)

**Question:** At which race does the F1 champion become
mathematically uncatchable each season?

**Pattern Used:** Cumulative race counter + points gap calculation

| Season | Champion       | Clinch Race          | Races Left |
| ------ | -------------- | -------------------- | ---------- |
| 2024   | Max Verstappen | Las Vegas Grand Prix | 2          |
| 2023   | Max Verstappen | Japanese Grand Prix  | 6          |
| 2022   | Max Verstappen | Japanese Grand Prix  | 4          |
| 2021   | Max Verstappen | Abu Dhabi Grand Prix | 0          |

**Key Insight:** Verstappen clinched earlier every year
from 2021 to 2023 — showing increasing dominance.
2023 with 6 races remaining was his most dominant
title. 2021 with 0 races remaining was the most
dramatic — decided on the final lap of the final race
against Lewis Hamilton with equal points going in.

**Notable:** 2016 was won by Nico Rosberg — the only
championship in this era not won by Verstappen or
Hamilton — clinched at the final race in Abu Dhabi,
his last ever race before retirement.

**Technical Note:** JOIN between races and results
multiplies rows — used COUNT(DISTINCT raceId) to get
accurate race counts per season. Max points per race
calculated dynamically per season to handle rule
changes across different eras.

---

## 3. Top 3 Drivers by Wins per Season

**Question:** For each season, who are the top 3 drivers based
on the number of race wins?

**Pattern Used:** Aggregation + window function (DENSE_RANK)

| Season | Driver Name     | Wins | Rank |
| ------ | --------------- | ---- | ---- |
| 2024   | Max Verstappen  | 9    | 1    |
| 2024   | Lando Norris    | 4    | 2    |
| 2024   | Charles Leclerc | 3    | 3    |
| 2023   | Max Verstappen  | 19   | 1    |
| 2023   | Sergio Pérez    | 2    | 2    |
| 2023   | Carlos Sainz    | 1    | 3    |

**Key Insight:** Verstappen’s 2023 season stands out as one
of the most dominant in F1 history, with 19 wins — far
ahead of any other driver. The sharp drop from 19 to 2
wins between rank 1 and rank 2 highlights the gap in
performance that season.

**Notable:** Some seasons may return more than 3 drivers
due to ties, since DENSE_RANK assigns the same rank
to equal win counts.

**Technical Note:** Used `positionOrder = 1` to correctly
identify race winners and avoid issues with non-numeric
values in `position`. Aggregation was performed at the
driver-season level, followed by DENSE_RANK partitioned
by season to identify top performers.

---

## 4. Pole Position to Race Win Conversion Rate

**Question:** Does starting from pole position guarantee
a win? Which constructor converts pole to victory most reliably?

**Pattern Used:** Conditional Aggregation —
`SUM(CASE WHEN condition THEN 1 ELSE 0 END) / COUNT(*)`

**Technical Note:** Used NULLIF to prevent division by
zero errors for constructors with zero pole positions.
`ROUND(SUM(pole_to_win) * 1.0 / NULLIF(SUM(poles), 0), 2)`

| Constructor | Poles | Pole-to-Win | Conversion Rate |
| ----------- | ----- | ----------- | --------------- |
| Toro Rosso  | 1     | 1           | 1.00            |
| Brawn       | 5     | 4           | 0.80            |
| Mercedes    | 135   | 101         | 0.75            |
| Red Bull    | 105   | 77          | 0.73            |
| Renault     | 20    | 12          | 0.60            |
| Benetton    | 11    | 6           | 0.55            |
| Ferrari     | 104   | 57          | 0.55            |
| McLaren     | 64    | 31          | 0.48            |
| Williams    | 38    | 18          | 0.47            |

**Key Insight:** Ferrari has 104 pole positions but
only converts 55% to wins — identical to Benetton
and far behind Mercedes (75%) and Red Bull (73%).
Ferrari qualifies brilliantly but consistently loses
races — a widely debated narrative in F1 that this
data confirms statistically.

**Small Sample Warning:** Toro Rosso's 100% rate is
misleading — based on a single pole position. Always
check sample size before drawing conclusions from
conversion rates.

---

## Coming Next

- **Q5:** Which circuits produce the most overtakes?
  (lap position changes per race per circuit)
- **Q6:** Driver age vs performance — do drivers peak
  at a specific age in F1?
