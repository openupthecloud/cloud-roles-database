
# https://github.com/golang-migrate/migrate/blob/master/database/postgres/TUTORIAL.md
create_migration: 
	migrate create -dir db/migrations -ext sql temp

migrate_up:
	migrate -database "postgres://postgres:password@0.0.0.0:5432/postgres?sslmode=disable" -path db/migrations up