-- January
CREATE TABLE january_jobs AS
  SELECT *
  FROM job_postings_fact
  WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

-- February
CREATE TABLE february_jobs AS
  SELECT *
  FROM job_postings_fact
  WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

-- March
CREATE TABLE march_jobs AS
  SELECT *
  FROM job_postings_fact
  WHERE EXTRACT(MONTH FROM job_posted_date) = 3;


select job_posted_date
from march_jobs

-- SUBQUERIES & CTES

/* 

SUBQUERIES: SELECT, FROM, WHERE, HAVING clauses.

query within a query

SELECT *
FROM ( -- Subquery starts here
  SELECT *
  FROM job_postings_fact
  WHERE EXTRACT(MONTH FROM job_posted_date) = 1
) AS january_jobs;

-- Subquery ends here

*/

---------------------------------------------------  SUBQUERY:

SELECT *
FROM ( -- Subquery starts here
  SELECT *
  FROM job_postings_fact
  WHERE EXTRACT(MONTH FROM job_posted_date) = 1
) AS january_jobs; -- Subquery ends here

/*
CTES: SELECT, INSERT, UPDATE, DELETE -- WITH
Common Table Expressions, define a temporary result set that you can reference

WITH january_jobs AS ( -- CTE definition starts here
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
)  -- CTE definition ends here

*/

---------------------------------------------------  CTEs:

WITH january_jobs AS ( -- CTE definition starts here
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
)  -- CTE definition ends here

SELECT *
FROM january_jobs;