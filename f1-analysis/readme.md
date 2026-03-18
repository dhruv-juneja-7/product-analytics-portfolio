## F1 Podium Streak Analysis

**Question:** Which F1 driver had the longest
consecutive podium finishing streak in history?

**Data:** Formula 1 World Championship dataset
(1950–2020) — races, results, and drivers tables.

**Approach:** Applied Gaps & Islands SQL pattern
to group consecutive podium finishes per driver.

**Technical Challenge:** Race dates have natural
gaps between seasons — standard date subtraction
fails here because the difference shifts across
season boundaries.

**Fix:** Created an overall race sequence number
(rn_overall) ordered chronologically across all
races, then used rn_overall minus per-driver
row number as the group key. This treats each
race as a sequential position regardless of
calendar gaps.

**Key Finding:**

| Driver             | Consecutive Podiums | Period              |
| ------------------ | ------------------- | ------------------- |
| Michael Schumacher | 19                  | Sep 2001 – Oct 2002 |
| Lewis Hamilton     | 16                  | Sep 2014 – Jul 2015 |
| Max Verstappen     | 15                  | Nov 2022 – Sep 2023 |
| Fernando Alonso    | 15                  | Aug 2005 – Jun 2006 |
| Sebastian Vettel   | 11                  | Nov 2010 – Jul 2011 |

Every driver in the top 5 is a World Champion —
podium consistency and championships are
directly correlated.

**SQL Pattern Used:** Gaps & Islands Version 2
— both clocks built from scratch when master
clock has natural gaps.

**File Used:** [f1_podium_streaks.sql](./f1_podium_streaks.sql)
