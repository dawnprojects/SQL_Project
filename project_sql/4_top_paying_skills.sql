/*
Question: What are the top skills based on salary?
- Look at the average salary associated with each skill for data analyst positions
- Focuses on roles with specified salaries, rgardless of location
- Why? It reveals how different skills impact salary levels for data analysts and
    help indentify the most financially rewarding skills to acquire or improve
*/  


SELECT
    skills,
    ROUND(AVG(job_postings_fact.salary_year_avg),0) AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON skills_job_dim.job_id = job_postings_fact.job_id
INNER JOIN skills_dim ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE 
    job_title_short = 'Data Analyst' 
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE
GROUP BY skills
ORDER BY avg_salary DESC
LIMIT 20


/*
Key Trends in Top-Paying Data Analyst Skills
Big Data & Cloud Tools Lead – High salaries for PySpark ($208K), Databricks ($142K), and Airflow ($126K) show that companies prioritize scalable data processing and cloud-based analytics. Analysts with expertise in distributed computing and data orchestration are in high demand.
AI & Machine Learning Pay Premiums – Tools like Watson ($160K), DataRobot ($155K), and Scikit-learn ($126K) highlight the growing need for automated AI solutions and predictive modeling. Analysts who can work with machine learning platforms and AI-driven analytics can command higher salaries.
DevOps & Software Engineering Boost Earnings – Skills like GitLab ($154K), Jenkins ($125K), and Golang ($145K) indicate that companies value automation, version control, and backend development in analytics roles. Data analysts with software engineering or DevOps knowledge have a competitive edge.
*/