
# Introduction

### **The Data Job Landscape:** Italy vs Global Scenario 🌍 

📊 This project provides a detailed analysis of the current job market, mainly targeting **Data Analyst** roles. It highlights essential skills and qualifications for standing out. The goal is to examine both the Italian job market and global trends to uncover differences in contract types, remote work availability, most requested skills, skills that yield the highest salaries and the timing trends of when job offers are most commonly posted. 

📌 *Do you think there could be **significant** differences?*

🔗 SQL Queries? Here's the link: [project_queries](/project_sql/)

# Background

This project was born out of a desire to learn and improve SQL skills. Using the database provided by Luke, I conducted a deep analysis of the global job market for data analysts and its unique characteristics. Each feature has been assessed at both the Italian and global levels.

**Research Questions:**

1. Which are the periods with spikes or drops in job postings?
2. What is the distribution of contract types for a Data Analyst position?
3. What is the proportion of remote Data Analyst job offers compared to on-site ones?
4. What skills are most in demand for Data Analysts?
5. Which skills are associated with higher salaries?

### Sources:

- **Data Source:** [SQL Course](https://lukebarousse.com/sql)
- **YouTube:** [Video](https://www.youtube.com/watch?v=7mz73uXD9DA)

### Biggest shout-out ever to Luke & Kelly, this course is a gem! 💥

- **Luke's Linkedin** [Luke Barousse](https://www.linkedin.com/in/luke-b/)
- **Kelly's Linkedin:** [Kelly Adams](https://www.linkedin.com/in/kellyjianadams/)


# Tool Used 
- **SQL:** Used to manage, manipulate, query the database and unearth critical insights.
- **PostgreSQL:** The chosen database management system.
- **Visual Studio Code:** Database management and execution of SQL queries.
- **Git & GitHub:** Essential for version control and sharing my SQL scripts and analysis.

# Analysis

### 1. Trends Over Time:
   - Examine the distribution of job offers by quarter and month.
   - Identify periods with spikes or drops in job postings.


**Quarterly Distribution:**

```sql
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
```
**Monthly Distribution:**
```sql
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
```

From now on, to all the queries the **following condition**  is going to be applied for assessing the Italian Market:

```sql
WHERE job_country = 'Italy'
```
### 2. Contract Types:
   - Compare the prevalence of different contract types (full-time, part-time, contract, freelance, internship).
   - Analyze trends in contract types in Italy compared to global trends.

```sql
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
```

**Insights**:

- **Full-time** positions dominate **both tables**, with slightly higher importance in the Italian market.
- **Internship** positions are more significant in Italy, ranking higher.
- Italy's overview shows a greater variety of **combined and specialized job** schedules with higher relative importance.
- Globally, there is a significant percentage of **contractor** positions, which do not make the top 5 in Italy.


### Global :

| Job Title    | Job Schedule Type     | Job Count |
|--------------|-----------------------|-----------|
| Data Analyst | Full-time             | 169,471   |
| Data Analyst | Contractor            | 10,022    |
| Data Analyst | Internship            | 3,305     |
| Data Analyst | Part-time             | 3,195     |
| Data Analyst | Full-time and Part-time | 1,583    |

### Italy :

| Job Title    | Job Schedule Type         | Job Count |
|--------------|---------------------------|-----------|
| Data Analyst | Full-time                 | 3,961     |
| Data Analyst | Internship                | 144       |
| Data Analyst | Full-time and Temp work   | 122       |
| Data Analyst | Temp work                 | 62        |
| Data Analyst | Full-time and Internship  | 53        |

### 3. Remote Work:
   - What is the proportion of remote Data Analyst job offers compared to on-site ones?
   - How do remote work trends for Data Analyst roles vary by contract type?

### 4. Skill Requirements:
   - Examine the distribution of required skills for Data Analyst positions.
   - Italy vs Global Trends.

### 5. Salary Analysis:
   - Analyze salary ranges for different roles and regions.
   - Compare salaries based on contract types and required skills.

# What I Learned

# Conclusion

