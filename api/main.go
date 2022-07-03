package main

import (
	"fmt"
	"os"

	_ "github.com/lib/pq"
)

const (
	host     = "localhost"
	port     = 5432
	user     = "postgres"
	password = "password"
	dbname   = "postgres"
)

type skillQuery struct {
	job_id string
	skill  string
}

func main() {
	// TODO: Cache contents for performance (and testing)
	url := os.Args[1]
	fmt.Println("Starting import for: ", url)

	// Step 1: Fetch URL body
	body := fetchUrl(url) // TODO: insert into skills of DB

	// Step 2: Parse out data
	parsedJobData := parseJobData(body)

	// Step 3: Insert job data
	job_id := insertJob(parsedJobData, url)

	// Step 4: Insert skills data
	synonyms := getSynonyms()
	skillsReference := getSkillsReference()
	skills := parseSkillData(body, skillsReference, synonyms)
	insertSkill(skills, job_id)

	fmt.Println("Successfully imported: ", url)
}
