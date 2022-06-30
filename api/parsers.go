package main

import "regexp"

type JobData struct {
	job_title string
	country   string
}

func parseJobData(body string) JobData {
	countryRegex := regexp.MustCompile("Remote")
	country := countryRegex.FindString(body)

	jobTitleRegex := regexp.MustCompile("Cloud Engineer")
	job_title := jobTitleRegex.FindString(body)

	// TODO: Validate and throw error
	response := JobData{
		country:   country,
		job_title: job_title,
	}

	return response
}
