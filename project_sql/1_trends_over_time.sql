/*

Trends Over Time:
   - Examine the distribution of job offers by month.
   - Identify periods with spikes or drops in job postings.


What time frame does the job_posting_fact dataset cover according to the 'posted_date' field?

*/

SELECT 
  MIN(job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST') AS earliest_date,
  MAX(job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST') AS latest_date
FROM job_postings_fact;

/*
Earliest Date: 31st December 2022
Latest Date: 31st December 2023

 

Distribution of job offers by month:
Let's focus the analysis exclusively on 'Data Analyst' positions throughout the year 2023.


GLOBAL SCENARIO

*/

-- Quarter Distribution:

SELECT 
    job_title_short,
    EXTRACT(YEAR FROM job_posted_date) AS Year,
    CASE 
      WHEN EXTRACT(MONTH FROM job_posted_date) > 9 THEN 'Q4'
      WHEN EXTRACT(MONTH FROM job_posted_date) < 4 THEN 'Q1'
      WHEN EXTRACT(MONTH FROM job_posted_date) >= 4 AND EXTRACT(MONTH FROM job_posted_date) <= 6 THEN 'Q2'
      ELSE 'Q3'
    END AS Quarters,
    COUNT (job_id) AS job_count
FROM 
    job_postings_fact
WHERE 
    EXTRACT(YEAR FROM job_posted_date) <> 2022 AND
    job_title_short = 'Data Analyst'
GROUP BY 
    Year, 
    Quarters, 
    job_title_short
ORDER BY 
    job_count DESC; 

-- Monthly Distribution:

SELECT 
    job_title_short,
    EXTRACT(YEAR FROM job_posted_date) AS Year,
    TO_CHAR(job_posted_date, 'Month') AS Month,
    COUNT (job_id) AS job_count
FROM 
    job_postings_fact
WHERE 
    EXTRACT(YEAR FROM job_posted_date) <> 2022 AND
    job_title_short = 'Data Analyst'
GROUP BY 
    Year, 
    Month, 
    job_title_short
ORDER BY 
    job_count DESC; 



/*
ITALY SCENARIO
*/

-- Quarter Distribution:

SELECT 
    job_title_short,
    EXTRACT(YEAR FROM job_posted_date) AS Year,
    CASE 
      WHEN EXTRACT(MONTH FROM job_posted_date) > 9 THEN 'Q4'
      WHEN EXTRACT(MONTH FROM job_posted_date) < 4 THEN 'Q1'
      WHEN EXTRACT(MONTH FROM job_posted_date) >= 4 AND EXTRACT(MONTH FROM job_posted_date) <= 6 THEN 'Q2'
      ELSE 'Q3'
    END AS Quarters,
    COUNT (job_id) AS job_count
FROM 
    job_postings_fact
WHERE 
    EXTRACT(YEAR FROM job_posted_date) <> 2022 AND
    job_title_short = 'Data Analyst' AND
    job_country = 'Italy'
GROUP BY 
    Year, 
    Quarters, 
    job_title_short
ORDER BY 
    job_count DESC; 

-- Monthly Distribution:
SELECT 
    job_title_short,
    EXTRACT(YEAR FROM job_posted_date) AS Year,
    TO_CHAR(job_posted_date, 'Month') AS Month,
    COUNT (job_id) AS job_count
FROM 
    job_postings_fact
WHERE 
    EXTRACT(YEAR FROM job_posted_date) <> 2022 AND
    job_title_short = 'Data Analyst' AND 
    job_country = 'Italy'
GROUP BY 
    Year, 
    Month, 
    job_title_short
ORDER BY 
    job_count DESC;

/* 
GLOBAL RANKING: January - August - February  /  Q1 - Q3 - Q4 - Q2
ITALY RANKING: August - July - June   /  Q3 - Q4 - Q1 - Q2
/*






























/*

 2) What is the distribution of contract types (full-time, part-time, contract, freelance, internship) for a Data Analyst position?
*/

SELECT
    job_title_short,
    job_schedule_type,
    COUNT(*) AS job_count
FROM
    job_postings_fact
WHERE 
    job_title_short = 'Data Analyst' AND
    job_schedule_type IS NOT NULL
GROUP BY
    job_schedule_type, 
    job_title_short
ORDER BY
    job_count DESC
LIMIT 10;


-- Work from home vs no work from home available 97% vs 3%
-- GLOBAL SCENARIO

SELECT
    job_title_short,
    job_work_from_home,
    COUNT(*) AS job_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 0) AS job_percentage
FROM
    job_postings_fact
WHERE 
    job_title_short = 'Data Analyst'
GROUP BY 
    job_work_from_home,
    job_title_short
ORDER BY
    job_count DESC

-- ITALY  96% vs 4%

SELECT
    job_title_short,
    job_work_from_home,
    COUNT(*) AS job_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 0) AS job_percentage
FROM
    job_postings_fact
WHERE 
    job_title_short = 'Data Analyst' AND
    job_country = 'Italy'
GROUP BY 
    job_work_from_home,
    job_title_short
ORDER BY
    job_count DESC
    


SELECT
    job_title_short,
    job_country,
    job_work_from_home,
    COUNT(*) AS job_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 0) AS job_percentage
FROM
    job_postings_fact
WHERE 
    job_title_short = 'Data Analyst' AND
    job_work_from_home = TRUE
GROUP BY 
    job_work_from_home,
    job_title_short,
    job_country
ORDER BY
    job_count DESC
LIMIT 10;


SELECT
    job_title_short,
    job_country,
    SUM(CASE WHEN job_work_from_home = TRUE 
         THEN 1 
         ELSE 0 
         END) AS job_count_work_from_home,
    SUM(CASE WHEN job_work_from_home = FALSE 
         THEN 1 
         ELSE 0 
         END) AS job_count_no_work_from_home,
    COUNT(*) AS job_count,
    SUM(CASE WHEN job_work_from_home = TRUE 
         THEN 1 
         ELSE 0 
         END)*100/ COUNT(*) AS no_work_from_home_percentage,
    SUM(CASE WHEN job_work_from_home = FALSE
         THEN 1 
         ELSE 0 
         END)*100/ COUNT(*) AS work_from_home_percentage
   -- job_count_work_from_home / job_count AS work_from_home_percentage
FROM
    job_postings_fact
WHERE 
    job_title_short = 'Data Analyst'
GROUP BY 
    job_title_short,
    job_country
ORDER BY
    job_count DESC
LIMIT 10;
