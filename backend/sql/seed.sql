INSERT INTO jobs
VALUES (
        'fake-uuid1',
        'Cloud Engineer',
        'United Kingdom',
        'https://google.com'
    );
INSERT INTO job_skills
VALUES ('fake-uuid1', 'AWS');
INSERT INTO job_skills
VALUES ('fake-uuid1', 'Azure');
INSERT INTO job_skills
VALUES ('fake-uuid1', 'Kubernetes');
-- Reference data seeds
INSERT INTO jobs
VALUES (
        'fake-uuid2',
        'Platform Engineer',
        'United Kingdom',
        'https://google.com'
    );
INSERT INTO job_skills
VALUES ('fake-uuid2', 'Kubernetes');
INSERT INTO job_skills
VALUES ('fake-uuid2', 'AWS');