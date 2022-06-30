#!/bin/bash

make db_clean 
make migrate_up 
make build
make test

./main "https://uk.indeed.com/viewjob?jk=40042cf599138868"
./main "https://uk.indeed.com/viewjob?jk=88bdcd479f70127c"