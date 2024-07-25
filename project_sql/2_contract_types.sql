/*

Contract Types:
   - Compare the prevalence of different contract types (full-time, part-time, contract, freelance, internship).
   - Analyze trends in contract types in Italy compared to global trends.

What is the distribution of contract types (full-time, part-time, contract, freelance, internship) for a Data Analyst position?

GLOBAL SCENARIO
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
LIMIT 5;

/*
ITALY SCENARIO
*/

SELECT
    job_title_short,
    job_schedule_type,
    COUNT(*) AS job_count
FROM
    job_postings_fact
WHERE 
    job_title_short = 'Data Analyst' AND
    job_schedule_type IS NOT NULL AND
    job_country = 'Italy'
GROUP BY
    job_schedule_type, 
    job_title_short
ORDER BY
    job_count DESC
LIMIT 5;

/* 
GLOBAL RANKING: Full-Time, Contractor, Internship
ITALY RANKING: Full-Time, Internship, Full-Time & Temporary Work
/*