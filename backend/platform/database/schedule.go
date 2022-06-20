package database

import (
	"going-going-backend/platform/database/enum"
	"time"
)

type Schedule struct {
	Id                    *uint64  `gorm:"primaryKey"`
	PartyId               *uint64  `gorm:"not null"`
	Party                 *Parties `gorm:"foreignKey:PartyId"`
	StartTripDateTime     *time.Time
	StartLocationId       *uint64      `gorm:"not null"`
	StartLocation         *Location    `gorm:"foreignKey:StartLocationId"`
	DestinationLocationId *uint64      `gorm:"not null"`
	DestinationLocation   *Location    `gorm:"foreignKey:DestinationLocationId"`
	Distance              *float64     `gorm:"not null"`
	filter                *enum.Filter `gorm:"type:ENUM('Woman Only', 'Child in Car', 'Family Car', 'Elder in Car', '20 Years Old Up'); not null"`
}
