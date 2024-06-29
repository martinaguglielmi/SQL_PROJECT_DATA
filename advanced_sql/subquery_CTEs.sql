

/* From the job_postings_fact table
I'm considering only jobs where no degree is needed */

SELECT
  job_title_short,
  company_dim.company_id
  company_name,
  job_location,
  job_no_degree_mention
FROM job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
  job_no_degree_mention = TRUE

/* Need to find the names of the companies
Companies' names are in another table: company_dim

subquery run first and then the primairy one. */

SELECT  name AS company_name
FROM company_dim
WHERE company_id IN ( 
    SELECT
      company_id
    FROM 
      job_postings_fact
    WHERE
      job_no_degree_mention = TRUE

)



/* 
Find the companies that have the most job openings.
-Get total number of job postings per company id
-Return the total number of jobs with the company names
*/

WITH company_job_count AS (
SELECT
  company_id,
  COUNT(*) AS total_jobs
FROM
  job_postings_fact
GROUP BY
  company_id
)

SELECT name, total_jobs
FROM company_dim
LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id