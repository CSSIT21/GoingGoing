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

func PostRequestHandler(c *fiber.Ctx) error {
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

	// * Create passenger request
	psg := &database.PartyPassengers{
		PartyId:     &partyId,
		PassengerId: claims.UserId,
		Type:        &array.PartyTypes.Pending,
	}

	// * Check request already exist
	partyPsg := new(database.PartyPassengers)
	if result := migrations.Gorm.First(partyPsg, "party_id = ? AND passenger_id = ?", partyId, claims.UserId); result.RowsAffected > 0 {
		return &common.GenericError{
			Message: "User already requested",
		}
	}

	// * Add passenger to party
	if result := migrations.Gorm.Create(&psg); result.Error != nil {
		return &common.GenericError{
			Message: "Unable to create new request",
			Err:     result.Error,
		}
	}

	return c.JSON(common.SuccessResponse("Successfully send a request"))
}
