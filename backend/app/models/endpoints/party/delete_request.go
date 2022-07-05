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

func DeleteRequestHandler(c *fiber.Ctx) error {
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

	// * Delete request from PartyPassengers
	partyPsg := new(database.PartyPassengers)
	if result := migrations.Gorm.
		Where("party_id = ? AND passenger_id = ? AND type = ?", partyId, *claims.UserId, array.PartyTypes.Pending).
		Delete(partyPsg); result.Error != nil {
		return &common.GenericError{
			Message: "Unable to cancel request",
			Err:     result.Error,
		}
	} else if result.RowsAffected == 0 {
		return &common.GenericError{
			Message: "No request found",
		}
	}

	return c.JSON(common.SuccessResponse("Request is canceled"))
}
