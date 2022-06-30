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

	// Step 1: Fetch URL body
	body := fetchUrl(url) // TODO: insert into skills of DB

	// Step 2: Parse out data
	parsedJobData := parseJobData(body)

	// Step 3: Insert job data
	job_id := insertJob(parsedJobData, url)

	// Step 4: Insert skills data
	skill := "k8s" // TODO: Don't hardcode
	word := checkSynonym(skill)
	input2 := skillQuery{
		job_id: job_id,
		skill:  word,
	}
	insertSkill(input2)

	fmt.Println("Successfully imported: ", url)
}
