#!/bin/bash

make migrate_up
make build
make test

cat ./job_descriptions.txt | awk '{ system("sleep 5"); print $1 }'| xargs -n1 ./run-api
# cat ./job_descriptions.txt | xargs -n1 ./run-api