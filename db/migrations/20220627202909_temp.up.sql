-- Reference tables
-- TODO: Add skill_types enum
-- TODO: Handle synonyms
-- TODO: Plural or not? ID or not?
CREATE TYPE job_title AS ENUM(
   'Cloud Engineer',
   'Platform Engineer',
   'DevOps Engineer',
   'Cloud Support Engineer',
   'Solutions Architect',
   'Backend Engineer',
   'Site Reliability Engineer',
   'Cloud Operations'
);
CREATE TYPE countries AS ENUM('United Kingdom', 'US', 'Global');
CREATE TYPE skill_category AS ENUM(
   'Language',
   'Cloud Platform',
   'Certification',
   'Container Orchestration',
   'Practice'
);
CREATE TABLE synonyms(
   word varchar(255) PRIMARY KEY,
   synonym varchar(255)
);
INSERT INTO synonyms
VALUES ('Kubernetes', 'k8s');
CREATE TABLE skills(
   skill varchar(255) PRIMARY KEY,
   category skill_category
);
INSERT INTO skills
VALUES ('Kubernetes', 'Container Orchestration');
INSERT INTO skills
VALUES ('AWS', 'Cloud Platform');
INSERT INTO skills
VALUES ('Azure', 'Cloud Platform');
INSERT INTO skills
VALUES ('Python', 'Language');
INSERT INTO skills
VALUES ('Bash', 'Language');
INSERT INTO skills
VALUES ('Distributed Systems', 'Practice');
INSERT INTO skills
VALUES ('AWS CCP', 'Certification');
CREATE TABLE jobs(
   /* TODO: UUID format */
   job_id varchar(255) PRIMARY KEY,
   job_title job_title,
   country countries,
   url varchar(255) NOT NULL
);
-- Joining table
CREATE TABLE job_skills(
   job_id varchar(255) REFERENCES jobs(job_id),
   skill varchar(255) REFERENCES skills(skill)
);
-- Reference data seeds
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