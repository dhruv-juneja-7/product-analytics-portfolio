# F1 Performance Analytics

Advanced SQL analysis of Formula 1 World Championship
data (1950–2024) — finding patterns in driver performance,
championship battles, and race consistency.

Built as part of a structured transition into product
analytics. Each query is paired with the business
question, technical challenge, and real finding.

---

## About

Built during a deliberate transition from CRM analytics
into product analytics. Problems selected to demonstrate
advanced SQL pattern recognition on real-world data.

---

## Dataset

**Source:** Formula 1 World Championship (Ergast API)  
**Tables Used:** races, results, drivers, driver_standings  
**Period:** 1950–2024

---

## Analysis 1 — Consecutive Podium Streaks

**File:** [f1_podium_streaks.sql](./f1_podium_streaks.sql)

**Question:** Which F1 driver had the longest consecutive
podium finishing streak (top 3 finishes) in history?

**Pattern:** Gaps & Islands

**Technical Challenge:** Race dates have natural gaps
between seasons — standard `date - ROW_NUMBER()` fails
because the difference shifts across season boundaries.

**Fix:** Created `rn_overall` — an overall race sequence
number ordered chronologically across all seasons — and
used `rn_overall - rn_per_driver` as the group key.
This treats each race as a sequential position regardless
of calendar gaps.

**Key Finding:**

| Driver             | Consecutive Podiums | Period              |
| ------------------ | ------------------- | ------------------- |
| Michael Schumacher | 19                  | Sep 2001 – Oct 2002 |
| Lewis Hamilton     | 16                  | Sep 2014 – Jul 2015 |
| Max Verstappen     | 15                  | Nov 2022 – Sep 2023 |
| Fernando Alonso    | 15                  | Aug 2005 – Jun 2006 |
| Sebastian Vettel   | 11                  | Nov 2010 – Jul 2011 |

Every driver in the top 5 is a World Champion —
podium consistency and championships are directly
correlated.

---

## Analysis 2 — Championship Clinch Point

**File:** [f1_championship_clinch.sql](./f1_championship_clinch.sql)

**Question:** At which race does the eventual F1 champion
become mathematically uncatchable each season?

**Pattern:** Cumulative counter + points gap calculation

**Logic:** When the points gap between first and second
place in the standings exceeds the maximum points still
available in the remaining races — the title is
mathematically clinched.

**Technical Challenge:** Joining races to results
multiplies rows — one race appears 20 times (once per
driver). Used `COUNT(DISTINCT raceId)` instead of
`COUNT(*)` to get accurate race counts per season.

**Key Finding:**

| Season | Champion       | Clinch Race          | Races Left |
| ------ | -------------- | -------------------- | ---------- |
| 2024   | Max Verstappen | Las Vegas Grand Prix | 2          |
| 2023   | Max Verstappen | Japanese Grand Prix  | 6          |
| 2022   | Max Verstappen | Japanese Grand Prix  | 4          |
| 2021   | Max Verstappen | Abu Dhabi Grand Prix | 0          |

Verstappen clinched earlier every year from 2021 to
2023 — showing increasing dominance over the grid.
2021 with 0 races remaining was the most dramatic
title in modern F1 — decided on the final lap of
the final race against Lewis Hamilton with equal
points going into the weekend.

## Key Technical Learnings

**1. Gaps & Islands with non-continuous dates**  
When dates have natural gaps (season boundaries,
missing races), use `rn_overall - rn_per_partition`
instead of `date - rn`. Build both clocks from scratch.

**2. COUNT(\*) after JOIN**  
Always ask: does this JOIN multiply rows? One-to-many
JOINs require `COUNT(DISTINCT)` not `COUNT(*)`.

**3. Dynamic max points**  
F1 points system changed multiple times across history.
Calculate `MAX(points)` per season dynamically — never
hardcode 25.

## **Analysis 3 — Top 3 Drivers by Wins per Season**

**File:** [f1_top_3_drivers.sql](./f1_top_3_drivers.sql)

**Question** Identify the **top 3 drivers in each season** based on the number of race wins.

**Pattern**

**Aggregation + Window Function (DENSE_RANK)**

**Logic**

- Filter race results to include only **winning positions** (`positionOrder = 1`)
- Aggregate wins at the **driver-season level**
- Apply `DENSE_RANK()` to rank drivers within each season by total wins
- Select drivers with rank ≤ 3

**Key Finding:**

| Season | Driver Name     | Wins | Rank |
| ------ | --------------- | ---- | ---- |
| 2024   | Max Verstappen  | 9    | 1    |
| 2024   | Lando Norris    | 4    | 2    |
| 2024   | Charles Leclerc | 3    | 3    |
| 2023   | Max Verstappen  | 19   | 1    |
| 2023   | Sergio Pérez    | 2    | 2    |
| 2023   | Carlos Sainz    | 1    | 3    |

Max Verstappen recorded **19 race wins in the 2023 season**, the highest number of wins by a driver in a single season in this dataset, reflecting a historically dominant performance.

### **Key Technical Learnings**

1. Always align aggregation level with the business question (driver-season in this case)
2. Choosing the correct table grain (`results` vs `driver_standings`) is critical for accurate analysis
3. Window functions like `DENSE_RANK()` are essential for intra-group ranking problems

## Coming Next

| Analysis                | Question                            | Pattern                 |
| ----------------------- | ----------------------------------- | ----------------------- |
| Q4 — Qualifying vs Race | Does pole position guarantee a win? | Conditional Aggregation |

## SQL Patterns Used

| Pattern                 | Description                                    |
| ----------------------- | ---------------------------------------------- |
| Gaps & Islands V2       | Consecutive streaks when master clock has gaps |
| Running Sum             | Cumulative counter across ordered rows         |
| Dense Rank              | Top N per partition                            |
| Conditional Aggregation | Rates and ratios per group                     |

_Updated weekly as new analyses are added._
