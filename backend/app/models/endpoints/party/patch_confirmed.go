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
	// * Parse cookie
	cookie := c.Locals("user").(*jwt.Token)
	claims := cookie.Claims.(*common.UserClaim)

	// * Parse parameters
	partyId, err := strconv.ParseUint(c.Query("party_id"), 10, 64)
	if err != nil {
		return &common.GenericError{
			Message: "Unable to parse query parameter",
		}
	}

	var partyPsg *database.PartyPassengers

	if result := migrations.Gorm.First(&partyPsg, "party_id = ? AND passenger_id = ?", partyId, claims.UserId).
		Updates(
			database.PartyPassengers{
				Type: &array.PartyTypes.Confirmed,
			}).Scan(&partyPsg); result.Error != nil {
		return &common.GenericError{
			Message: "Unable to update type",
		}
	}

	return c.JSON(common.SuccessResponse(common.UpdateResponse{Id: partyPsg.Id}, "Querying is success"))
}
