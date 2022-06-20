package profile

import (
	"going-going-backend/app/models/common"
	"going-going-backend/app/models/dto/profile"
	"going-going-backend/platform/database"
	"going-going-backend/platform/migrations"

	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v4"
)

func PostDriverHandler(c *fiber.Ctx) error {
	// * Parse cookie
	cookie := c.Locals("user").(*jwt.Token)
	claims := cookie.Claims.(*common.UserClaim)

	// * Parse body
	body := new(profile.ProfileDriverBody)
	if err := c.BodyParser(&body); err != nil {
		return c.JSON(common.ErrorResponse("Unable to parse body", err.Error()))
	}

	// * Create category record
	car_info := &database.CarInformation{
		CarRegistration:    &body.CarRegistration,
		CarBrand:     		&body.CarBrand,
		CarColor:    		&body.CarColor,
		OwnerId:  claims.UserId,
	}


	if result := migrations.Gorm.Create(&car_info); result.Error != nil {
		return c.JSON(common.ErrorResponse("error to create car info record", result.Error.Error()))
	}

	return c.JSON(&common.InfoResponse{
		Success: true,
		Message: "car info has been added to system",
	})
}
