package main

import (
	"fmt"
	"os"

	_ "github.com/lib/pq"
)

func main() {
	jd_content := ""

	// TODO: Cache contents for performance (and testing)
	url := os.Args[1]
	// fmt.Println("Starting import for: ", url)

	// Step 1: Fetch URL jd_content
	jd_cache := getCache(url)

	// Step 2: If no cache, fetch URL
	if jd_cache != "" {
		fmt.Println("Cache hit")
		jd_content = jd_cache
	} else {
		fmt.Println("Cache miss")
		jd_content = fetchUrl(url) // TODO: insert into skills of db
	}

	// Step 3: Parse out data
	parsedJobData := parseJobData(jd_content)

	// Step 4: Insert job data
	job_id := insertJob(parsedJobData, url)

	// Step 5: Store cache against job_id
	if jd_cache == "" {
		storeCache(job_id, jd_content)
	}

	// Step 6: Insert skills data
	synonyms := getSynonyms()
	skillsReference := getSkillsReference()
	skills := parseSkillData(jd_content, skillsReference, synonyms)
	insertSkill(skills, job_id)

	// fmt.Println("Successfully imported: ", url)
}
