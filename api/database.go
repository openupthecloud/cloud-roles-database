package main

import (
	"database/sql"
	"fmt"

	"github.com/google/uuid"
	_ "github.com/lib/pq"
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

func insertJob(args query) string {
	// TODO: Don't close twice
	db := getDb()
	defer db.Close()
	sqlStatement := `INSERT INTO jobs VALUES ($1, $2, $3) RETURNING job_id`
	id := ""
	err := db.QueryRow(sqlStatement, uuid.New().String(), args.job_title, args.url).Scan(&id)
	if err != nil {
		panic(err)
	}
	return id
}

func insertSkill(job_id string) {
	fmt.Println("sup")
	// TODO: Don't close twice
	db := getDb()
	defer db.Close()
	sqlStatement := `INSERT INTO jobs_skills VALUES ($1, $2) RETURNING job_id`
	id := ""
	err := db.QueryRow(sqlStatement, job_id, "kubernetes").Scan(&id)
	if err != nil {
		panic(err)
	}
}
