/* 

Salary Analysis:
   - Analyze salary ranges.
   - Compare salaries based skills. */


WITH highest_paid_skills AS (
SELECT     
    job_postings_fact.job_id,
    job_title_short,
    job_country,
    salary_year_avg,
    skills_dim.skill_id,
    skills
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
)


SELECT 
    skills,
    ROUND(AVG(salary_year_avg),0) as salary_avg
FROM 
    highest_paid_skills
WHERE 
    skill_id IS NOT NULL AND
    salary_year_avg IS NOT NULL AND
    job_title_short = 'Data Analyst' 
GROUP BY 
    skills
ORDER BY salary_avg DESC
LIMIT 10;



-- Italy Scenario:

WITH highest_paid_skills AS (
SELECT     
    job_postings_fact.job_id,
    job_title_short,
    job_country,
    salary_year_avg,
    skills_dim.skill_id,
    skills
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
)


SELECT 
    skills,
    ROUND(AVG(salary_year_avg),0) as salary_avg
FROM 
    highest_paid_skills
WHERE 
    skill_id IS NOT NULL AND
    salary_year_avg IS NOT NULL AND
    job_title_short = 'Data Analyst' AND
    job_country = 'Italy'
GROUP BY 
    skills
ORDER BY salary_avg DESC
LIMIT 10;





-- Analyze salary ranges by role:


--Global Scenario:
SELECT	
	job_id,
	job_title,
	salary_year_avg
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst' AND 
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10;

-- Italy Scenario:
SELECT	
	job_id,
	job_title,
	salary_year_avg
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst' AND 
    salary_year_avg IS NOT NULL AND
    job_country = 'Italy'
ORDER BY
    salary_year_avg DESC
LIMIT 10;


-- Data Analysts Roles:

SELECT	
	job_title,
    COUNT(*) AS count_data_analysts
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst' AND 
    salary_year_avg IS NOT NULL 
GROUP BY
    job_title
ORDER BY
    count_data_analysts DESC
LIMIT 10;