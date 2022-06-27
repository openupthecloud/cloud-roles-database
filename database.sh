#!/bin/bash

POSTGRES_PASSWORD="password"
POSTGRES_USER="postgres"
POSTGRES_DB="cloud"

DATABASE_URL=postgres://postgres:password@localhost:8080/cloud

printenv | grep POSTGRES

psql