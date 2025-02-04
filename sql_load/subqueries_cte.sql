SELECT *
FROM ( -- sub queries start here
    SELECT *
    FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1
) AS january_jobs;  -- ends here 


SELECT *
from job_postings_fact
LIMIT 10




SELECT
    company_id,
    name AS company_names 
FROM
    company_dim
WHERE
    company_id IN( -- sub queries start 
SELECT
    company_id
from
    job_postings_fact
WHERE
    job_no_degree_mention = True
    )

/*Find companies that have the most job openings.
- Get the total number of job posting per company id (job_posting_fact)
- Return the total number of job with the company name (company_dim)
*/

WITH company_job_count AS (
SELECT
    count(*) AS total_jobs, 
    company_id
FROM
    job_postings_fact
GROUP BY
    company_id
)
SELECT 
    company_dim.name,
    company_job_count.total_jobs
FROM 
    company_dim
LEFT JOIN company_job_count 
ON company_job_count.company_id = company_dim.company_id
ORDER BY
    company_job_count.total_jobs desc










/* find the count of the number of remote job posting per skills
- Dsiplay the top 5 skills by their demand in romote jobs
- Include skills ID, name, and count of postings requiring the skills */


WITH remote_jobs AS(
    SELECT -- creating cte for number of people working from home 
        skill_id,
        count(*) AS skill_count
    
    FROM
        skills_job_dim
    INNER JOIN job_postings_fact AS job_posting
    ON job_posting.job_id = skills_job_dim.job_id
    WHERE job_posting.job_work_from_home = True AND
          job_posting.job_title_short= 'Data Analyst'
    GROUP BY skill_id
    
)

SELECT 
    skills_dim.skill_id,
    skills AS skills_name,
    skill_count
FROM remote_jobs
INNER JOIN skills_dim 
ON skills_dim.skill_id = remote_jobs.skill_id
ORDER BY skill_count DESC
LIMIT 5

--- Practice problem

SELECT *
FROM skills_job_dim
LIMIT 10

SELECT *
FROM skills_dim
LIMIT 10

With top_skill AS (
    SELECT
        skill_id,
        count(*) AS skill_count
    FROM skills_job_dim
    GROUP BY skill_id
)

SELECT
    top_skill.skill_id,
    skills_dim.skills
FROM top_skill
INNER JOIN skills_dim 
ON skills_dim.skill_id = top_skill.skill_id


-- practice problem

SELECT *
FROM company_dim

 
WITH company_total AS (
    SELECT
        company_id,
        count(*) AS total_job
    FROM job_postings_fact
    GROUP BY company_id
)
SELECT
    CASE
    WHEN company_total.total_job < 10 THEN 'SMALL GROUP'
    WHEN company_total.total_job < 100 THEN 'MEDIUM GROUP'
    WHEN company_total.total_job < 200 THEN 'BIG GROUP'
    ELSE 'MEGA GROUP'
    END AS group_category,

    company_total.total_job,
    company_dim.name
FROM company_total
INNER JOIN company_dim 
ON company_dim.company_id = company_total.company_id
ORDER BY total_job DESC
