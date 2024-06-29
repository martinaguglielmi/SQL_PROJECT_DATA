SELECT 
  job_title_short as title,
  job_location as location,
  job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' as date,
  EXTRACT(MONTH FROM job_posted_date) as month,
  EXTRACT(YEAR FROM job_posted_date ) as year
FROM 
  job_postings_fact
LIMIT 5;


--- Need to find how to transform a month number to a month name