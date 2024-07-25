/*

Remote Work:
   - What is the proportion of remote Data Analyst job offers compared to on-site ones?
   - How do remote work trends for Data Analyst roles vary by contract type?

GLOBAL SCENARIO
*/


-- Work from home vs on site 97% vs 3%


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
    job_work_from_home,
    job_schedule_type,
    COUNT(*) AS job_count
FROM
    job_postings_fact
WHERE 
    job_title_short = 'Data Analyst' 
GROUP BY 
    job_work_from_home,
    job_title_short,
    job_schedule_type
ORDER BY
    job_count DESC
LIMIT 10;


