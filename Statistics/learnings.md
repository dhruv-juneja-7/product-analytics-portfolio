## Mean vs Median

- Mean is affected significantly by the outliers
- Median is slightly affected by the outliers
- Example: average salary in a company with one
  CEO earning 10 crore looks high
  Median salary tells the real story

## Standard deviation

- It tells about the spread of the values around the mean.
- The greater is its value, the more spread the data is around the mean

## Percentiles

- p50 - Exactly 50% of the values lie above and below this value
- p95 - Exactly 95% of the values lie below this value.
- p99 - used for latency, outlier detection
- Example: if p95 delivery time = 45 minutes,
  95% of deliveries happen within 45 minutes

## Hypothesis Testing

- Null Hypothesis (H0): changes made have no effect
- Alternative Hypothesis (H1): changes made were effective
- In this testing, H0 (Null Hypothesis) is tried to be disproved; H1 (Alternative Hypothesis) is not tried to be proved

## p-value

- it tells what is the probability of changes having no effect.
- The smaller is its value, the less are the chances of null hypothesis being true
- p <= 0.05 then the results are statistically significant
- Remember that it does not tell that how big is the effect due to change and is it worth considering or not

## Type-1 Error: (False Positive) (False Alarm)

- You concluded that the change has an effect (alarm rung) but in actual there was no effect due to the change (in actual no alarm rang)
- Example: launching a feature that actually does not improve conversion

## Type-2 Error: (False Negative) (Missed Alarm)

- You found out that the change has no effect (alarm did not ring) while in actual there was an effect (alarm rang in actual)
- Example: killing a feature that would have helped

## Sample Size

- If the sample size is not big enough, the results cannot be trusted
- run the test (for collecting data) till the sample size is big enough
- Never stop a test too early if it looks good.
- This is called "Peeking." If you check the p-value every hour and stop as soon as it hits $0.05$, you are significantly increasing your Type-1 Error (False Positive) rate. You must wait until the pre-calculated Sample Size is reached.

## Minimum Detectable Effect (MDE)

- the smallest improvement that is "actually worth" for a business to take care of
- Example: If launching a new checkout button costs $100k in engineering time, a $0.1\%$ increase in conversion might be "statistically significant" ($p \le 0.05$) but it isn't practically significant because it doesn't cover the cost.

## Revision Table

Concept,Simple Definition,Business Stakeholder Version
Confidence Interval,"The range where the ""true"" effect likely sits.","""We are 95% sure the conversion increase is between 2% and 4%."""
MDE,"The ""threshold of caring.""","""Unless this change brings at least a 1% lift, it’s not worth the dev effort."""
Effect Size,The magnitude of the change.,"""The change was real, but it only moved the needle by a tiny amount."""

| Concept             | Simple Definition                              | Business Stakeholder Version                                                   |
| ------------------- | ---------------------------------------------- | ------------------------------------------------------------------------------ |
| Confidence Interval | The range where the "true" effect likely sits. | "We are 95% sure the conversion increase is between 2% and 4%."                |
| MDE                 | The "threshold of caring."                     | "Unless this change brings at least a 1% lift, it’s not worth the dev effort." |
| Effect Size         | The magnitude of the change.                   | "The change was real, but it only moved the needle by a tiny amount."          |

> In an interview, if they ask: "What happens to the P-value if we increase the sample size but keep the absolute number of conversions the same?"

> The Answer: "The P-value will increase (become less significant) because the effect size (the conversion rate) is actually shrinking as the denominator grows."

## Sample Size in A/B Testing

Variance: It tells us how much the overall data is spread out
Standard Deviation : It tells how much each individual value deviates from the average value of the complete set.

Too small sample = high variance = misleading results

Example:
10 users, 2 converted = 20%
10 users, 3 converted = 30%
That 10% difference means nothing — flip a coin 10 times,
you get wildly different results each time.

10,000 users, 2000 converted = 20%
10,000 users, 3000 converted = 30%
NOW the difference is meaningful.
Minimum Detectable Effect (MDE):
The smallest improvement worth detecting.
If your baseline is 5% and you only care about
improvements above 1% absolute — that is your MDE.

Python for sample size calculation:

```python
from statsmodels.stats.power import NormalIndPower

analysis = NormalIndPower()
n = analysis.solve_power(
    effect_size=0.2,  # small effect
    power=0.8,        # 80% chance of detecting real effect
    alpha=0.05        # 5% false positive rate
)
print(f"Sample size needed per group: {n:.0f}")
```

effect size - how much change you are expecting to see
power - it tells that if there is a real difference than what is the probability that you will successfully detect the change
alpha - this gives the tolerance, that is if probability of not detecting a change is below this value that you are fine with it.
