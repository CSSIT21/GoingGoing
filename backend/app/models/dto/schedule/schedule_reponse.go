package schedule

import (
	"going-going-backend/app/models/dto/party"
	"going-going-backend/platform/database"
	"going-going-backend/platform/database/enum"
	"time"
)

type Response struct {
	Schedules      []*Schedules               `json:"schedules"`
	CarInformation []*database.CarInformation `json:"cars_information"`
}

type Schedules struct {
	Id                    *uint64            `json:"id"`
	PartyId               *uint64            `json:"party_id"`
	Party                 *party.Parties     `json:"party"`
	StartTripDateTime     *time.Time         `json:"start_trip_date_time"`
	StartLocationId       *uint64            `json:"start_location_id"`
	StartLocation         *database.Location `json:"start_location"`
	DestinationLocationId *uint64            `json:"destination_location_id"`
	DestinationLocation   *database.Location `json:"destination_location"`
	Distance              *float64           `json:"distance"`
	IsEnd                 *bool              `json:"is_end"`
	Filters               enum.FilterArray   `json:"filter"`
}
