
# https://github.com/golang-migrate/migrate/blob/master/database/postgres/TUTORIAL.md
create_migration: 
	migrate create -dir db/migrations -ext sql temp

migrate_up:
	migrate -database "postgres://postgres:password@0.0.0.0:5432/postgres?sslmode=disable" -path db/migrations up

migrate_down:
	migrate -database "postgres://postgres:password@0.0.0.0:5432/postgres?sslmode=disable" -path db/migrations down

db_clean: 
	psql postgres://postgres:password@0.0.0.0:5432/postgres -f sql/clean.sql

build: 
	go build -o main ./api

run: 
	./run.sh

test: 
	go test ./api -v