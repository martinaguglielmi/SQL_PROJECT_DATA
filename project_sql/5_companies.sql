/*

Company Analysis:
   - Identify companies with the most job postings.*/

SELECT 
    job_postings_fact.company_id,
    company_dim.name,
    job_title_short,
    COUNT(*) AS counts
FROM 
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE 
    job_title_short = 'Data Analyst'AND
    name != 'Confidenziale'
GROUP BY
    job_postings_fact.company_id,
    job_title_short,
    name
ORDER BY counts DESC
LIMIT 10;


SELECT 
    job_postings_fact.company_id,
    company_dim.name,
    job_title_short,
    COUNT(*) AS counts
FROM 
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE 
    job_title_short = 'Data Analyst' AND
    job_country = 'Italy' AND
    name != 'Confidenziale'
GROUP BY
    job_postings_fact.company_id,
    job_title_short,
    name
ORDER BY counts DESC
LIMIT 10;




