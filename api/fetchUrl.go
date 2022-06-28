package main

import (
	"fmt"
	"io/ioutil"
	"net/http"
)

func fetchUrl(url string) string {

	resp, err := http.Get(url)
	if err != nil {
		fmt.Println(err)
	}

	body, err := ioutil.ReadAll(resp.Body)
	return string(body)
}
