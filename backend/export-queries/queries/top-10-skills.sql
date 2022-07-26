SELECT job_skills.skill, skills.category, COUNT(*) as total, cast(COUNT(*) * 100.0 / (select count(*) from jobs) as integer) as percentage
FROM job_skills
    INNER JOIN skills ON job_skills.skill = skills.skill
WHERE skills.category NOT IN ('Practices')
AND skills.skill NOT IN ('Java', 'JavaScript', 'High Availability', 'Go', 'Degree')
GROUP BY job_skills.skill, skills, category
ORDER BY total DESC LIMIT 10;
