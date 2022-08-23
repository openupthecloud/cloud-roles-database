package main

import (
	"html/template"
	"os"
)

type TemplateArguments struct {
	Roles       []Role
	RoleSkills  []RoleSkills
	Top10Skills []Skill
}

func main() {
	var templateArguments TemplateArguments
	roles(&templateArguments)
	roleSkills(&templateArguments)
	topSkills(&templateArguments)

	// Compile the template (without data)
	t, err := template.New("website").Parse(`

	{{ $roles := .Roles }}
	{{ $roleSkills := .RoleSkills }}

	<html>
	<head> 
		<style> 
			@import url('https://fonts.googleapis.com/css?family=Montserrat:900');
			@import url('https://fonts.googleapis.com/css?family=Lora:400,400i,700,700i');
			h1, h2, h3 {
				font-family: Montserrat;
				text-transform: uppercase;
				color: #17244b;
			}
			.container { 
				max-width: 900px;
				margin: auto;
			}
			.tile {
				background-color: white;
				padding: 30px;
				border: 2px solid lightgrey;
				border-radius: 3px;
				margin-bottom: 20px;
				box-shadow: 5px 5px 5px lightgrey;
			}
			.container h2 {
				border-bottom: 6px solid #37bae5;
				padding-bottom: 5px;
			}
			
			body {
				margin: 0px;
				background: #e7e7e7;
				font-size: 1.5em;
				font-family: Lora;
			}
		</style>
	</head>
	<body> 
		<div class="container">
			<br />
			<h1> Open Cloud Data </h1>
			<p> Making key skills for cloud jobs more accessible, open and transparent. Find the project on <a target="_blank" href="https://github.com/openupthecloud/cloud-roles-database">GitHub</a>. Currently <strong>2345</strong> roles analysed. </p>
			<h2> Roles </h2>
			{{range $role :=  $roles}}
				<div class="tile">
					<h3>{{$role.Title}}</h3>
					<ul> 
						{{range $roleSkill := $roleSkills}}		
							{{if eq $roleSkill.Title $role.Title }}
								<li>
									<strong>{{$roleSkill.Percentage}}%</strong>
									{{$roleSkill.Skill}}
								</li>
							{{end}}
						{{end}}
					</ul>
				</div>
			{{end}}
			
			<h2> Insights </h2>
			<div class="tile">
			<h3> Top 10 Cloud Skills </h3>
			{{range .Top10Skills}}
				<div>
				{{.Percentage}}% - {{.Skill}} - {{.Category}} ({{.Total}} total)
				</div>
			{{end}}
			</div>
			<p> Made with &#10084;&#65039; by <a target="_blank" href="https://openupthecloud.com/">Open Up The Cloud</a></p>
			<br /><br /><br />
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
