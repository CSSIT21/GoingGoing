package main

import (
	"going-going-backend/pkg/fiber"
	"going-going-backend/platform/migrations"
)

func main() {
	migrations.Init()
	fiber.Init()
}
