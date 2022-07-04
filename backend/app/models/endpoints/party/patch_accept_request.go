package party

import (
	"github.com/gofiber/fiber/v2"
	"going-going-backend/app/models/common"
	"going-going-backend/platform/database"
	"going-going-backend/platform/database/array"
	"going-going-backend/platform/migrations"
	"strconv"
)

func PatchAcceptHandler(c *fiber.Ctx) error {
	// * Parse path parameters
	partyId, err := strconv.ParseUint(c.Params("id"), 10, 64)
	if err != nil {
		return &common.GenericError{
			Message: "Unable to parse path parameter",
			Err:     err,
		}
	}
	psgId, err := strconv.ParseUint(c.Params("psg_id"), 10, 64)
	if err != nil {
		return &common.GenericError{
			Message: "Unable to parse path parameter",
			Err:     err,
		}
	}

	// * Fetch party from party id
	party := new(database.Parties)
	if result := migrations.Gorm.First(party, "id = ?", partyId); result.Error != nil {
		return &common.GenericError{
			Message: "Unable to fetch party",
			Err:     result.Error,
		}
	}

	// * Get count of passenger type confirmed and temp
	var count uint64
	if result := migrations.Gorm.Model(new(database.PartyPassengers)).
		Select("COUNT(id)").
		Where("party_id = ? AND type <> ?", partyId, array.PartyTypes.Pending).
		Scan(&count); result.Error != nil {
		return &common.GenericError{
			Message: "Unable to fetch party",
			Err:     result.Error,
		}
	}

	// * Check if count is exceed maximum passenger
	if count >= *party.MaxPsg {
		return &common.GenericError{
			Message: "The number of passenger already reached the maximum",
		}
	}

	// * Update passenger's type to temp
	partyPsg := new(database.PartyPassengers)
	if result := migrations.Gorm.Model(partyPsg).
		Where("party_id = ? AND passenger_id = ?", partyId, psgId).
		Update("type", array.PartyTypes.Temp); result.Error != nil {
		return &common.GenericError{
			Message: "Unable to accept request",
			Err:     result.Error,
		}
	}

	return c.JSON(common.SuccessResponse("User's request is accepted"))
}
