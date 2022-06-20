package database

import (
	"time"
)

type Schedule struct {
	Id                    *uint64  `gorm:"primaryKey"`
	PartyId               *uint64  `gorm:"not null"`
	Party                 *Parties `gorm:"foreignKey:PartyId"`
	StartTripDateTime     *time.Time
	StartLocationId       *uint64    `gorm:"not null"`
	StartLocation         *Location  `gorm:"foreignKey:StartLocationId"`
	DestinationLocationId *uint64    `gorm:"not null"`
	DestinationLocation   *Location  `gorm:"foreignKey:DestinationLocationId"`
	Distance              *float64   `gorm:"not null"`
	Filters               [5]*string `gorm:"type:VARCHAR[]"`
	IsEnd                 *bool      `gorm:"default:false; not null"`
}
