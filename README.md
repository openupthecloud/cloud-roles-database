
# Cloud Job Roles Database

* `make db_clean && make migrate_up && make run && make db_get_all`
* `make run && make db_get_all`

**Todo:**

- [ ] Handle error states, such as incorrect parse, etc
- [ ] Add synonyms for skills
- [ ] Add unit tests for various resumes
- [ ] Automate the import of 5 resumes
- [x] Connect Postico locally