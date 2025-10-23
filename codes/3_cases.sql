WITH remote_jobs AS (
SELECT job_id, job_title_short, job_location
FROM job_postings_fact
WHERE job_location LIKE '%Morocco%' AND job_title_short LIKE '%Analyst%'
)

SELECT skills_dim.skill_id, skills_dim.skills, COUNT(remote_jobs.job_id) AS remote_job_count
FROM skills_dim
LEFT JOIN skills_job_dim ON skills_job_dim.skill_id = skills_dim.skill_id
INNER JOIN remote_jobs ON remote_jobs.job_id = skills_job_dim.job_id
GROUP BY skills_dim.skill_id
ORDER BY remote_job_count DESC
-- LIMIT 5;

SELECT DISTINCT company_dim.name AS company_name, job_postings_fact.job_title_short, job_postings_fact.job_via, job_postings_fact.salary_year_avg
FROM job_postings_fact
LEFT JOIN company_dim ON company_dim.company_id = job_postings_fact.company_id
WHERE job_location LIKE '%Morocco%'

SELECT DISTINCT company_dim.name AS company_name
FROM job_postings_fact
LEFT JOIN company_dim ON company_dim.company_id = job_postings_fact.company_id
WHERE job_location LIKE '%Morocco%'
  AND company_dim.name IS NOT NULL;

SELECT DISTINCT company_dim.name AS company_name
FROM job_postings_fact
LEFT JOIN company_dim ON company_dim.company_id = job_postings_fact.company_id
WHERE job_location = 'Anywhere' 
    AND job_work_from_home = TRUE
    AND company_dim.name IS NOT NULL
    AND job_title_short ILIKE '%Analyst%';


SELECT *
FROM company_dim
LIMIT 10;