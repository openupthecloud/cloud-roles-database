package main

import (
	"database/sql"
	"fmt"
	"io/ioutil"
	"net/http"
	"regexp"

	"github.com/google/uuid"
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
}

func insert(args query) {
	// TODO: Extract DB connection to separate function
	psqlInfo := fmt.Sprintf("host=%s port=%d user=%s "+"password=%s dbname=%s sslmode=disable", host, port, user, password, dbname)
	db, err := sql.Open("postgres", psqlInfo)
	if err != nil {
		panic(err)
	}
	defer db.Close()

	sqlStatement := `INSERT INTO jobs VALUES ($1, $2, $3) RETURNING job_id`
	id := ""
	err = db.QueryRow(sqlStatement, uuid.New().String(), args.job_title, args.url).Scan(&id)
	if err != nil {
		panic(err)
	}
	fmt.Println("New record ID is:", id)
}

func fetchUrl(url string) string {

	resp, err := http.Get(url)
	if err != nil {
		fmt.Println(err)
	}

	body, err := ioutil.ReadAll(resp.Body)
	return string(body)
}

func main() {

	url := "https://uk.indeed.com/viewjob?jk=40042cf599138868"

	// TODO: insert into skills of DB
	body := fetchUrl(url)
	isAWS, _ := regexp.MatchString("AWS", body)
	fmt.Println(isAWS)

	input := query{
		url:       url,
		job_title: "Software Engineer", // TODO: fetch dynamically
	}

	insert(input)
}
