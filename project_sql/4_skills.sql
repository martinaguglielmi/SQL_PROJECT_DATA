/*

Skill Requirements:
   - Examine the distribution of required skills for Data Analyst positions
   - Italy vs Global Trends
   - Salary and skills comparison


 */

-- Global Scenario:

WITH job_info AS (
SELECT     
    job_postings_fact.job_id,
    job_title_short,
    job_country,
    salary_year_avg,
    skills
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
)

SELECT 
    skills,
    COUNT(*) as skills_requested
FROM 
    job_info
WHERE 
    job_title_short = 'Data Analyst'
GROUP BY 
    skills
ORDER BY skills_requested DESC
LIMIT 10;



-- Italy Scenario:

WITH job_info AS (
SELECT     
    job_postings_fact.job_id,
    job_title_short,
    job_country,
    salary_year_avg,
    skills
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
)


SELECT 
    skills,
    COUNT(*) as skills_requested
FROM 
    job_info
WHERE 
    job_title_short = 'Data Analyst' AND
    job_country = 'Italy'
GROUP BY 
    skills
ORDER BY skills_requested DESC
LIMIT 10;

-- GLOBAL: SQL, EXCEL, PYTHON, TABLEAU, POWERBI
-- ITALY:  EXCEL, SQL, PYTHON, POWERBI, TABLEAU


/*  
Salary and skills comparison:
   - Which skills pay out the most ? */

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

