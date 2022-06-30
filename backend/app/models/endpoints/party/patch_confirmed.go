package party

import (
	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v4"
	"going-going-backend/app/models/common"
	"going-going-backend/platform/database"
	"going-going-backend/platform/database/array"
	"going-going-backend/platform/migrations"
	"strconv"
)

func PatchConfirmedHandler(c *fiber.Ctx) error {
	// * Parse JWT token
	token := c.Locals("user").(*jwt.Token)
	claims := token.Claims.(*common.UserClaim)

	// * Parse path parameters
	partyId, err := strconv.ParseUint(c.Params("id"), 10, 64)
	if err != nil {
		return &common.GenericError{
			Message: "Unable to parse path parameter",
			Err:     err,
		}
	}

	// * Update passenger's type to confirmed
	partyPsg := new(database.PartyPassengers)
	if result := migrations.Gorm.
		Model(partyPsg).
		Where("party_id = ? AND passenger_id = ?", partyId, claims.UserId).
		Update("type", array.PartyTypes.Confirmed); result.Error != nil {
		return &common.GenericError{
			Message: "Unable to update type",
			Err:     result.Error,
		}
	}

	return c.JSON(common.SuccessResponse("Updating is success"))
}
