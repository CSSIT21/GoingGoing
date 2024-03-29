package account

import (
	"going-going-backend/app/models/common"
	"going-going-backend/app/models/dto/account"
	"going-going-backend/platform/database"
	"going-going-backend/platform/migrations"
	"time"

	"github.com/gofiber/fiber/v2"
)

func Register(c *fiber.Ctx) error {
	// * Parse body
	body := new(account.RegisterRequestBody)
	if err := c.BodyParser(body); err != nil {
		return &common.GenericError{
			Message: "Unable to parse body", Err: err,
		}
	}

	// * Parse birthdate
	layout := "2006-01-02T15:04:05.000Z"
	birthdate, err := time.Parse(layout, body.BirthDate)
	if err != nil {
		return &common.GenericError{
			Message: "Unable to parse birthdate",
			Err:     err,
		}
	}

	// * Validate new register
	user := database.User{
		PhoneNumber: &body.PhoneNumber,
		Password:    &body.Password,
		FirstName:   &body.FirstName,
		LastName:    &body.LastName,
		BirthDate:   &birthdate,
		Gender:      &body.Gender,
	}

	// * Check if phone number already exist
	if result := migrations.Gorm.First(&user, "phone_number = ?", body.PhoneNumber); result.RowsAffected > 0 {
		return &common.GenericError{
			Message: "This account has already registered",
		}
	}

	// Create account record in database
	if result := migrations.Gorm.Create(&user); result.Error != nil {
		return &common.GenericError{
			Message: "Unable to create new account",
			Err:     result.Error,
		}
	}

	if token, err := common.SignJwt(
		&common.UserClaim{
			UserId: user.Id,
		},
	); err != nil {
		return &common.GenericError{
			Message: "Unable to register",
			Err:     err,
		}
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
