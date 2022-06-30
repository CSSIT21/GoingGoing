package party

import (
	"going-going-backend/app/models/dto/profile"
)

type Party struct {
	Id              *uint64                  `json:"id"`
	DriverId        *uint64                  `json:"driver_id"`
	Driver          *profile.ProfileResponse `json:"driver"`
	MaxPsg          *uint64                  `json:"maximum_passengers"`
	PassengerIdList []*uint64                `json:"passenger_id_list"` //  (no need to store type since we will fetch specific type from db)
}
