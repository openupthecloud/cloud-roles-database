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

func checkSynonym(word string) string {
	// TODO: Don't close connection twice
	db := getDb()
	defer db.Close()
	sqlStatement := `SELECT word FROM synonyms WHERE synonyms.synonym = $1`
	returnedWord := ""
	err := db.QueryRow(sqlStatement, word).Scan(&returnedWord)
	if err != nil {
		panic(err)
	}
	wordHasSynonym := len(returnedWord) > 0
	if wordHasSynonym {
		return returnedWord
	}
	return word
}

func insertJob(args query) string {
	// TODO: Don't close connection twice
	db := getDb()
	defer db.Close()
	sqlStatement := `INSERT INTO jobs VALUES ($1, $2, $3, $4) RETURNING job_id`
	id := ""
	err := db.QueryRow(sqlStatement, uuid.New().String(), args.job_title, args.country, args.url).Scan(&id)
	if err != nil {
		panic(err)
	}
	return id
}

func insertSkill(args skillQuery) {
	// TODO: Don't close connection twice
	db := getDb()
	defer db.Close()

	sqlStatement := `INSERT INTO job_skills VALUES ($1, $2) RETURNING job_id`
	id := ""
	err := db.QueryRow(sqlStatement, args.job_id, args.skill).Scan(&id)
	if err != nil {
		panic(err)
	}
}
