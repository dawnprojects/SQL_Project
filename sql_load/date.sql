SELECT
job_title_short AS title,
job_location AS location,
--job_posted_date :: DATE AS job_posted_date -- Converting datatype to data & removing timestamp  
job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time,
EXTRACT(MONTH FROM job_posted_date) AS date_month,
EXTRACT(YEAR FROM job_posted_date) AS date_year 
 
FROM job_postings_fact
LIMIT 5; 


SELECT
    count(job_id) AS total_job_posted,
    EXTRACT(MONTH FROM job_posted_date) AS month

FROM job_postings_fact
WHERE
    job_title = 'Data Analyst'
GROUP BY
    month
ORDER BY
    total_job_posted DESC; 


SELECT
    AVG(salary_year_avg) AS avg_year,
    AVG(salary_hour_avg) AS avg_hour,
    job_schedule_type,
    job_posted_date :: DATE AS job_posted

FROM job_postings_fact
WHERE
   job_posted_date > '2023-06-01' AND 
   (salary_hour_avg <> 0 OR 
    salary_year_avg <> 0)
GROUP BY
   job_schedule_type,
   job_posted_date
   




