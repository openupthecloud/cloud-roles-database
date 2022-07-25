package main

import (
	"html/template"
	"os"
)

func main() {
	type Inventory struct {
		Material string
		Count    uint
	}
	sweaters := Inventory{"cloud engineer", 17}
	t, err := template.New("test").Parse("{{.Count}} resumes of {{.Material}}s")
	if err != nil {
		panic(err)
	}
	f, err := os.Create("docs/index.html")
	if err != nil {
		panic(err)
	}
	err = t.Execute(f, sweaters)
	if err != nil {
		panic(err)
	}
	f.Close()
}
