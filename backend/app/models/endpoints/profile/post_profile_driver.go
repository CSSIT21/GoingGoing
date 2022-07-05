package profile

import (
	"errors"
	"github.com/bearbin/go-age"
	"going-going-backend/app/models/common"
	"going-going-backend/app/models/dto/profile"
	"going-going-backend/platform/database"
	"going-going-backend/platform/migrations"
	"gorm.io/gorm"

	//age "github.com/bearbin/go-age"
	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v4"
)

func PostDriverHandler(c *fiber.Ctx) error {
	// * Parse token
	token := c.Locals("user").(*jwt.Token)
	claims := token.Claims.(*common.UserClaim)

	// * Parse body
	body := new(profile.DriverRequestBody)
	if err := c.BodyParser(body); err != nil {
		return &common.GenericError{
			Message: "Unable to parse body", Err: err,
		}
	}

	// * Fetch user information
	user := new(database.User)
	if result := migrations.Gorm.First(&user, "id = ?", claims.UserId); errors.Is(result.Error, gorm.ErrRecordNotFound) {
		return &common.GenericError{
			Message: "This user is not exist",
			Err:     result.Error,
		}
	} else if result.Error != nil {
		return &common.GenericError{
			Message: "Unable to fetch user's information",
			Err:     result.Error,
		}
	}

	// * Parse age and check if < 20 years old
	var userAge = age.Age(*user.BirthDate)
	if userAge < 20 {
		return &common.GenericError{
			Message: "You're underage to become a driver",
		}
	}

	// * Create category record
	carInfo := &database.CarInformation{
		CarRegistration: &body.CarRegistration,
		CarBrand:        &body.CarBrand,
		CarColor:        &body.CarColor,
		OwnerId:         claims.UserId,
	}

	// * Check car registration already registered
	car := new(database.CarInformation)
	if result := migrations.Gorm.First(car, "car_registration = ? AND owner_id != ?", body.CarRegistration, claims.UserId); result.RowsAffected > 0 {
		return &common.GenericError{
			Message: "This car has already registered",
		}
	}

	if result := migrations.Gorm.Create(&carInfo).Scan(car); result.Error != nil {
		return &common.GenericError{
			Message: "Error to create car info record",
			Err:     result.Error,
		}
	}

	return c.JSON(common.SuccessResponse("Your driver information already added"))
}
