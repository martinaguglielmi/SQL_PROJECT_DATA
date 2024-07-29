
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

From now on, to all the queries, the **following condition**  is going to be applied for assessing the Italian Market:

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

Global:

| Job Title    | Job Schedule Type     | Job Count |
|--------------|-----------------------|-----------|
| Data Analyst | Full-time             | 169,471   |
| Data Analyst | Contractor            | 10,022    |
| Data Analyst | Internship            | 3,305     |
| Data Analyst | Part-time             | 3,195     |
| Data Analyst | Full-time and Part-time | 1,583    |

Italy:

| Job Title    | Job Schedule Type         | Job Count |
|--------------|---------------------------|-----------|
| Data Analyst | Full-time                 | 3,961     |
| Data Analyst | Internship                | 144       |
| Data Analyst | Full-time and Temp work   | 122       |
| Data Analyst | Temp work                 | 62        |
| Data Analyst | Full-time and Internship  | 53        |

### **Insights**:

- **Full-time** positions dominate **both tables**, with slightly higher importance in the Italian market.
- **Internship** positions are more significant in Italy, ranking higher.
- Italy's overview shows a greater variety of **combined and specialized job** schedules with higher relative importance.
- Globally, there is a significant percentage of **contractor** positions, which do not make the top 5 in Italy.

### 3. Remote Work:
   - What is the proportion of remote Data Analyst job offers compared to on-site ones?

```sql
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

```

| Job Title    | Work From Home | Global Job Count | Italy Job Count | Global Job % | Italy Job % |
|--------------|----------------|------------------|-----------------|--------------|-------------|
| Data Analyst | No             | 183,262          | 4,408           | 93%          | 96%         |
| Data Analyst | Yes            | 13,331           | 162             | 7%           | 4%          |


### **Insights**:

- Non-WFH Positions dominate in both datasets.
- Non-WFH positions make up the vast majority of Data Analyst roles, having an even higher proportion in Italy.
- **Equal Trend**

### 4. In-Demand Skills:
   - Examine the distribution of the most required skills for Data Analyst positions.
   - Italy vs Global Trends.

```sql
WITH skills_count AS (
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
    skills_count
WHERE 
    job_title_short = 'Data Analyst'
GROUP BY 
    skills
ORDER BY skills_requested DESC
LIMIT 10;
```

Global:

| Skill       | Skills Requested |
|-------------|------------------|
| SQL         | 92628            |
| Excel       | 67031            |
| Python      | 57326            |
| Tableau     | 46554            |
| Power BI    | 39468            |
| R           | 30075            |
| SAS         | 28068            |
| PowerPoint  | 13848            |
| Word        | 13591            |
| SAP         | 11297            |

Italy:

| Skill    | Skills Requested |
|----------|------------------|
| Excel    | 1730             |
| SQL      | 1346             |
| Python   | 1000             |
| Power BI | 657              |
| Tableau  | 578              |
| SAS      | 576              |
| R        | 503              |
| GDPR     | 380              |
| SAP      | 356              |
| Qlik     | 247              |

### **Insights**:

- **Top 3 Skills**: 
Both have **SQL, Excel,** and **Python** in the top 3, but their order is different. 
Excel is the top skill in Italy, while SQL is the top skill globally.
- **Data Visualization**:
**Power BI** and **Tableau**, these two tools are ranked 4th and 5th, respectively, in both datasets, though their positions are swapped. Highlighting that data visualization is a critical skill for Data Analysts.
- **Programming Languages**:
**SAS** and **R**, These two skills appear in the 6th and 7th positions in both datasets, though their order is swapped.


- **Common Skills**: SQL, Excel, Python, Power BI, Tableau, SAS, R, and SAP are common to both datasets' top 10 lists.
- **Unique Skills**: PowerPoint and Word appear in the Global top 10 but not in Italy. GDPR and Qlik appear in Italy's top 10 instead.

- **Equal Trend**


## **Ranking:**

| Rank | Global | Italy |
|------|----------------|---------------|
| 1    | SQL           | Excel         |            
| 2    | Excel          | SQL           |           
| 3    | Python         | Python        |            
| 4    | Tableau        | Power BI      | 
| 5    | Power BI       | Tableau       |  
| 6    | R              | SAS           |  
| 7    | SAS            | R             |
| 8    | **PowerPoint**    | **GDPR**          | 
| 9    | **Word**           | SAP           |
| 10   | SAP            | **Qlik**          |

### 5. Most Optimal Skills:
   - Compare salaries based on skills.
   - Analyze salary ranges for different roles.


1. Skills 

```sql
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
```

Global: 

| Skill      | Average Salary |
|------------|----------------|
| SVN        | $400,000       |
| Solidity   | $179,000       |
| Couchbase  | $160,515       |
| DataRobot  | $155,486       |
| Go (Golang)| $155,000       |
| MXNet      | $149,000       |
| dplyr      | $147,633       |
| VMware     | $147,500       |
| Terraform  | $146,734       |
| Twilio     | $138,500       |

Italy:

| Skill   | Average Salary |
|---------|----------------|
| SAP     | $111,175       |
| Looker  | $102,500       |
| Azure   | $102,500       |
| AWS     | $102,500       |
| Crystal | $100,500       |
| Qlik    | $100,500       |
| R       | $97,367        |
| Flow    | $89,100        |
| SQL     | $87,865        |
| Oracle  | $84,338        |

**Insights:**

- There are **no overlapping** skills between the two tables, meaning each table contains entirely top 10 different skill sets.
- Global's table features higher-paying skills with an emphasis on technologies related to **development, data science, and cloud services**.
- Italy's table contains skills that are commonly associated with **business intelligence, database management, and analytics tools**, but with generally lower average salaries.
- **Not Equal Trend**

2. Roles

```sql
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
LIMIT 5;
```
Global:

| job_id  | job_title                                                       | salary_year_avg |
|---------|-----------------------------------------------------------------|------------------|
| 226942  | Data Analyst                                                    | 650000         |
| 209315  | Data Base Administrator                                         | 400000         |
| 1110602 | HC Data Analyst, Senior                                        | 375000       |
| 1147675 | Sr Data Analyst                                                | 375000        |
| 641501  | Head of Infrastructure Management & Data Analytics - Financial | 375000       |


Italy:

| job_id  | job_title                                                       | salary_year_avg |
|---------|-----------------------------------------------------------------|------------------|
| 245409  | SAP Data Analyst                                                | 111175           |
| 156658  | Data Analyst                                                    | 102500           |
| 834533  | Data Analyst - Product Team                                     | 102500           |
| 805174  | Data Analyst                                                    | 100500           |
| 1578032 | NLP Expert (Natural Language Processing)                        | 89100            |

**Insights:**

- **Global Salaries**: The average salaries in the Global table are significantly higher, ranging from $375,000 to $650,000. This reflects the higher level of responsibility and seniority of the roles listed.
- **Italy Salaries**: The salaries in the Italy table are lower, ranging from $89,100 to $111,175. This may indicate a different market or economic trend in Italy or reflect the lower level of seniority in the positions listed.
- **Not Equal Trend**


Data Analysts Roles:

```sql
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
```

# What I Learned

# Conclusion

