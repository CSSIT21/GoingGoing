package database

import (
	"going-going-backend/platform/database/enum"
	"time"
)

type Schedule struct {
	Id                    *uint64          `gorm:"primaryKey" json:"id"`
	PartyId               *uint64          `gorm:"not null" json:"party_id"`
	Party                 *Parties         `gorm:"foreignKey:PartyId" json:"party"`
	StartTripDateTime     *time.Time       `gorm:"not null" json:"start_trip_date_time"`
	StartLocationId       *uint64          `gorm:"not null" json:"start_location_id"`
	StartLocation         *Location        `gorm:"foreignKey:StartLocationId" json:"start_location"`
	DestinationLocationId *uint64          `gorm:"not null" json:"destination_location_id"`
	DestinationLocation   *Location        `gorm:"foreignKey:DestinationLocationId" json:"destination_location"`
	Distance              *float64         `gorm:"not null" json:"distance"`
	IsEnd                 *bool            `gorm:"default:false; not null" json:"is_end"`
	Filters               enum.FilterArray `gorm:"type:string" json:"filter"`
}
