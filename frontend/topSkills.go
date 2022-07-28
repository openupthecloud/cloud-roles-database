package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"os"
)

type Skill struct {
	Skill      string `json:"Skill"`
	Category   string `json:"Category"`
	Total      string `json:"Total"`
	Percentage string `json:"Percentage"`
}

func topSkills(templateArguments *TemplateArguments) TemplateArguments {
	topSkillsFile, err := os.Open("backend/export-queries/results/top-10-skills.json")
	topSkillsByteValue, _ := ioutil.ReadAll(topSkillsFile)
	json.Unmarshal(topSkillsByteValue, &templateArguments.Top10Skills)
	if err != nil {
		fmt.Println(err)
	}
	defer topSkillsFile.Close()
	return *templateArguments
}
