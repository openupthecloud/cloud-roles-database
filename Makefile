
# https://github.com/golang-migrate/migrate/blob/master/database/postgres/TUTORIAL.md
create_migration: 
	migrate create -dir backend/db/migrations -ext sql temp

migrate_up:
	migrate -database "postgres://postgres:password@0.0.0.0:5432/postgres?sslmode=disable" -path backend/db/migrations up

migrate_down:
	migrate -database "postgres://postgres:password@0.0.0.0:5432/postgres?sslmode=disable" -path backend/db/migrations down

db_clean: 
	psql postgres://postgres:password@0.0.0.0:5432/postgres -f backend/sql/clean.sql

build: 
	go build -o run-api ./backend/api && go build -o run-queries ./backend/export-queries/script && go build -o run-frontend ./frontend

site:	
	./run-frontend && python3 -m http.server 3000 --directory docs

run: 
	./run.sh

test: 
	go test ./backend/api -v