
/* 
Find the count of the number of remote job postings per skil
- display the top 5 skills by their demand in remote jobs
- include skill id, name, and count of postings requiring the skill
 */

SELECT
  job_id,
  skill_id
FROM
  skills_job_dim AS skills_to_job