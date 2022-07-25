package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"strings"

	_ "github.com/lib/pq"
)

const (
	host     = "localhost"
	port     = 5432
	user     = "postgres"
	password = "password"
	dbname   = "postgres"
)

const contextDirectory = "backend/export-queries"
const queryDirectory = contextDirectory + "/queries"
const resultsDirectory = contextDirectory + "/results"

func getDb() *sql.DB {
	// TODO: Extract DB connection to separate function
	psqlInfo := fmt.Sprintf("host=%s port=%d user=%s "+"password=%s dbname=%s sslmode=disable", host, port, user, password, dbname)
	db, err := sql.Open("postgres", psqlInfo)
	if err != nil {
		panic(err)
	}
	return db
}

type Result struct {
	Skill   string
	Synonym string
}

func main() {
	fmt.Println("Starting export of JSON files for queries")
	files, err := ioutil.ReadDir(queryDirectory)
	if err != nil {
		log.Fatal(err)
	}

	fmt.Println("Iterating over queries")
	for _, f := range files {
		fileNameSQLExtension := f.Name()
		fileNameJSONExtension := strings.Replace(f.Name(), ".sql", ".json", 1)

		fmt.Println("Reading SQL file: ", fileNameSQLExtension)
		query, err := os.ReadFile(queryDirectory + "/" + fileNameSQLExtension)
		if err != nil {
			panic(err)
		}

		// fmt.Print(string(query))
		db := getDb()
		defer db.Close()
		rows, err := db.Query(string(query))
		if err != nil {
			panic(err)
		}
		var results []*Result
		for rows.Next() {
			r := new(Result)
			err := rows.Scan(&r.Skill, &r.Synonym)
			if err != nil {
				log.Fatal(err)
			}
			results = append(results, r)
		}
		result, err := json.Marshal(results)

		// fmt.Println(string(result))
		fmt.Println("Writing results from SQL file: ", fileNameJSONExtension)
		err = os.WriteFile(resultsDirectory+"/"+fileNameJSONExtension, result, 0666)
		if err != nil {
			panic(err)
		}
	}
}
