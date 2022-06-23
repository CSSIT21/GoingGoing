package party

import "going-going-backend/platform/database"

type Parties struct {
	Id              *uint64        `json:"id"`
	DriverId        *uint64        `json:"driver_id"`
	Driver          *database.User `json:"driver"`
	MaxPsg          *uint64        `json:"max_psg"`
	PassengerIdList []*uint64      `json:"passenger_id_list"` //  (no need to store type since we will fetch specific type from db)
}
