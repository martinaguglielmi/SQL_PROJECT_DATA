/* 

Salary Analysis:
   - Analyze salary ranges for different roles, regions, and companies.
   - Compare salaries based on contract types and required skills. */

SELECT
    job_title_short,
    job_country,
    job_schedule_type,
    ROUND(salary_year_avg,0) AS salary_avg
FROM
    job_postings_fact
WHERE
    salary_year_avg IS NOT NULL
/*GROUP BY
    job_title_short,
    job_country,
    job_schedule_type */
ORDER BY
    salary_avg DESC
LIMIT 10;

-- 80% of the 10 highest paid offers from US
-- 1st: 960k 10th: 450k (10th highest offer is almost half of the 1st one)

SELECT
    job_title_short,
    job_country,
    job_schedule_type,
    job_work_from_home,
    ROUND(salary_year_avg,0) AS salary_avg
FROM
    job_postings_fact
WHERE
    salary_year_avg IS NOT NULL AND
    job_country = 'Italy'
ORDER BY
    salary_avg DESC
LIMIT 10;




SELECT
    job_title_short,
    job_postings_fact.job_id,
    job_country,
    job_schedule_type,
    job_work_from_home,
    skills_dim.skill_id,
    skills_dim.skills,
    ROUND(salary_year_avg,0) AS salary_avg
FROM
    job_postings_fact
LEFT JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
LEFT JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    salary_year_avg IS NOT NULL AND
    job_country = 'Italy'
ORDER BY
    salary_avg DESC
LIMIT 30;

-- 1st: 158k 10th: 111k


