package main

import "testing"

func TestHappyPath(t *testing.T) {
	got := parseJobData("Cloud Engineer, Remote")
	want := JobData{
		job_title: "Cloud Engineer",
		country:   "Remote",
	}

	if got != want {
		t.Errorf("got %q want %q", got, want)
	}
}
