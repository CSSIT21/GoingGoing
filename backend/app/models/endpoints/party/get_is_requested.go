package party

import (
	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v4"
	"going-going-backend/app/models/common"
	"going-going-backend/app/models/dto/party"
	"going-going-backend/platform/database"
	"going-going-backend/platform/migrations"
)

func GetIsRequestedHandler(c *fiber.Ctx) error {
	// * Parse JWT token
	token := c.Locals("user").(*jwt.Token)
	claims := token.Claims.(*common.UserClaim)

	psg := new(database.PartyPassengers)
	if result := migrations.Gorm.First(psg, "passenger_id = ?", claims.UserId); result.RowsAffected == 0 {
		return c.JSON(common.SuccessResponse(&party.CheckRequestResponse{IsRequest: false}))
	} else if result.Error != nil {
		return &common.GenericError{
			Message: "Unable to fetch party passenger",
			Err:     result.Error,
		}
	}

	return c.JSON(common.SuccessResponse(&party.CheckRequestResponse{IsRequest: true, Type: *psg.Type}))
}
