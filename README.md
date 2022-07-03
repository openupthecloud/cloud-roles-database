
# Cloud Job Roles Database

This project creates a SQL database to gather data on cloud tech job descriptions. 

The binary `.main` takes a URL, parses any skills and inserts them into the database.

## Getting Started

* `make db_clean && make migrate_up && make run`
* `make run && make db_get_all`

**Todo:**

- [x] Connect Postico locally
- [x] Automate the import of 5 resumes
- [x] Add one of each of the roles
- [x] Do a full import of all skills on each resume
- [x] Pull URLs from a text file (break new line)
- [x] Automate the list collection of the URLs

- [x] Add skill synonym support ("AWS Lambda", "Lambda", etc) and upper/lower for skills
- [ ] Add title synonym support ("Cloud Engineer", etc)
- [ ] Update the information on certifications
- [ ] Update the information on niche cloud providers (digital ocean, etc)
- [ ] Fix regex issues with Go / AI / Java / JavaScript (select only body?)
- [ ] Read through some of the automated resumes, make sure to capture all skills

- [ ] Update the README with getting started instructions
- [ ] Backup Postgres database
- [ ] Catch and log errors

**Tidy up**
- [ ] Make URL the ID
- [ ] Fix issues with adjoining words (whitespace)
- [ ] Extract years of experience?
- [ ] Handle error states, such as incorrect parse, etc
- [ ] Add unit tests for various resumes

**Converting to Web App**
- [ ] Find way to move the database to static storage
- [ ] Design the interface (and ways to query the data)