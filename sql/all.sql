-- DUMP ALL TABLES
SELECT *
FROM skills;
SELECT *
FROM jobs;
SELECT *
FROM job_skills;
-- COUNT JOB TITLES
SELECT job_title,
    COUNT(*)
FROM jobs
GROUP BY job_title;
-- COUNT MOST POPULAR SKILLS
SELECT skill,
    COUNT(*)
FROM job_skills
GROUP BY skill;
-- COUNT MOST POPULAR SKILLS, BY JOB TITLE
SELECT COUNT(job_skills.skill) as count_popular_skills_by_job_title,
    job_skills.skill,
    job_title
FROM job_skills
    INNER JOIN jobs ON job_skills.job_id = jobs.job_id
GROUP BY job_title,
    job_skills.skill;
-- COUNT MOST POPULAR SKILLS, IN 'CLOUD PLATFORM' CATEGORY, BY JOB TITLE    
SELECT COUNT(job_skills.skill) AS count_popular_cloud_platform_skills_by_job_title,
    job_skills.skill,
    job_title
FROM job_skills
    JOIN jobs ON job_skills.job_id = jobs.job_id
    JOIN skills ON job_skills.skill = skills.skill
WHERE skills.category = 'Cloud Platform'
GROUP BY job_title,
    job_skills.skill;