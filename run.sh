#!/bin/bash

make db_clean 
make migrate_up 
make build
make test

# ./main "https://uk.indeed.com/viewjob?jk=40042cf599138868" # cloud engineer
# ./main "https://uk.indeed.com/viewjob?jk=88bdcd479f70127c" # cloud engineer
# ./main "https://uk.indeed.com/viewjob?jk=5474e3e56fcd7289" # site reliability engineer
# ./main "https://uk.indeed.com/viewjob?jk=b1f7ee30e7010d66" # platform engineer
# ./main "https://uk.indeed.com/viewjob?jk=67d816259583d8c0" # devops engineer
# ./main https://uk.indeed.com/viewjob?jk=c4ffe670f3be2a1c # solutions architect
# ./main https://uk.indeed.com/viewjob?jk=f0aa08843eac0cd0 # backend engineer
 ./main https://uk.indeed.com/viewjob?jk=8767f62db396ed51 # cloud operations engineer