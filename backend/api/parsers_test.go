package main

import (
	"testing"
)

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

func TestIgnoreLeadingBracket(t *testing.T) {
	stubSynonymData := make(map[string][]string)
	dictionary := []string{"JavaScript"}
	got := parseSkillData(">javascript", dictionary, stubSynonymData)
	want := SkillsList{"JavaScript"}
	if got[0] != want[0] {
		t.Errorf("got %q want %q", got, want)
	}
}

func TestIgnoreLeadingSpace(t *testing.T) {
	stubSynonymData := make(map[string][]string)
	dictionary := []string{"JavaScript"}
	got := parseSkillData(" javascript", dictionary, stubSynonymData)
	want := SkillsList{"JavaScript"}
	if got[0] != want[0] {
		t.Errorf("got %q want %q", got, want)
	}
}

func TestSynonym(t *testing.T) {
	stubSynonymData := map[string][]string{
		"JavaScript": []string{"TypeScript"},
	}
	dictionary := []string{"JavaScript"}
	got := parseSkillData(` TypeScript`, dictionary, stubSynonymData)
	want := SkillsList{"JavaScript"}
	if got[0] != want[0] {
		t.Errorf("got %q want %q", got, want)
	}
}

func TestOriginal(t *testing.T) {
	stubSynonymData := map[string][]string{
		"JavaScript": []string{"TypeScript"},
	}
	dictionary := []string{"JavaScript"}
	got := parseSkillData(` JavaScript`, dictionary, stubSynonymData)
	want := SkillsList{"JavaScript"}
	if got[0] != want[0] {
		t.Errorf("got %q want %q", got, want)
	}
}

func TestIgnoreLeadingSlash(t *testing.T) {
	stubSynonymData := make(map[string][]string)
	dictionary := []string{"JavaScript"}
	got := parseSkillData(`type="text/javascript">`, dictionary, stubSynonymData)
	want := 0
	if len(got) != want {
		t.Errorf("got %q want %q", got, want)
	}
}

func TestIgnoreAdjoiningWords(t *testing.T) {
	stubSynonymData := make(map[string][]string)
	dictionary := []string{"JavaScript"}
	got := parseSkillData(`<a href="javascript"`, dictionary, stubSynonymData)
	want := 0
	if len(got) != want {
		t.Errorf("got %q want %q", got, want)
	}
}
