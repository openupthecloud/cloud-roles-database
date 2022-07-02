package main

import (
	"regexp"
)

type JobData struct {
	job_title string
	country   string
}

type SkillsList []string

func parseJobData(body string) JobData {
	countryRegex := regexp.MustCompile("Remote")
	country := countryRegex.FindString(body)

	// TODO: Extract from DB reference data
	jobTitleRegex := regexp.MustCompile(`Cloud Engineer|Site Reliability Engineer|Platform Engineer|DevOps Engineer|Solutions Architect`)
	job_title := jobTitleRegex.FindString(body)

	// TODO: Validate and throw error
	response := JobData{
		country:   country,
		job_title: job_title,
	}

	return response
}

func parseSkillData(body string) SkillsList {
	skills := make([]string, 0)

	// TODO: Convert to slice
	// TODO: Pull as reference from DB
	skillDictionary := [100]string{
		"Azure SQL",
		"Terraform",
		"Ansible",
		"Linux",
		"GitHub Actions",
	}

	for _, skillSearch := range skillDictionary {
		skillRegex := regexp.MustCompile(skillSearch)
		skill := skillRegex.FindString(body)
		if len(skill) != 0 {
			skills = append(skills, skill)
		}
	}

	return skills
}
