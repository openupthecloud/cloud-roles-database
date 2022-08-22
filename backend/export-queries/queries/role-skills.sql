SELECT * FROM (
    SELECT 
        *,
        cast(total * 100 / (select count(*) from jobs WHERE jobs.job_title = rolecount.title) as integer) as percentage
    FROM (
        SELECT 
            job_skills.skill as skill, 
            jobs.job_title as title, 
            COUNT(*) as total
        FROM job_skills
            INNER JOIN skills ON job_skills.skill = skills.skill
            INNER JOIN jobs ON job_skills.job_id = jobs.job_id
        WHERE skills.skill NOT IN ('Java', 'JavaScript', 'High Availability', 'Go', 'Degree')
        AND skills.category NOT IN ('Practices')
        GROUP BY job_skills.skill, skills, category, jobs.job_title
        ORDER BY job_title, total DESC
    ) as rolecount
) as outertable
WHERE percentage > 30