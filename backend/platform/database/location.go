package database

import "going-going-backend/platform/database/enum"

type Location struct {
	Id         *uint64         `gorm:"primaryKey"`
	Name       *string         `gorm:"type:VARCHAR(255); not null"`
	Address    *string         `gorm:"type:VARCHAR(255); not null"`
	Coordinate enum.Coordinate `gorm:"type:string;"`
}
