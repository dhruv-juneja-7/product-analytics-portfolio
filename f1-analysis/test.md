-- ❌ yours
concat(d.forename,' ', d.lastname)

-- ✅ correct
concat(d.forename,' ', d.surname)

```

The column is `surname` not `lastname` in the drivers table. This would have thrown an error in pgAdmin. Everything else is clean.

**Results are correct and justified:**

2023 Verstappen with 19 wins out of 22 races is historically accurate — the most dominant season in modern F1. 2021 showing six drivers tied at 1 win for rank 3 is correct — that was an unusually competitive season outside the top two. Results check out.

---

## Query 2 — Pole to Win Conversion ✅

Logic is correct. The NULLIF fix is exactly right. The results are justified:

- Mercedes 75% and Red Bull 73% reflect their recent dominance
- Toro Rosso at 100% is technically correct but misleading — they only had 1 pole position ever, so 1 conversion = 100%. This is a classic small sample size problem worth noting
- Ferrari at 55% despite 104 poles shows they qualify well but lose races — a known F1 narrative

**The three errors you made — all mechanical:**
Missing constructor name in SELECT, missing ORDER BY, division by zero — none of these were logic errors. The thinking was right. The review step caught them. That is the process working.

**One thing to add to learnings.md:**
```

NULLIF for division by zero:
round(numerator \* 1.0 / NULLIF(denominator, 0), 2)
Use whenever denominator could be zero.
Returns NULL instead of error — cleaner than CASE WHEN.

```

---

## LinkedIn Post — Ready to Copy Paste
```

I spent the last few weeks analysing F1 Championship
data going back to 1950 using SQL.

Here are 3 findings that surprised me:

1/ Verstappen won 19 of 22 races in 2023.
The most dominant single season in modern F1 history.
In 2024? He won only 9. Norris and Leclerc
finally closed the gap.

2/ Mercedes converts pole position to race win
75% of the time.
Red Bull 73%. Ferrari only 55% — despite having
104 pole positions. They qualify brilliantly
but lose races.

3/ Michael Schumacher holds the all-time record
for consecutive podium finishes — 19 in a row
between 2001 and 2002.
Lewis Hamilton is closest with 16 (2014-2015).

The SQL patterns behind these findings:
→ Gaps & Islands for streak analysis
→ Dense Rank for season-by-season rankings  
→ Conditional Aggregation for conversion rates

All three are the same patterns product companies
use to analyse user retention, feature adoption,
and conversion funnels.

Full analysis on GitHub 👇
github.com/dhruv-juneja-7/product-analytics-portfolio

#SQL #DataAnalytics #F1 #ProductAnalytics #Analytics

```

---

## Rest of Today — 2:41 PM onwards

**2:41 – 3:00 | Post on LinkedIn**
Copy paste the post above. Add one screenshot of your query results as an image — recruiters stop scrolling for visuals. Just screenshot the results table from pgAdmin.

**3:00 – 4:30 | 5 Job Applications**
Only these companies today:

Search on LinkedIn Jobs: "Data Analyst Gurugram" sorted by most recent.

Target:
- MakeMyTrip
- InfoEdge/Naukri
- PolicyBazaar
- Cars24
- Meesho

10 minutes per application. Read JD, check 60% match, apply with new resume, one line message.

**4:30 – 5:00 | 3 LinkedIn Connection Requests**
People at the companies above. Use this template:
```

Hi [Name], I'm a Senior Data Analyst transitioning
into product analytics. I'd love to connect and
learn from your experience at [Company].

```

**5:00 – 6:00 | Break**
Cook, eat, rest.

**6:00 – 6:20 | German**
Nicos Weg next episode.

**6:20 – 6:40 | Harmonica**
Adam Gussow lesson 1. 15 minutes. One clean note.

**Before sleep | Nightly checklist + log + X**

---

## Push to GitHub Before Posting on LinkedIn

Add both queries to your repo first:
```

f1-podium-analysis/
├── f1_top3_wins_per_season.sql ← Q3
├── f1_pole_to_win_conversion.sql ← Q4
