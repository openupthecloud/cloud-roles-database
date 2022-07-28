package main

import (
	"html/template"
	"os"
)

type TemplateArguments struct {
	Roles       []Role
	Top10Skills []Skill
}

func main() {
	var templateArguments TemplateArguments
	roles(&templateArguments)
	topSkills(&templateArguments)

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
