package schedule

import (
	"going-going-backend/app/models/dto/party"
	"going-going-backend/platform/database"
	"going-going-backend/platform/database/array"
	"time"
)

type Response struct {
	Schedules      []*Schedule                `json:"schedules"`
	CarInformation []*database.CarInformation `json:"cars_information"`
}

type Schedule struct {
	Id                    *uint64            `json:"id"`
	PartyId               *uint64            `json:"party_id"`
	Party                 *party.Response    `json:"party"`
	StartTripDateTime     *time.Time         `json:"start_trip_date_time"`
	StartLocationId       *uint64            `json:"start_location_id"`
	StartLocation         *database.Location `json:"start_location"`
	DestinationLocationId *uint64            `json:"destination_location_id"`
	DestinationLocation   *database.Location `json:"destination_location"`
	Distance              *float64           `json:"distance"`
	IsEnd                 *bool              `json:"is_end"`
	Filters               array.FilterArray  `json:"filter"`
}
