package main

import (
	"fmt"
	"regexp"

	_ "github.com/lib/pq"
)

const (
	host     = "localhost"
	port     = 5432
	user     = "postgres"
	password = "password"
	dbname   = "postgres"
)

type query struct {
	job_title string
	url       string
	country   string
}

type skillQuery struct {
	job_id string
	skill  string
}

func main() {

	url := "https://uk.indeed.com/viewjob?jk=40042cf599138868"

	// TODO: insert into skills of DB
	body := fetchUrl(url)
	isAWS, _ := regexp.MatchString("AWS", body)
	fmt.Println(isAWS)

	// TODO: Validate and throw error
	input := query{
		url:       url,
		country:   "United Kingdom",
		job_title: "Cloud Engineer", // TODO: fetch dynamically
	}

	job_id := insertJob(input)
	skill := "k8s" // TODO: Don't hardcode

	word := checkSynonym(skill)

	input2 := skillQuery{
		job_id: job_id,
		skill:  word,
	}

	insertSkill(input2)
}
