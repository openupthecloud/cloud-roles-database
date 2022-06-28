CREATE TABLE jobs(
   job_id varchar(255) PRIMARY KEY, /* TODO: UUID format */
   job_title varchar(255) NOT NULL,
   url varchar(255) NOT NULL
);

CREATE TABLE skills(
   skill varchar(255) PRIMARY KEY /* TODO: UUID format */
);

CREATE TABLE jobs_skills(
   job_id varchar(255) REFERENCES jobs(job_id),
   skills varchar(255) REFERENCES skills(skill)
);

INSERT INTO jobs VALUES ('uuid-goes-here', 'example', 'https://google.com');

INSERT INTO skills VALUES ('kubernetes');
INSERT INTO skills VALUES ('AWS');