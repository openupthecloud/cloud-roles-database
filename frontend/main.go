package main

import (
	"encoding/json"
	"fmt"
	"html/template"
	"io/ioutil"
	"os"
)

func main() {

	// TODO: Consolidate duplicate types in package
	type Role struct {
		Title string `json:"Title"`
	}
	type TemplateArguments struct {
		Roles []Role
	}
	var templateArguments TemplateArguments

	// TODO: Iterate over directory
	jsonFile, err := os.Open("backend/export-queries/results/roles.json")
	byteValue, _ := ioutil.ReadAll(jsonFile)
	json.Unmarshal(byteValue, &templateArguments.Roles)

	if err != nil {
		fmt.Println(err)
	}

	fmt.Println("Successfully Opened users.json")
	// defer the closing of our jsonFile so that we can parse it later on
	defer jsonFile.Close()

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
				Lorem Ipsum
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
