package profile

import (
	"going-going-backend/app/models/common"
	"going-going-backend/app/models/dto/profile"
	"going-going-backend/platform/database"
	"going-going-backend/platform/migrations"

	"github.com/davecgh/go-spew/spew"
	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v4"
)

func PatchDriverHandler(c *fiber.Ctx) error {
	body := new(profile.ProfileDriverBody)

	if err := c.BodyParser(&body); err != nil {
		return &common.GenericError{
			Message: "Unable to parse body",
		}
	}

	// * Parse cookie
	cookie := c.Locals("user").(*jwt.Token)
	claims := cookie.Claims.(*common.UserClaim)
	spew.Dump(claims.UserId)

	var car *database.CarInformation
	spew.Dump(body.CarRegistration)
	// * Check car registration already regitered
	if result := migrations.Gorm.First(&car, "car_registration = ? AND owner_id != ?", body.CarRegistration, claims.UserId); result.RowsAffected > 0 {
		return &common.GenericError{
			Message: "This car has already registered",
		}

	} else if result.RowsAffected == 0 {

		if result := migrations.Gorm.First(&car, "owner_id = ?", claims.UserId).
			Updates(
				database.CarInformation{
					CarRegistration: &body.CarRegistration,
					CarBrand:        &body.CarBrand,
					CarColor:        &body.CarColor,
				}); result.Error != nil {
			return &common.GenericError{
				Message: "Unable to update information",
			}
		}
	}

	return c.JSON(common.SuccessResponse("Updating is success"))

}
