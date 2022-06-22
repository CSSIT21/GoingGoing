package account

import (
	"going-going-backend/app/models/common"
	"going-going-backend/app/models/dto/account"
	"going-going-backend/platform/database"
	"going-going-backend/platform/migrations"
	"time"

	"github.com/davecgh/go-spew/spew"
	"github.com/gofiber/fiber/v2"
)

func Register(c *fiber.Ctx) error {
	body := new(account.RegisterRequest)
	if err := c.BodyParser(&body); err != nil {
		return c.JSON(common.ErrorResponse("Unable to parse body", err.Error()))
	}

	// * Validate new register
	user := database.User{
		PhoneNumber: &body.PhoneNumber,
		Password:    &body.Password,
		FirstName:   &body.FirstName,
		LastName:    &body.LastName,
		BirthDate:   &body.BirthDate,
		Gender:      &body.Gender,
	}

	// * Check phone_number already exist
	if result := migrations.Gorm.First(&user, "phone_number = ?", body.PhoneNumber); result.RowsAffected > 0 {
		return c.JSON(common.ErrorResponse("This account has already registered", "There is no error"))
	}

	// Create account record in database
	if result := migrations.Gorm.Create(&user); result.Error != nil {
		return c.JSON(common.ErrorResponse("Unable to create database record", result.Error.Error()))
	}
	spew.Dump(user.Id)
	if token, err := common.SignJwt(
		&common.UserClaim{
			UserId: user.Id,
		},
	); err != nil {
		return err
	} else {
		c.Cookie(&fiber.Cookie{
			Name:    "user",
			Value:   token,
			Expires: time.Now().Add(168 * time.Hour), // 168 hours = 7 days (× 24)
		})

		return c.JSON(account.Response{
			Success: true,
			Token:   token, // Jwt token
			Message: "Your account has been created",
		})
	}

}
