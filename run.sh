#!/bin/bash

make build
make test

cat ./job_descriptions.txt | awk '{ system("sleep 2"); print $1 }'| xargs -n1 ./main
# cat ./job_descriptions.txt | xargs -n1 ./main