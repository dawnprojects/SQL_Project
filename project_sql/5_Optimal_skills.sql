/*
Question: What are the most optimal skills to learn (aka it's in high demand and a high-paying skill)?
- Identify skills in high demand and associated with high average salaries for data analyst roles
- Concentrates on remote positions with specified salaries 
- Why? Targets skills that offer job security (high demand) and financial benfits (high salaries)
    offering strategic insights for carrer development in data analysis
*/

SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    round(AVG(job_postings_fact.salary_year_avg),0) AS avg_salary,
    count(skills_job_dim.job_id) AS demand_count

FROM job_postings_fact
INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY
    skills_dim.skill_id
HAVING
    count(skills_job_dim.job_id)>10
ORDER BY
    avg_salary DESC,
     demand_count DESC  
LIMIT 25