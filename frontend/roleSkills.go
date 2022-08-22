package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"os"
)

// TODO: Find someway to parse the files more cleanly
type RoleSkills struct {
	Skill      string `json:"Skill"`
	Title      string `json:"Title"`
	Total      string `json:"Total"`
	Percentage string `json:"Percentage"`
}

func roleSkills(templateArguments *TemplateArguments) TemplateArguments {
	topSkillsFile, err := os.Open("backend/export-queries/results/role-skills.json")
	topSkillsByteValue, _ := ioutil.ReadAll(topSkillsFile)
	json.Unmarshal(topSkillsByteValue, &templateArguments.RoleSkills)
	if err != nil {
		fmt.Println(err)
	}
	defer topSkillsFile.Close()
	return *templateArguments
}
