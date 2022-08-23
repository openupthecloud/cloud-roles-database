
# Open Cloud Data

## Motivation

I created this project after getting asked many questions about getting into the cloud industry, and rather than giving my own anecdotal experience too much, I was curious to gather data. I decided one of the easiest places to start would be with publicly available job description information. I started [first by gathering data into a spreadsheet](https://www.youtube.com/watch?v=IjYo-LS6lVY), and whilst that was a useful learning exercise, that process was painful and slow... so I automated it. In future, this project can be extended with additional information such as from surveys. 

## Getting Started

This project ingests open-source information, such as information hosted on job descriptions, loads it into a SQL (Postgres) database and creates a website with the information for analysis. 

Currently, the project hosts no database, but runs a three step process: 

1. **Ingest** (`make run-ingest`) - Starts the crawling for data (depends upon `make db_migrate` already being invoked to setup the DB).
2. **Compilation** (`make run-query-compilation`) - Compiles SQL queries into static JSON files used for rendering. 
3. **Rendering** as HTML (`make run-render`) - This command renders the JSON files as a static site. 

### Roadmap

### Data Ingest

- [ ] Salary & pay information
- [ ] Seniority breakdowns
- [ ] Soft skills
- [ ] Role overlap
- [ ] Specialties, e.g. Kmubernetes vs Serverless
- [ ] Update reference data based on Stack Overflow survey (e.g. languages and databases)
- [ ] Work experience
- [ ] Location
- [ ] Update information on languages and monitoring
- [ ] Certifications
- [ ] Niche cloud providers (digital ocean, etc)
- [ ] FAANG data

### Insights

- [ ] Delta of the cloud roles to the main data set
- [ ] Most popular practices (not skills)
- [ ] Most popular: 
  - [ ] databases
  - [ ] infra as code tools 
  - [ ] programming language
  - [ ] cloud provider
- [ ] Should you learn one cloud provider or two (and the overlap)?
- [ ] Which roles in the cloud use Kubernetes?
- [ ] Which is the most popular certification?

### Ingest

- [ ] Fix regex for Go / AI / Java / JavaScript (e.g. select only body?)
- [ ] Better logging (verbosity levels) and error state handling for ingest
- [ ] Make URL the ID of the jobs in database
- [ ] Add historical date and data support
- [ ] Add unit tests for various resumes to test the import logic

### Compilation

- [ ] Create a file per file to render
- [ ] Simplify SQL to JSON export (e.g. direct in Postgres)

### Rendering

- [ ]  Add a role detail page (based on a YAML config)
- [ ]  Provide meta information (ingest count, role count)
