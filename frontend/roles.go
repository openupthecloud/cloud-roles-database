package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"os"
)

type Role struct {
	Title string `json:"Title"`
}

func roles(templateArguments *TemplateArguments) TemplateArguments {
	topSkillsFile, err := os.Open("backend/export-queries/results/roles.json")
	topSkillsByteValue, _ := ioutil.ReadAll(topSkillsFile)
	json.Unmarshal(topSkillsByteValue, &templateArguments.Roles)
	if err != nil {
		fmt.Println(err)
	}
	defer topSkillsFile.Close()
	return *templateArguments
}
