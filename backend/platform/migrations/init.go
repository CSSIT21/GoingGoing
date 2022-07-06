package migrations

import (
	"going-going-backend/app/models/common"
	"going-going-backend/pkg/configs"
	"going-going-backend/platform/database"
	"gorm.io/driver/postgres"
	"gorm.io/gorm/logger"
	"os"
	"time"

	"gorm.io/gorm"
	"log"
)

var Gorm *gorm.DB

func Init() {
	// Open SQL connection
	dialector := postgres.New(
		postgres.Config{
			DSN:                  configs.C.PostgresDsn,
			PreferSimpleProtocol: true,
		},
	)

	if db, err := gorm.Open(dialector, &gorm.Config{
		Logger: logger.New(
			log.New(os.Stdout, "\r\n", log.LstdFlags), // io writer
			logger.Config{
				SlowThreshold:             100 * time.Millisecond,
				LogLevel:                  logger.Info,
				IgnoreRecordNotFoundError: true,
				Colorful:                  true,
			},
		),
	}); err != nil {
		println("UNABLE TO LOAD GORM PostgresSql DATABASE")
		log.Fatalf("error: %s", err.Error())
	} else {
		Gorm = db
	}

	// Initialize model migrations
	if err := migrate(); err != nil {
		println("UNABLE TO MIGRATE GORM MODEL")
		log.Fatalf("error: %s", err.Error)
	}
}

func migrate() *common.ErrorResponse {
	if err := Gorm.AutoMigrate(
		new(database.User),
		new(database.CarInformation),
		new(database.Location),
		new(database.Schedule),
		new(database.Parties),
		new(database.PartyPassengers),
	); err != nil {
		return &common.ErrorResponse{
			Message: "Unable to create database record",
			Error:   err.Error(),
		}
	}
	return nil
}
