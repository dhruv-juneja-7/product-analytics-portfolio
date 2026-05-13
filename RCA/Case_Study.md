# Case Study 1

## Zomato's average rating for restaurants has dropped by 10% in Pune

### Questions

1. How do you measure average rating?
2. Is this trend seen from one week, one month or more than that?
3. Is it for people ordering online or having a dine-in option

Answers assumed -

Average Rating of one restaurant- Total Rating by all users / No. of users giving the rating

Average rating of all restaurants = Sum of avg rating of each restaurant / no. of restaurants

Time Assumption - Its for 2 weeks

1. Increase in number of restaurants without any rating
2. New restaurants are being given low rating in Pune
3. If dine-in then increase in waiting time in restaurant or not getting a table in specified time in restaurants.
4. Few restanurants with high rating have closed.
5. Increase in prices by restaurants due to a policy change in Zomato like demanding more margins from restaurants - very unlikely.

# Case Study 2

## Urban Company's service completion rate has fallen by 18% in Bengaluru

### Questions

> What?

How do you measure the service completion rate?
Possible answer - Completed Services / No. of bookings

> Does no. of bookings also include the cancelled bookings?

> Where

- Has i happened only in Bengaluru or in any other tier 1, tier 2 city.
- Is it for a particular type of service like cleaning, cooking, servicing of acs, installation/servicing of water filters
- Is it for a particular user segment or overall?

Possible answer - cancelled services are also considered in the denominators

- Mainly for repair services
- across multiple regions

> When

- Is the fall in service completion rate compared to last week or last month?

- Is there an increase in the number of cancellations? If yes how many days or hours before the schedule service they are cancelling the service?

Reasons

1. Data/Definition

- any chane in the metric definition or how the metrics are calculated?
- is the data pipeline broken
- any new sources have been added to dilute the metric?
- any recent migration of data ?
- dashboard refresh failures

Possible answer

- none of the above

2. Internal Reasons
   a. Product / Feature change

- has a new feature introduced in recent past that coincides with the fall observation?
- has new steps been introducted to the funnel in which a user books services at app or website
- has any discout or promotional offers ended recently
- any new hires for work that have reduced the quality of service and affected customer satisfaction

> Let me clarify the funnel steps - so is it like people open the app, choose the service, add to cart, schedule the timings, proceed to checkout -> make the payment.

b. Tech change

- has users reported bugs recently and are there a rise in support tickets recently?
- is there a change in UI that has introduced more steps or make it difficult to book services
- is the app rendering time same on the devices of the affected users
- any third party API failures
- is it particular to a specific platform - like ios or android or specific to an app version
- there is a different app used by the service providers as compared to the customers. Is there a UI or feature change in that app?

c. Operational changes

- has there been a reduction in the workforce that is the no. of people available to do service
- changes in SLA or arrival time
- recent change in customer support policy or recent rise in customer complaints related to quality of service

3. Market/ External effect

- Seasonality - is the season affecting it like in summers people have more repair requests for acs causing a mismatch in supply and demand
- has a new competitor entered the market offering the same services but at a lower price
- any negative media coverage?
- any natural disaster / calamity in the affected areas
- any government or regulatory changes?
- has there been a change in the training program causing less availaibility or hiring of new people?

Answers got - maily the services are reduced in the repairing service area of kitchen and electrical appliances. There has been a decrease in the availability of the electricians rececntly.
And there has been a new program that has been added to the training of the electricians.

Effect

- How big is the effect of this on revenue and customer retention etc.?

Validation

- No. of electricians avalilable to provide service before and after the fall is observed
- Category like kitchen and electrical appliances wise reduction in service completion rate
- Evaluating the reason for calculation to find the most common cause for cancellation

Short and long term fix

- onboard freelance electricians in Bengaluru immediately to plug the supply gap (increase supply)
- Triage bookings: prioritise simpler repairs that current electricians can handle; defer complex ones transparently
- Surge pricing or waitlist: manage demand until supply recovers (decrease demand)
- Partner with third-party electrician networks as backup supply

Monitoring

- no. of cancelled orders
- customer satisfaction for this particular segment
- of discounts are given then usage of those discount codes.
- service completion rate

# Case Study 3

## UpGrad's certification completion rate has decreased by 18% in Chennai

### Questions

- What: How do you calculate the certificate completion rate? is it no. of users who completed the certificate / no. of users who started the certificate

- Where: Is it for a specific city like Chennai or is it seen at other places as well?
- Is this for particular type of courses: like engineering, mba, art, english, ai, data science or others
- Is this for free or paid courses?
- Is this for free users or subscription based users or for all types of users?
- Specific platform - ios or android or website
- Is this for a specific college or university that is providing the course?
- Is this for new courses or old courses

- When: is it compared to last week or two weeks or compared to previous month

### Reasons:

1. Data/Definition

- Has there been a change in the way this metric is calculated?
- Is the data pipeline broken
- Is the dashboard working properly or are there any refresh failures
- is a new data source introduced which has diluted the metric
- any recent migration of data

2. Internal Factors

a. Product / Feature change

- Was a new feature introduced at the same time when this change is seen?
- Was there some discounts/promotions that were running on courses which have now ended
- is there a change in the funnel in which user enrolls for the course and completes it like introducing more steps and checks before enrolling or the way in which certification is completed?
- is there a rise in the prices of the course
- are new courses introduced that users start but lose interest as they proceed?

b. Tech change

- Any recent bug reported or a rise in support tickets from the customers?
- Any update roll out after which this change is seen
- is it specific to ios, android, website or a particular app version
- is the app rendering time consistent across all the users being considered
- Any third part API failures or any cause that has affected the app availability or performance

c. Operational changes

- is there a reduction in the courses listed on the platform which the users were enrolled in or reduction in the number of colleges offering the course
- are the courses regularly updated and relevant in present time
- any change in the customer support policy that have caused customer dissatisfaction

3. Marktet/External factore

- any negative media coverage recently
- any new competitor has launced in the market offering the same courses and services but for a less price
- any natural disaster or pandemic that may have resulted in this
- any change in regulatory or legal policies that may have caused it

### Received answers -

- fall is compared to last month
- it is for paid certificate
- specific to AI, Data Science and tech related courses
- specific to courses that saw a curiculum update in the last 6 weeks and to make courses more industry specific the length was increased
- users need to score 75% instead of 60% to receive the certificate
- there was a price increase in the courses last 5 weeks ago - 15-20% for tech courses
- users complained about the video buffering and loading time in live sessions and availability of recorded sessions afterwards
- API failures that affected a large batch of users from Chennai during a live course
- mentor support reduced from unlimited sessions to max of 4 per month per student
- new edtech platform in Tamil Nadu with similar course structure but with 40% less fees

### Effect -

- how it faffect the customer retention and revenue

### Timeline of events

- 8 weeks ago - edtech platform which is regional ( may be offering course in local language) started which offered similar courses
- curriculum update 6 weeks ago and its length was increased
- mentoring sessions were reduced from unlimited to max of 4 per student per month
- rise in course prices 5 weeks ago
- users need to score 75% instead of 60%
- over the last 4 weeks increase in tickets related to video buffering and availability of recorded lectures for live sessions
- 3 weeks ago - outage in chennai during a live session

### Hypothesis

- Given the incidents, the strongest cause seems to be increase in complexity and length of the certificate aligning with the reduction of mentor sessions per student. The students facing difficulty in understanding the new content but since support from mentors is limited so they are failing or not able to prepare for the exam
- As there has been increase in customer tickets related to buffering and availability of recorded videos it also makes things difficult for student to re-watch the videos to clear their doubts
- Also the increase in the scoring % is also signalling towards the above reason for not completing the certificates
- And the increase in prices of course makes it hard to re-attempt the certificate of someone fails
- The regional edtech platform is providing courses in regional languages and at a lower price which is in contrast to upgrad which is giving courses in limited languages and that too with higher price. This may have caused the students who started the course to migrate to regional platform without completing it. It may also have impacted the enrolment % of users in this course.

### Validation

- No. of people failing to complete the certificate before and after the curriculum was updated. This will tell that people are finding it difficult to complete the course
- Feedback from students who have completed the course - related to its increase in complexity and usefulness and price
- Enrolement % in the course before and after the launch of the regional edtech platform to analyse the effect of regional edtech platform
- Avg time and attempts taken by the student to complete the certificate before and after the curriculem was updated
- Avg time and attempts taken by the student to complete the certificate before and after the mentor support policy was changed

### Long term and short term fix -

Short term fix

- discount for student who want to re-attempt the course
- Fixing the app to provide the lecture recording within few minutes or hours after the live session has ended
- increasing the no. of session for mentor to not unlimited but say 2 per week along with hiring freelance mentors to take the doubts.
- Increase the doubt session time

Long term fix

- Mentors should also go through the certificate and new content who are taking the sessions. This will make them solve the doubts faster.
- availing the courses in regional languages in states like Tamil Nadu
- If the price of the course cannot be reduced then quality of the content should be way better than other edtech platforms and the users should be made aware about it

### Monitoring

- certificate completion rate
- certificate enrolment rate
- no. of attempts per user to complete the certificate
- no. of support tickets related to video buffering and availability

### Gaps -

1. Assumed that the competitor is providing the courses in regional languages which was not mentioned by the interviewer. Should have focused on that the competitor was providing flexible deadlines opposite to UpGrad's tough, lengthy course with a harder pass threshold

Fix - Upgrad need to give extra and sufficient time to complete the updated course

2. Android specific issue - the video buffering and recording problem was specific to android and it could be fixed with a simple patch with in 1-2 weeks

Fix - a simple patch in android devices is possible by rolling out an update. It will have the highest impact with the easiest fix.

3. Ignored the 4-hour outage at Chennai live sessions - this may have caused the users to stay behind the content and made it hard for them to understand what's going on in the course

Fix - the affected students should be given extra mentor sessions

4. Not considered the mid-course users - Users who were exposed to new course content and an increase in threshold in the on-going course

Fix - keep the threshold same for them at 60% and also provide them unlimited mentor sessions till they complete

5. Monitoring metrics need improvement

- Pass rate on final assessment (did it drop after 75% rule implementation)
- Mentor utilization rate
- Drop-off rate by course module
- churn to competitor: surveys to check users lose to the competitors
- android specific buffering rate

## LESSON

The One Pattern to Break
In all three cases you stop at the first correct cause and don't ask what caused that cause.

Case 2: "Fewer electricians available"
→ should have asked: why are there fewer?

Case 3: "Curriculum is harder + mentors reduced"
→ should have asked: who is most hurt by this?
→ answer: mid-course students, not just new ones

> Before closing any root cause, ask: "Who specifically does this hit hardest, and does that group have a way out?" That question would have found the mid-course student problem immediately.

# Case Study 4

## Tata Cliq's website bounce rate has increased by 25%

### Questions

1. Is bounce rate defined as no. of people who left after visiting single page / total no. of people visiting the website
2. Is this increase seen in a particular region or city or across all cities?
3. Is it same on every platform - ios and android?
4. Is this compared to previous month or previous weeks.
5. Is this for a particular type of page which is related to electronics, fashion, women wear, men wear etc.
6. Is this particularly for new users or even for existing customers
7. what is the average time spend by the bounced customers on the website.

### Data/Definition

1. Has the metric calculation changed or there is a change in its definition?
2. Is the data pipeline broken?
3. Has there been a refresh failure
4. Are there any new data sources that may have diluted the metric
5. has there been a recent data migration
6. What is the source of the customers for maximum bounce rate is observed.

### Internal Reasons

a. Product/Feature changes

- Did a new feature was introduced which may have caused this coinciding with the time of this increase.
- Has new products or new category been listed for which this bounce rate is seen
- Are there any items that have been continuously out of stock or not available since the bounce rate rose.
- Have any products or categories been removed from the website
- has a discount or promotion campaign recently added
- has there an increase in queries related to particular product/category

b. Tech change

- has there been an unresolved bug on the website or is there a rise in the support tickets related to any functional issue
- is this same for all platforms - ios and android
- is the loading time and rendering time same on all devices of the bouced users
- has there been a ui change making it difficult to find the product/adding it to cart.
- has there been a third party api failure.
- any server or data migrations done.

c. Operational changes

- has there been a increase in the listed product prices
- is there been a rise in returned or cancelled orders
- is there any increase in the ang delivery time

### External Reasons/Market

- Does any new competitor launched in the area in same domain offering products at lower prices
- is there any negative media coverage
- any regulatory changes or legal changes at the same time
- any natural calamity happened in the affected area
- any change in the custome support policy or return/cancellation policy

### Answers Received

- observed over the past week compared to the week before that.
- competitors are running a campaign as it is the end of the year (didn't ask any specific question for it)
- ui change- banners on the home page and a pop-up on the landing pages.- introduced around a week back.
- increase in bounce rate is consistently linked to mobile web users.
- the positioning of the pop-up on mobile devices hides the close button, making it difficult for users to close it. (didn't ask this question specifically)

### Validation

- compare bounce rate for mobile web users vs app users, website users on laptops, computers
- rise in support tickets or queries related to pop-up shown on mobile web
- click on the pop-up for the users for which bounce rate is observed so if it is higher than other platform users it means the user are trying to close the pop-up but are not able to do so.
- no. of page refreshes/reloads for these users
- avg time spend on the landing page if it is increase for the impacted users it is a signal that they are facing some issue on the page

### Fixes

1. Short Term Fix

- fix the pop-up issue on the landing page, it is a simple ui change on the frontend

2. Long term fix

- always do A/B test before rolling out any UI/UX change

Monitoring

- Bounce rate after the fix especially for the mobile web users.
- CTR - click through rate - if it is increased then users are engaging with the platform
- avg time spend by user per session and no. of sessions per user.

### Better Fixes

1. Short Term Fix

YOUR FIX:
"Fix the pop-up — simple frontend change"

STRUCTURED FIX:
WHO: Mobile web users on landing pages
WHAT: Two immediate options —
Option A (fastest, 2-4 hours): Roll back the
pop-up entirely until mobile web version is fixed
Option B (1-2 days): Push a hotfix that ensures
close button is visible at all screen sizes
and positions (use fixed positioning, not absolute)
WHY: Every hour the pop-up remains live = continued
bounce rate damage + lost conversion revenue
HOW FAST: Rollback can be done in hours. Hotfix in 1-2 days.
Start with rollback, then deploy fix, then re-enable.

2. Long Term Fix

GENERIC (what you wrote):
"Always A/B test before UI changes"

SPECIFIC (what a senior analyst says):
"Implement a mobile-first QA checklist for all UI changes
that includes: rendering check on 5 most common mobile
screen sizes, interactive element accessibility audit,
pop-up/modal close button visibility at all breakpoints.
No UI change ships to production without this sign-off."
