package main

import (
	"database/sql"
	"fmt"
	"log"

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

func getDb() *sql.DB {
	// TODO: Extract DB connection to separate function
	psqlInfo := fmt.Sprintf("host=%s port=%d user=%s "+"password=%s dbname=%s sslmode=disable", host, port, user, password, dbname)
	db, err := sql.Open("postgres", psqlInfo)
	if err != nil {
		panic(err)
	}
	return db
}

func getCache(url string) string {
	// TODO: Don't close connection twice
	db := getDb()
	defer db.Close()
	// fmt.Println("Checking cache for:", url)
	sqlStatement := `SELECT content FROM jobs_cache INNER JOIN jobs ON jobs.job_id = jobs_cache.job_id WHERE jobs.url = $1`
	rows, err := db.Query(sqlStatement, url)
	if err != nil {
		panic(err)
	}
	content := ""
	for rows.Next() {
		err := rows.Scan(&content)
		if err != nil {
			log.Fatal(err)
		}
	}
	return content
}

func storeCache(job_id string, body string) {
	// TODO: Don't close connection twice
	db := getDb()
	defer db.Close()
	cache := ""
	sqlStatement := `INSERT INTO jobs_cache VALUES ($1, $2) RETURNING content`
	err := db.QueryRow(sqlStatement, job_id, body).Scan(&cache)
	if err != nil {
		panic(err)
	}
	return
}

func getSynonyms() Synonyms {
	// TODO: Don't close connection twice
	db := getDb()
	defer db.Close()

	sqlStatement := `SELECT skill, synonym FROM synonyms`
	rows, err := db.Query(sqlStatement)
	defer rows.Close()
	if err != nil {
		panic(err)
	}

	response := make(map[string][]string)
	for rows.Next() {
		skill := ""
		synonym := ""
		err := rows.Scan(&skill, &synonym)
		if err != nil {
			log.Fatal(err)
		}
		response[skill] = append(response[skill], synonym)
	}

	return response
}

func getSkillsReference() []string {
	db := getDb()
	defer db.Close()

	sqlStatement := `SELECT skill FROM skills`
	rows, err := db.Query(sqlStatement)
	defer rows.Close()
	if err != nil {
		panic(err)
	}

	var skills []string
	for rows.Next() {
		skill := ""
		err := rows.Scan(&skill)
		if err != nil {
			log.Fatal(err)
		}
		skills = append(skills, skill)
	}

	return skills
}

func insertJob(jobData JobData, url string) string {
	// TODO: Don't close connection twice
	db := getDb()
	defer db.Close()
	sqlStatement := `INSERT INTO jobs VALUES ($1, $2, $3, $4) RETURNING job_id`
	id := ""
	err := db.QueryRow(sqlStatement, uuid.New().String(), jobData.job_title, jobData.country, url).Scan(&id)
	if err != nil {
		panic(err)
	}
	return id
}

func insertSkill(skills SkillsList, job_id string) {
	// TODO: Don't close connection twice
	db := getDb()
	defer db.Close()

	for _, skill := range skills {
		fmt.Println("Inserting skill:", skill)
		sqlStatement := `INSERT INTO job_skills VALUES ($1, $2) RETURNING job_id`
		id := ""
		err := db.QueryRow(sqlStatement, job_id, skill).Scan(&id)
		if err != nil {
			panic(err)
		}
	}
}
