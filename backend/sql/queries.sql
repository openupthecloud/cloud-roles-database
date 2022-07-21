SELECT 
    jobs.url 
FROM 
    jobs_cache
INNER JOIN
    jobs
ON
    jobs.job_id = jobs_cache.job_id


-- DUMP ALL TABLES
SELECT * FROM skills; -- Includes the skill categories
SELECT * FROM jobs;
SELECT COUNT(*) FROM jobs_cache;
SELECT COUNT(*) FROM jobs;
SELECT * FROM job_skills;
SELECT * FROM synonyms;

-- CLEAN TABLE
SELECT * FROM jobs

DELETE FROM jobs_cache

ALTER TYPE job_title ADD VALUE 'Software Engineer'; -- appends to list

-- GET SPECIFIC JOB
SELECT jobs.job_id, jobs.url, jobs.country, jobs.job_title, job_skills.skill
FROM job_skills INNER JOIN jobs ON job_skills.job_id = jobs.job_id
WHERE jobs.job_id = '7937887e-ac22-4525-b990-c579ad02a0c9'

-- GET ALL JOBS + SKILLS
SELECT jobs.job_id, jobs.country, jobs.job_title, job_skills.skill
FROM job_skills INNER JOIN jobs ON job_skills.job_id = jobs.job_id;

-- SANITISE NON CLOUD JOBS (jobs, jobs_cache, job_skills)
DELETE FROM jobs WHERE job_id IN (
    SELECT job_id FROM (
        SELECT 
            jobs.job_id, 
            jobs.job_title, 
            (SELECT COUNT(*) FROM job_skills WHERE job_skills.job_id = jobs.job_id AND job_skills.skill IN ('AWS', 'Azure', 'GCP', 'Kubernetes')) 
        FROM jobs
    ) outr
    WHERE count = 0
)

-- COUNT JOB TITLES
SELECT job_title, COUNT(*) FROM jobs GROUP BY job_title ORDER BY count DESC;

-- COUNT MOST POPULAR SKILLS
SELECT job_skills.skill, skills.category, COUNT(*) as total, cast(COUNT(*) * 100.0 / (select count(*) from jobs) as integer) as percentage
FROM job_skills
    INNER JOIN skills ON job_skills.skill = skills.skill
WHERE skills.category NOT IN ('Practices')
AND skills.skill NOT IN ('Java', 'JavaScript', 'High Availability', 'Go', 'Degree')
GROUP BY job_skills.skill, skills, category
ORDER BY total DESC;

-- COUNT ROLE DIFF TO MAIN SKILLS
SELECT * FROM (
    SELECT 
        *,
        (role_percentage - cloud_percentage) as diff,
        ABS((role_percentage - cloud_percentage)) as diff_abs
    FROM (
        SELECT 
            job_skills.skill, 
            COUNT(*) as total, 
            inna.percentage as cloud_percentage,
            cast(COUNT(*) * 100.0 / (select count(*) from jobs WHERE job_title = 'Cloud Operations') as integer) as role_percentage
        FROM job_skills
            INNER JOIN skills ON job_skills.skill = skills.skill
            INNER JOIN jobs ON job_skills.job_id = jobs.job_id
            INNER JOIN  (
                SELECT job_skills.skill, cast(COUNT(*) * 100.0 / (select count(*) from jobs) as integer) as percentage
                FROM job_skills
                    INNER JOIN skills ON job_skills.skill = skills.skill
                AND skills.skill = skills.skill
                GROUP BY job_skills.skill, skills, category
            ) as inna ON inna.skill = skills.skill
        AND skills.skill NOT IN ('Java', 'JavaScript', 'High Availability', 'Go', 'Degree')
        AND jobs.job_title = 'Cloud Operations'
--      AND skills.category NOT IN ('Practices')
        GROUP BY job_skills.skill, skills, skills.category, jobs.job_title, inna.percentage
    ) as outr
    ORDER BY diff_abs DESC
) outrrr
LIMIT 20

-- SKILLS AS A DATA ENGINEER
SELECT job_skills.skill, COUNT(*) as total, cast(COUNT(*) * 100.0 / (select count(*) from jobs WHERE job_title = 'Data Engineer') as integer) as percentage
FROM job_skills
    INNER JOIN skills ON job_skills.skill = skills.skill
    INNER JOIN jobs ON job_skills.job_id = jobs.job_id
AND skills.skill NOT IN ('Java', 'JavaScript', 'High Availability', 'Go', 'Degree')
AND jobs.job_title = 'Data Engineer'
AND skills.category NOT IN ('Practices')
GROUP BY job_skills.skill, skills, category, jobs.job_title
ORDER BY total DESC;

-- COUNT MOST POPULAR SKILLS + PRACTICES
SELECT job_skills.skill, skills.category, COUNT(*) as total, cast(COUNT(*) * 100.0 / (select count(*) from jobs) as integer) as percentage
FROM job_skills
    INNER JOIN skills ON job_skills.skill = skills.skill
WHERE skills.skill NOT IN ('Java', 'JavaScript', 'High Availability', 'Go', 'Degree')
GROUP BY job_skills.skill, skills, category
ORDER BY total DESC;

-- COUNT MOST POPULAR PRACTICES
SELECT job_skills.skill, skills.category, COUNT(*) as total, cast(COUNT(*) * 100.0 / (select count(*) from jobs) as integer) as percentage
FROM job_skills
    INNER JOIN skills ON job_skills.skill = skills.skill
WHERE skills.category IN ('Practices')
GROUP BY job_skills.skill, skills, category
ORDER BY total DESC;

-- COUNT MOST POPULAR DATABASES
SELECT job_skills.skill, skills.category, COUNT(*) as total, cast(COUNT(*) * 100.0 / (select count(*) from jobs) as integer) as percentage
FROM job_skills
    INNER JOIN skills ON job_skills.skill = skills.skill
WHERE skills.category IN ('Databases')
GROUP BY job_skills.skill, skills, category
ORDER BY total DESC;

-- COUNT SKILLS REQUIRING CODING
SELECT COUNT(*) as total, cast(COUNT(*) * 100.0 / (select count(*) from job_skills) as integer) as percentage
FROM job_skills
    INNER JOIN skills ON job_skills.skill = skills.skill
WHERE skills.category IN ('Language')
ORDER BY total DESC;

-- MONITORING SKILLS AS AN SRE
SELECT job_skills.skill, COUNT(*) as total, cast(COUNT(*) * 100.0 / (select count(*) from jobs WHERE job_title = 'Site Reliability Engineer') as integer) as percentage
FROM job_skills
    INNER JOIN skills ON job_skills.skill = skills.skill
    INNER JOIN jobs ON job_skills.job_id = jobs.job_id
WHERE skills.category IN ('Monitoring')
AND jobs.job_title = 'Site Reliability Engineer'
GROUP BY job_skills.skill, skills, category, jobs.job_title
ORDER BY total DESC;

-- COUNT MOST POPULAR LANGUAGES
SELECT job_skills.skill, skills.category, COUNT(*) as total, cast(COUNT(*) * 100.0 / (select count(*) from jobs) as integer) as percentage
FROM job_skills
    INNER JOIN skills ON job_skills.skill = skills.skill
WHERE skills.category IN ('Language')
GROUP BY job_skills.skill, skills, category
ORDER BY total DESC;

-- COUNT MOST POPULAR INFRASTRUCTURE AS CODE
SELECT job_skills.skill, skills.category, COUNT(*) as total, cast(COUNT(*) * 100.0 / (select count(*) from jobs) as integer) as percentage
FROM job_skills
    INNER JOIN skills ON job_skills.skill = skills.skill
WHERE skills.category IN ('Infrastructure As Code')
GROUP BY job_skills.skill, skills, category
ORDER BY total DESC;

-- COUNT MOST POPULAR MONITORING
SELECT job_skills.skill, skills.category, COUNT(*) as total, cast(COUNT(*) * 100.0 / (select count(*) from jobs) as integer) as percentage
FROM job_skills
    INNER JOIN skills ON job_skills.skill = skills.skill
WHERE skills.category IN ('Monitoring')
GROUP BY job_skills.skill, skills, category
ORDER BY total DESC;

-- COUNT MOST POPULAR CLOUD PLATFORM
SELECT job_skills.skill, skills.category, COUNT(*) as total, cast(COUNT(*) * 100.0 / (select count(*) from jobs) as integer) as percentage
FROM job_skills
    INNER JOIN skills ON job_skills.skill = skills.skill
WHERE skills.category IN ('Cloud Platform')
GROUP BY job_skills.skill, skills, category
ORDER BY total DESC;

-- COUNT MOST POPULAR HIGH AVAILABILITY
SELECT job_skills.skill, skills.category, COUNT(*) as total, cast(COUNT(*) * 100.0 / (select count(*) from jobs) as integer) as percentage
FROM job_skills
    INNER JOIN skills ON job_skills.skill = skills.skill
WHERE skills.skill IN ('High Availability', 'Troubleshooting', 'Incident Management', 'On Call')
GROUP BY job_skills.skill, skills, category
ORDER BY total DESC;

-- MONITORING SKILLS AS AN SRE
SELECT job_skills.skill, COUNT(*) as total, cast(COUNT(*) * 100.0 / (select count(*) from jobs WHERE job_title = 'Site Reliability Engineer') as integer) as percentage
FROM job_skills
    INNER JOIN skills ON job_skills.skill = skills.skill
    INNER JOIN jobs ON job_skills.job_id = jobs.job_id
WHERE skills.category IN ('Monitoring')
AND jobs.job_title = 'Site Reliability Engineer'
GROUP BY job_skills.skill, skills, category, jobs.job_title
ORDER BY total DESC;

-- COUNT MOST POPULAR SKILLS (FOR CLOUD ENGINEER)
SELECT job_skills.skill, COUNT(*) as total, cast(COUNT(*) * 100.0 / (select count(*) from jobs WHERE job_title = 'Cloud Engineer') as integer) as percentage
FROM job_skills
    INNER JOIN skills ON job_skills.skill = skills.skill
    INNER JOIN jobs ON job_skills.job_id = jobs.job_id
WHERE skills.category NOT IN ('Practices')
AND skills.skill NOT IN ('Java', 'JavaScript', 'High Availability', 'Go', 'Degree')
AND jobs.job_title = 'Cloud Engineer'
GROUP BY job_skills.skill, skills, category, jobs.job_title
ORDER BY total DESC;

-- COUNT MOST POPULAR SKILLS (FOR BACKEND ENGINEER)
SELECT job_skills.skill, COUNT(*) as total, cast(COUNT(*) * 100.0 / (select count(*) from jobs WHERE job_title = 'Cloud Engineer') as integer) as percentage
FROM job_skills
    INNER JOIN skills ON job_skills.skill = skills.skill
    INNER JOIN jobs ON job_skills.job_id = jobs.job_id
WHERE skills.category NOT IN ('Practices')
AND jobs.job_title = 'Backend Engineer'
GROUP BY job_skills.skill, skills, category, jobs.job_title
ORDER BY total DESC;

-- COUNT MOST POPULAR SKILLS (FOR SOLUTIONS ARCHITECT)
SELECT job_skills.skill, COUNT(*) as total, cast(COUNT(*) * 100.0 / (select count(*) from jobs WHERE job_title = 'Solutions Architect') as integer) as percentage
FROM job_skills
    INNER JOIN skills ON job_skills.skill = skills.skill
    INNER JOIN jobs ON job_skills.job_id = jobs.job_id
AND jobs.job_title = 'Solutions Architect'
GROUP BY job_skills.skill, skills, category, jobs.job_title
ORDER BY total DESC;

-- COUNT MOST POPULAR SKILLS (FOR CLOUD SUPPORT)
SELECT job_skills.skill, COUNT(*) as total, cast(COUNT(*) * 100.0 / (select count(*) from jobs WHERE job_title = 'Support Engineer') as integer) as percentage
FROM job_skills
    INNER JOIN skills ON job_skills.skill = skills.skill
    INNER JOIN jobs ON job_skills.job_id = jobs.job_id
WHERE skills.category NOT IN ('Practices')
AND jobs.job_title = 'Support Engineer'
GROUP BY job_skills.skill, skills, category, jobs.job_title
ORDER BY total DESC;

-- COUNT MOST POPULAR PRACTICES
SELECT job_skills.skill, skills.category, COUNT(*), cast(COUNT(*) * 100.0 / (select count(*) from jobs) as integer) as percentage
FROM job_skills
INNER JOIN skills ON job_skills.skill = skills.skill
WHERE skills.category IN ('Practices')
GROUP BY job_skills.skill, skills, category
ORDER BY count DESC;

-- COUNT MOST POPULAR CLOUD PLATFORMS
SELECT job_skills.skill, skills.category, COUNT(*), cast(COUNT(*) * 100.0 / (select count(*) from jobs) as integer) as percentage
FROM job_skills
INNER JOIN skills ON job_skills.skill = skills.skill
WHERE skills.category IN ('Cloud Platform')
GROUP BY job_skills.skill, category
ORDER BY count DESC;

-- COUNT JOBS THAT MENTION SECURITY
SELECT * FROM (
    SELECT *, cast((cast (main.total_skill as float) / cast(main.total_jobs as float) * 100) as int) as percentage FROM (
        SELECT *, (select count(*) as blah from jobs WHERE jobs.job_title = inside.job_title) as total_jobs FROM (
            SELECT 
                job_skills.skill,
                job_title,
                COUNT(job_skills.skill) as total_skill
            FROM job_skills
                INNER JOIN skills ON job_skills.skill = skills.skill
                INNER JOIN jobs ON job_skills.job_id = jobs.job_id
            GROUP BY job_title, job_skills.skill
        ) as inside
    ) as main
) as outside
WHERE skill NOT IN ('Java', 'JavaScript', 'High Availability', 'Go', 'Degree')
AND skill IN ('Security')
AND PERCENTAGE NOT IN (100)
ORDER BY percentage DESC

-- COUNT JOBS THAT MENTION SECURITY
SELECT * FROM (
    SELECT *, cast((cast (main.total_skill as float) / cast(main.total_jobs as float) * 100) as int) as percentage FROM (
        SELECT *, (select count(*) as blah from jobs WHERE jobs.job_title = inside.job_title) as total_jobs FROM (
            SELECT 
                job_skills.skill,
                job_title,
                COUNT(job_skills.skill) as total_skill
            FROM job_skills
                INNER JOIN skills ON job_skills.skill = skills.skill
                INNER JOIN jobs ON job_skills.job_id = jobs.job_id
            GROUP BY job_title, job_skills.skill
        ) as inside
    ) as main
) as outside
WHERE skill NOT IN ('Java', 'JavaScript', 'High Availability', 'Go', 'Degree')
AND skill IN ('Security')
AND PERCENTAGE NOT IN (100)
ORDER BY percentage DESC

-- COUNT JOBS THAT MENTION NETWORKING
SELECT * FROM (
    SELECT *, cast((cast (main.total_skill as float) / cast(main.total_jobs as float) * 100) as int) as percentage FROM (
        SELECT *, (select count(*) as blah from jobs WHERE jobs.job_title = inside.job_title) as total_jobs FROM (
            SELECT 
                job_skills.skill,
                job_title,
                COUNT(job_skills.skill) as total_skill
            FROM job_skills
                INNER JOIN skills ON job_skills.skill = skills.skill
                INNER JOIN jobs ON job_skills.job_id = jobs.job_id
            GROUP BY job_title, job_skills.skill
        ) as inside
    ) as main
) as outside
WHERE skill NOT IN ('Java', 'JavaScript', 'High Availability', 'Go', 'Degree')
AND skill IN ('Networking')
AND PERCENTAGE NOT IN (100)
ORDER BY percentage DESC

-- COUNT JOBS THAT MENTIONED BOTH AZURE AND AWS
SELECT COUNT(*) as mentioned_aws_and_azure, cast(COUNT(*) * 100.0 / (select count(*) from jobs) as integer) as percentage FROM (
        SELECT 
            jobs.job_id, 
            (
                SELECT COUNT(job_id)
                FROM job_skills
                WHERE job_skills.job_id = jobs.job_id
                AND job_skills.skill = 'Azure'
            ) as azure,
            (
                SELECT COUNT(job_id) 
                FROM job_skills
                WHERE job_skills.job_id = jobs.job_id
                AND job_skills.skill = 'AWS'
            ) as aws,
            (
                SELECT COUNT(job_id) 
                FROM job_skills
                WHERE job_skills.job_id = jobs.job_id
                AND job_skills.skill = 'GCP'
            ) as gcp
        FROM jobs
    ) as temp
WHERE 
    true = true
AND (temp.aws = 1 AND temp.azure = 1)
AND (temp.aws = 1 AND temp.gcp = 1)
AND (temp.gcp = 1 AND temp.azure = 1)

-- COUNT JOBS MENTIONING AWS LAMBDA OR KUBERNETES
SELECT job_skills.skill, skills.category, COUNT(*), cast(COUNT(*) * 100.0 / (select count(*) from jobs) as integer) as percentage
FROM job_skills
INNER JOIN skills ON job_skills.skill = skills.skill
WHERE skills.skill IN ('AWS Lambda', 'Kubernetes')
GROUP BY job_skills.skill, category
ORDER BY count DESC;

-- COUNT MENTIONING AWS LAMBDA AND KUBERNETES
SELECT COUNT(*), cast(COUNT(*) * 100.0 / (select count(*) from jobs) as integer) as percentage FROM (
        SELECT 
            jobs.job_id, 
            (
                SELECT COUNT(job_id)
                FROM job_skills
                WHERE job_skills.job_id = jobs.job_id
                AND job_skills.skill = 'AWS Lambda'
            ) as lambda,
            (
                SELECT COUNT(job_id) 
                FROM job_skills
                WHERE job_skills.job_id = jobs.job_id
                AND job_skills.skill = 'Kubernetes'
            ) as kubernetes
        FROM jobs
    ) as temp
WHERE temp.kubernetes = 1 AND temp.lambda = 1

-- COUNT MOST POPULAR SKILLS, BY JOB TITLE
SELECT COUNT(job_skills.skill) as count_popular_skills_by_job_title,
    job_skills.skill,
    job_title
FROM job_skills
    INNER JOIN jobs ON job_skills.job_id = jobs.job_id
GROUP BY job_title,
    job_skills.skill
ORDER BY count_popular_skills_by_job_title DESC;

-- COUNT MOST POPULAR SKILLS, IN 'CLOUD PLATFORM' CATEGORY, BY JOB TITLE    
SELECT COUNT(job_skills.skill) AS count_popular_cloud_platform_skills_by_job_title,
    job_skills.skill,
    job_title
FROM job_skills
    JOIN jobs ON job_skills.job_id = jobs.job_id
    JOIN skills ON job_skills.skill = skills.skill
WHERE skills.category = 'Cloud Platform'
AND jobs.job_title = 'Cloud Engineer'
GROUP BY job_title,
    job_skills.skill;
    
-- COUNT ALL DUPLICATE JOBS
SELECT * FROM jobs inr
WHERE (SELECT count(*) FROM JOBS outr WHERE inr.url = outr.url) > 1
