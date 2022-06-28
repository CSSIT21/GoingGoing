package profile

import (
	"going-going-backend/app/models/common"
	"going-going-backend/app/models/dto/profile"
	"going-going-backend/platform/database"
	"going-going-backend/platform/migrations"

	//age "github.com/bearbin/go-age"
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
		return &common.GenericError{
			Message: "Unable to parse body",
		}
	}

	// * Create category record
	carInfo := &database.CarInformation{
		CarRegistration: &body.CarRegistration,
		CarBrand:        &body.CarBrand,
		CarColor:        &body.CarColor,
		OwnerId:         claims.UserId,
	}
	var car *database.CarInformation

	// * Check car registration already registered
	if result := migrations.Gorm.First(&car, "car_registration = ? AND owner_id != ?", body.CarRegistration, claims.UserId); result.RowsAffected > 0 {
		return &common.GenericError{
			Message: "This car has already registered",
		}
		//return c.JSON(common.ErrorResponse("This car has already registered", result.Error.Error()))
	}

	//var car *database.CarInformation
	if result := migrations.Gorm.Create(&carInfo).Scan(car); result.Error != nil {
		return &common.GenericError{
			Message: "Error to create car info record",
		}
		//return c.JSON(common.ErrorResponse("error to create car info record", result.Error.Error()))
	}

	return c.JSON(common.SuccessResponse(common.UpdateResponse{Id: car.Id}, "Post is success"))
}
