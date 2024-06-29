
SELECT
  COUNT(job_id) as number_of_jobs,
  CASE
    WHEN job_location = 'Anywhere' THEN 'Remote'
    WHEN job_location = 'New York, NY' THEN 'Local'
    ELSE 'Onsite'
  END AS location_category
FROM 
  job_postings_fact
WHERE
  job_title_short = 'Data Analyst'
GROUP BY 
  location_category



/* categorize salaries from each job posting.
salary into different buckets
define high - low
data analyst roles
order from highest to lowest */


-- 38.15 AVG HOUR SALARY

SELECT 
  job_id,
  job_location,
  job_posted_date,
  salary_hour_avg,
   CASE
     WHEN salary_hour_avg < 38.15 THEN 'Low'
     ELSE 'High'
     END AS category_avg_salary
FROM
  job_postings_fact
WHERE
  job_title_short = 'Data Analyst'
  AND salary_hour_avg IS NOT NULL
ORDER BY
  salary_hour_avg DESC