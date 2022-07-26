
# Cloud Job Roles Database

The purpose of this project is to ingest open-source information, such as information hosted on job descriptions, load it into a SQL (Postgres) database and host the information for analysis. Currently, the project runs no infrastructure so runs a three step process: 

1. **Ingest** (`make run-ingest`) - Starts the crawling for data (depends upon `make db_migrate` already being invoked to setup the DB).
2. **Compilation** (`make run-compilation`) - Compiles SQL queries into static JSON files used for rendering. 
3. **Rendering** as HTML (`make run-render`) - This command renders the JSON files as a static site. 

### General roadmap

- [ ] Extract salary information
- [ ] Difference in skills between seniority
- [ ] What soft skills are asked for?
- [ ] Analysis on role overlaps
- [ ] Kubernetes vs Serverless / AWS Lambda
- [ ] Go through Stack Overflow 2022 (update languages, databases, etc)
- [ ] How much does work experience matter / asked for
- [ ] Location (and does this affect the data)?
- [ ] Update information on languages and monitoring
- [ ] Update the information on certifications
- [ ] Update the information on niche cloud providers (digital ocean, etc)
- [ ] Extra data from specific companies, e.g. FAANG companies (and compare skills)

### Ingest

- [ ] Fix **regex issues** with Go / AI / Java / JavaScript (select only body?)
- [ ] Move types into shared directory
- [ ] Better logging (verbosity levels) and error state handling
- [ ] Make URL the ID of the jobs?
- [ ] Add unit tests for various resumes

### Compilation

- [ ] Create a file per file to render

### Rendering

- [ ]  Create basic landing page (fonts, styling, etc)
- [ ]  Create roles tile (with basic details)
- [ ]  Create role detail page (based on a YAML config)
- [ ]  Create insights section
