-- Reference tables
-- TODO: Add skill_types enum
-- TODO: Handle synonyms
-- TODO: Plural or not? ID or not?
CREATE TYPE job_title AS ENUM(
   'Cloud Engineer',
   'Platform Engineer',
   'DevOps Engineer',
   'Data Engineer',
   'Support Engineer',
   'Solutions Architect',
   'Security Engineer',
   'Security Architect',
   'Engineering Manager',
   'Network Engineer',
   'Software Engineer',
   'Enterprise Architect',
   'Infrastructure Engineer',
   'Backend Engineer',
   'Site Reliability Engineer',
   'Cloud Operations',
   'Software Developer'
);
CREATE TYPE countries AS ENUM('United Kingdom', 'US', 'Global', 'Remote');
CREATE TYPE skill_category AS ENUM(
   'Language',
   'Cloud Platform',
   'Certification',
   'CI/CD',
   'Databases',
   'Containers',
   'Practices',
   'Infrastructure As Code',
   'Linux',
   'Practice',
   'Web Server',
   'Microsoft',
   'Degree',
   'TLS',
   'Data Analytics',
   'Messaging',
   'Monitoring',
   'Version Control',
   'Software Repository',
   'Secrets Management',
   'AWS',
   'Networking',
   'API'
);

CREATE TABLE skills(
   skill TEXT PRIMARY KEY,
   category skill_category
);

CREATE TABLE synonyms(
   skill TEXT REFERENCES skills(skill),
   synonym TEXT
);

INSERT INTO skills VALUES ('Kubernetes', 'Containers');
INSERT INTO synonyms VALUES ('Kubernetes', 'k8s');
INSERT INTO skills VALUES ('Azure Kubernetes Service', 'Containers');
INSERT INTO skills VALUES ('Docker', 'Containers');

INSERT INTO skills VALUES ('AWS', 'Cloud Platform');
INSERT INTO skills VALUES ('Azure', 'Cloud Platform');
INSERT INTO skills VALUES ('GCP', 'Cloud Platform');

INSERT INTO skills VALUES ('Apache', 'Web Server');
INSERT INTO skills VALUES ('NGINX', 'Web Server');

INSERT INTO skills VALUES ('On Call', 'Practices');
INSERT INTO synonyms VALUES ('On Call', 'on-call');
INSERT INTO skills VALUES ('Quality Assurance', 'Practices');
INSERT INTO synonyms VALUES ('Quality Assurance', 'Testing');
INSERT INTO skills VALUES ('Troubleshooting', 'Practices');
INSERT INTO skills VALUES ('Service Mesh', 'Practices');
INSERT INTO skills VALUES ('Unit Testing', 'Practices');
INSERT INTO synonyms VALUES ('Unit Testing', 'Unit Tests');
INSERT INTO skills VALUES ('CI/CD', 'Practices');
INSERT INTO synonyms VALUES ('CI/CD', 'Continuous Integration');
INSERT INTO synonyms VALUES ('CI/CD', 'Continuous Deployment');
INSERT INTO synonyms VALUES ('CI/CD', 'CICD');
INSERT INTO synonyms VALUES ('CI/CD', 'CI / CD');
INSERT INTO skills VALUES ('Risk Assessment', 'Practices');
INSERT INTO skills VALUES ('DevOps', 'Practices');
INSERT INTO skills VALUES ('Containers', 'Practices');
INSERT INTO synonyms VALUES ('Containers', 'Docker');
INSERT INTO synonyms VALUES ('Containers', 'Containerisation');
INSERT INTO skills VALUES ('Architecture', 'Practices');
INSERT INTO skills VALUES ('High Availability', 'Practices'); 
INSERT INTO synonyms VALUES ('High Availability', 'Availability');
INSERT INTO synonyms VALUES ('High Availability', 'Scaling');
INSERT INTO synonyms VALUES ('High Availability', '24/7');
INSERT INTO skills VALUES ('Microservices', 'Practices');
INSERT INTO skills VALUES ('Agile', 'Practices');
INSERT INTO skills VALUES ('Security', 'Practices');
INSERT INTO synonyms VALUES ('Security', 'Cybersecurity');
INSERT INTO synonyms VALUES ('Security', 'Cyber');
INSERT INTO skills VALUES ('Machine Learning', 'Practices'); -- Synonyms: "ML"
INSERT INTO skills VALUES ('Infrastructure as Code', 'Practices');
INSERT INTO skills VALUES ('AI', 'Practices');
INSERT INTO skills VALUES ('Serverless', 'Practices');
INSERT INTO synonyms VALUES ('Serverless', 'AWS Lambda');
INSERT INTO synonyms VALUES ('Serverless', 'FaaS');
INSERT INTO skills VALUES ('Incident Management', 'Practices');
INSERT INTO skills VALUES ('Distributed Systems', 'Practice');

INSERT INTO skills VALUES ('GraphQL', 'API');
INSERT INTO skills VALUES ('REST', 'API');

INSERT INTO skills VALUES ('cert-manager', 'TLS');
INSERT INTO skills VALUES ('Lets Encrypt', 'TLS');
INSERT INTO synonyms VALUES ('Lets Encrypt', 'LetsEncrypt');

INSERT INTO skills VALUES ('Networking', 'Networking');
INSERT INTO synonyms VALUES ('Networking', 'Network');
INSERT INTO skills VALUES ('DNS', 'Networking');
INSERT INTO skills VALUES ('Firewall', 'Networking');

INSERT INTO skills VALUES ('Vault', 'Secrets Management');

INSERT INTO skills VALUES ('Artifactory', 'Software Repository');
INSERT INTO skills VALUES ('Nexus', 'Software Repository');

INSERT INTO skills VALUES ('Power BI', 'Data Analytics');
INSERT INTO synonyms VALUES ('Power BI', 'PowerBI');

INSERT INTO skills VALUES ('Azure SQL', 'Databases');
INSERT INTO skills VALUES ('SQL Server', 'Databases');
INSERT INTO skills VALUES ('MySQL', 'Databases');
INSERT INTO skills VALUES ('MongoDB', 'Databases');
INSERT INTO skills VALUES ('Postgres', 'Databases');
INSERT INTO synonyms VALUES ('Postgres', 'PostgreSQL');
INSERT INTO synonyms VALUES ('Postgres', 'PostgresSQL');
INSERT INTO skills VALUES ('Cassandra', 'Databases');
INSERT INTO skills VALUES ('Minio', 'Databases');
INSERT INTO skills VALUES ('ElasticSearch', 'Databases');
INSERT INTO skills VALUES ('DynamoDB', 'Databases');

INSERT INTO skills VALUES ('RabbitMQ', 'Messaging');
INSERT INTO skills VALUES ('Kafka', 'Messaging');

INSERT INTO skills VALUES ('Git', 'Version Control');
INSERT INTO skills VALUES ('BitBucket', 'Version Control');

INSERT INTO skills VALUES ('Microsoft Windows Server', 'Microsoft');
INSERT INTO synonyms VALUES ('Microsoft Windows Server', 'Windows Server');
INSERT INTO skills VALUES ('Powershell', 'Microsoft');
INSERT INTO skills VALUES ('Active Directory', 'Microsoft');

INSERT INTO skills VALUES ('AWS Lambda', 'AWS');
INSERT INTO synonyms VALUES ('AWS Lambda', 'Lambda');

INSERT INTO skills VALUES ('Terraform', 'Infrastructure As Code');
INSERT INTO skills VALUES ('Pulumi', 'Infrastructure As Code');
INSERT INTO skills VALUES ('Ansible', 'Infrastructure As Code');
INSERT INTO skills VALUES ('CloudFormation', 'Infrastructure As Code');
INSERT INTO skills VALUES ('Chef', 'Infrastructure As Code');
INSERT INTO skills VALUES ('Puppet', 'Infrastructure As Code');
INSERT INTO skills VALUES ('Salt', 'Infrastructure As Code');

INSERT INTO skills VALUES ('Grafana', 'Monitoring');
INSERT INTO skills VALUES ('New Relic', 'Monitoring');
INSERT INTO skills VALUES ('Graylog', 'Monitoring');
INSERT INTO skills VALUES ('CloudWatch', 'Monitoring');
INSERT INTO skills VALUES ('DataDog', 'Monitoring');

INSERT INTO skills VALUES ('Linux', 'Linux');

INSERT INTO skills VALUES ('GitHub Actions', 'CI/CD');
INSERT INTO skills VALUES ('Azure DevOps', 'CI/CD');
INSERT INTO skills VALUES ('Jenkins', 'CI/CD');

INSERT INTO skills VALUES ('Python', 'Language');
INSERT INTO skills VALUES ('JavaScript', 'Language');
INSERT INTO synonyms VALUES ('JavaScript', 'TypeScript');
INSERT INTO synonyms VALUES ('JavaScript', 'Node.JS');
INSERT INTO synonyms VALUES ('JavaScript', 'NodeJS');
INSERT INTO skills VALUES ('Ruby', 'Language');
INSERT INTO skills VALUES ('SQL', 'Language');
INSERT INTO synonyms VALUES ('SQL', 'sequel');
INSERT INTO skills VALUES ('Java', 'Language');
INSERT INTO skills VALUES ('Go', 'Language');
INSERT INTO synonyms VALUES ('Go', 'GoLang');
INSERT INTO skills VALUES ('Bash', 'Language');
INSERT INTO synonyms VALUES ('Bash', 'Shell');
INSERT INTO synonyms VALUES ('Bash', 'Scripting');
INSERT INTO synonyms VALUES ('Bash', 'Scripts');

INSERT INTO skills VALUES ('Degree', 'Degree');
INSERT INTO synonyms VALUES ('Degree', 'BA');
INSERT INTO synonyms VALUES ('Degree', 'Bachelors');
INSERT INTO synonyms VALUES ('Degree', 'BSC');

INSERT INTO skills VALUES ('AWS CCP', 'Certification');
INSERT INTO skills VALUES ('ITIL', 'Certification');

-- Make the URL the ID (allow upsert)
CREATE TABLE jobs(
   /* TODO: UUID format */
   job_id TEXT PRIMARY KEY,
   job_title job_title,
   country countries,
   url TEXT NOT NULL
);

-- Joining table
CREATE TABLE job_skills(
   job_id TEXT REFERENCES jobs(job_id),
   skill TEXT REFERENCES skills(skill)
);

--
CREATE TABLE jobs_cache(
   /* TODO: UUID format */
   job_id TEXT REFERENCES jobs(job_id),
   content TEXT
);