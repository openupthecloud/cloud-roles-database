
# Cloud Job Roles Database

This project creates a SQL database to gather data on cloud tech job descriptions. 

The binary `.main` takes a URL, parses any skills and inserts them into the database.

## Getting Started

* `make db_clean && make migrate_up && make run`
* `make run && make db_get_all`

## Backlog

**Setup data/database:**
- [x] Connect Postico locally
- [x] Automate the import of 5 resumes
- [x] Add one of each of the roles
- [x] Do a full import of all skills on each resume
- [x] Pull URLs from a text file (break new line)
- [x] Automate the list collection of the URLs
- [x] Add skill synonym support ("AWS Lambda", "Lambda", etc) and upper/lower for skills
- [ ] Fix **regex issues** with Go / AI / Java / JavaScript (select only body?)
- [ ] Write scripts to pull from different data sources
- [ ] Read through some of the automated resumes, make sure to capture all skills
- [x] Cache responses from the job descriptions (so you don't have to re-fetch)
- [x] Backup Postgres database (https://eggerapps.at/postico/docs/v1.4.1/import-export.html)

**Optional extra data**
- [ ] Go through Stack Overflow 2022 (update languages, databases, etc)
- [ ] How much does work experience matter / asked for?
- [ ] Location (and does this affect the data)?
- [ ] Update information on languages and monitoring
- [ ] Update the information on certifications
- [ ] Update the information on niche cloud providers (digital ocean, etc)
- [ ] Extra data from specific companies, e.g. FAANG companies (and compare skills)
- [ ] Something similar to: https://stackshare.io/stacks
- [ ] Extract salary information
- [ ] Difference in skills between seniority
- [ ] What soft skills are asked for?
- [ ] Analysis on role overlaps
- [ ] Kubernetes vs Serverless / AWS Lambda

**Tidy up**
- [ ] Add log verbosity levels
- [ ] Catch and log errors
- [ ] Update the README with getting started instructions
- [ ] Make URL the ID
- [ ] Fix issues with adjoining words (whitespace)
- [ ] Extract years of experience?
- [ ] Handle error states, such as incorrect parse, etc
- [ ] Add unit tests for various resumes

**Converting to Web App**
- [ ] Find way to move the database to static storage
  - [ ] https://github.com/tmarois/Filebase
  - [ ] https://githubnext.com/projects/flat-data
  - [ ] Look at script to convert queries to JSON
- [x] Design the interface (and ways to query the data)
  - [ ] Similar to: https://nomadlist.com/
  - [ ] Structured around roles
- [ ]  Create basic landing page (fonts, styling, etc)
- [ ]  Deploy it
- [ ]  Create roles tile
- [ ]  Create role detail page (based on YAML)
- [ ]  Create insights section
