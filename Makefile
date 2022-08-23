db_migrate:
	migrate -database "postgres://postgres:password@0.0.0.0:5432/postgres?sslmode=disable" -path backend/db/migrations up

db_clean: 
	psql postgres://postgres:password@0.0.0.0:5432/postgres -f backend/sql/clean.sql

build: 
	go build -o run-api ./backend/api && go build -o run-queries ./backend/export-queries/script && go build -o run-frontend ./frontend

run-ingest: 
	make build && ./run.sh

run-query-compilation:	
	make build && ./run-queries

run-render:	
	make build && ./run-frontend && python3 -m http.server 3000 --directory docs

test: 
	go test ./backend/api -v