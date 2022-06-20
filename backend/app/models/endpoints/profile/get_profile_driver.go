package profile

import (
	"going-going-backend/app/models/common"
	"going-going-backend/app/models/dto/profile"
	"going-going-backend/platform/database"
	"going-going-backend/platform/migrations"

	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v4"
)

func GetDriverHandler(c *fiber.Ctx) error { 
	
	// * Parse cookie
	cookie := c.Locals("user").(*jwt.Token)
	claims := cookie.Claims.(*common.UserClaim)

	// * Fetch the user info
	var car_info *database.CarInformation
	if result := migrations.Gorm.First(&car_info, "owner_id = ?",claims.UserId); result.Error != nil {
		return &common.GenericError{
			Message: "User doesn't have car info",
			Code:    "INVALID_INFORMATION",
			Err:     result.Error,
		}
	}


	return c.JSON(common.SuccessResponse(&profile.ProfileDriverBody{
		CarRegistration: *car_info.CarRegistration,
		CarBrand: *car_info.CarBrand,
		CarColor: *car_info.CarColor,

	}, ""))

}
