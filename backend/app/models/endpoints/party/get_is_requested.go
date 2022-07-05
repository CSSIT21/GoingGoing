package party

import (
	"errors"
	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v4"
	"going-going-backend/app/models/common"
	"going-going-backend/app/models/dto/party"
	"going-going-backend/platform/database"
	"going-going-backend/platform/migrations"
	"gorm.io/gorm"
	"strconv"
)

func GetIsRequestedHandler(c *fiber.Ctx) error {
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

	psg := new(database.PartyPassengers)
	if result := migrations.Gorm.First(psg, "passenger_id = ? AND party_id = ?", claims.UserId, partyId); errors.Is(result.Error, gorm.ErrRecordNotFound) {
		return c.JSON(common.SuccessResponse(&party.CheckRequestResponse{IsRequest: false}))
	} else if result.Error != nil {
		return &common.GenericError{
			Message: "Unable to fetch party passenger",
			Err:     result.Error,
		}
	}

	return c.JSON(common.SuccessResponse(&party.CheckRequestResponse{IsRequest: true, Type: *psg.Type}))
}
