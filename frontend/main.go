package main

import (
	"encoding/json"
	"fmt"
	"html/template"
	"io/ioutil"
	"os"
)

func main() {
	type Role struct {
		Title string `json:"Title"`
	}
	type Skill struct {
		Skill      string `json:"Skill"`
		Category   string `json:"Category"`
		Total      string `json:"Total"`
		Percentage string `json:"Percentage"`
	}
	type TemplateArguments struct {
		Roles       []Role
		Top10Skills []Skill
	}
	var templateArguments TemplateArguments

	// TODO: Iterate over directory
	// TODO: Consolidate duplicate types in package

	rolesFile, err := os.Open("backend/export-queries/results/roles.json")
	rolesByteValue, _ := ioutil.ReadAll(rolesFile)
	json.Unmarshal(rolesByteValue, &templateArguments.Roles)
	if err != nil {
		fmt.Println(err)
	}
	defer rolesFile.Close()

	topSkillsFile, err := os.Open("backend/export-queries/results/top-10-skills.json")
	topSkillsByteValue, _ := ioutil.ReadAll(topSkillsFile)
	json.Unmarshal(topSkillsByteValue, &templateArguments.Top10Skills)
	if err != nil {
		fmt.Println(err)
	}
	defer rolesFile.Close()

	// Compile the template (without data)
	t, err := template.New("website").Parse(`
	<html>
	<head> 
		<style> 
			.container { 
				max-width: 900px;
				margin: auto;
			}
			.tile {
				padding: 10px;
    			border: 1px solid black;
    			margin-bottom: 20px;
			}
		</style>
	</head>
	<body> 
		<div class="container">
			<h1> Open Up The Cloud Job Roles Database </h1>
			<p> <strong>2345</strong> roles analysed </p>
			<h2> Roles </h2>
			{{range .Roles}}
				<div class="tile">
					<div>{{.Title}}</div>
				</div>
			{{end}}
			<h2> Insights </h2>
			<div class="tile">
			<h2> Top 10 Skills (All Cloud Jobs) </h2>
			{{range .Top10Skills}}
				<div>
				{{.Percentage}}% - {{.Skill}} - {{.Category}} ({{.Total}} total)
				</div>
			{{end}}
			</div>
		</div>
	</body> 
	</html>
`)
	if err != nil {
		panic(err)
	}

	// Create the index.html
	f, err := os.Create("docs/index.html")
	if err != nil {
		panic(err)
	}

	// Compile the template (with data)
	err = t.Execute(f, templateArguments)
	if err != nil {
		panic(err)
	}
	f.Close()
}
