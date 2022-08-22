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

		// TODO: Find someway to parse the files more cleanly
		if fileNameSQLExtension == "roles.sql" {
			type Role struct {
				Title string
			}
			var results []*Role
			for rows.Next() {

				r := new(Role)
				err := rows.Scan(&r.Title)
				if err != nil {
					log.Fatal(err)
				}
				results = append(results, r)

			}
			result, err := json.Marshal(results)
			fmt.Println("Writing results from SQL file: ", fileNameJSONExtension)
			err = os.WriteFile(resultsDirectory+"/"+fileNameJSONExtension, result, 0666)
			if err != nil {
				panic(err)
			}
		} else if fileNameSQLExtension == "role-skills.sql" {
			// TODO: Find someway to parse the files more cleanly
			type RoleSkill struct {
				Skill      string
				Title      string
				Total      string
				Percentage string
			}
			var results []*RoleSkill
			for rows.Next() {

				r := new(RoleSkill)
				err := rows.Scan(&r.Skill, &r.Title, &r.Total, &r.Percentage)
				if err != nil {
					log.Fatal(err)
				}
				results = append(results, r)

			}
			result, err := json.Marshal(results)
			fmt.Println("Writing results from SQL file: ", fileNameJSONExtension)
			err = os.WriteFile(resultsDirectory+"/"+fileNameJSONExtension, result, 0666)
			if err != nil {
				panic(err)
			}
		} else if fileNameSQLExtension == "top-10-skills.sql" {
			type Skill struct {
				Skill      string
				Category   string
				Total      string
				Percentage string
			}
			var results []*Skill
			for rows.Next() {

				r := new(Skill)
				err := rows.Scan(&r.Skill, &r.Category, &r.Total, &r.Percentage)
				if err != nil {
					log.Fatal(err)
				}
				results = append(results, r)

			}
			result, err := json.Marshal(results)
			fmt.Println("Writing results from SQL file: ", fileNameJSONExtension)
			err = os.WriteFile(resultsDirectory+"/"+fileNameJSONExtension, result, 0666)
			if err != nil {
				panic(err)
			}
		} else {
			panic("No parsing sequence for file: " + fileNameSQLExtension)
		}
	}
}
