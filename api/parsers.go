package main

import (
	"fmt"
	"regexp"
)

type JobData struct {
	job_title string
	country   string
}

type SkillsList []string

type Synonyms map[string][]string

func parseJobData(body string) JobData {
	countryRegex := regexp.MustCompile("Remote")
	country := countryRegex.FindString(body)

	fmt.Println(body)

	// TODO: Extract from DB reference data
	jobTitleRegex := regexp.MustCompile(`Cloud Engineer|Site Reliability Engineer|Platform Engineer|DevOps Engineer|Solutions Architect|Support Engineer|IT Engineer|Security Engineer|Infrastructure Engineer|Backend Engineer|Software Developer|Cloud Operations`)
	job_title := jobTitleRegex.FindString(body)
	fmt.Println("Inserting job title:", job_title)
	fmt.Println("Inserting country:", country)
	response := JobData{
		country:   country,
		job_title: job_title,
	}

	return response
}

func parseSkillData(body string, skillDictionary []string, synonyms Synonyms) SkillsList {
	skills := make([]string, 0)
	caseSensitivity := "(?i)"
	for _, skillSearch := range skillDictionary {
		found := false

		// Search for skill
		regex := caseSensitivity + `[>\s]` + skillSearch
		skillRegex := regexp.MustCompile(regex)
		skill := skillRegex.FindString(body)
		if len(skill) > 0 {
			found = true
		}

		// Search for synonyms of skill
		for _, synonym := range synonyms[skillSearch] {
			regex := caseSensitivity + `[>\s]` + synonym
			skillRegex := regexp.MustCompile(regex)
			skill := skillRegex.FindString(body)
			if len(skill) > 0 {
				found = true
			}
		}
		if found {
			skills = append(skills, skillSearch)
		}
	}

	return skills
}
