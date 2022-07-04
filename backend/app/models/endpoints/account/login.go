package account

import (
	"errors"
	"github.com/gofiber/fiber/v2"
	"gorm.io/gorm"

	"going-going-backend/app/models/common"
	"going-going-backend/app/models/dto/account"
	"going-going-backend/platform/database"
	"going-going-backend/platform/migrations"

	"time"
)

func Login(c *fiber.Ctx) error {

	// Parse body to get req from client side
	body := new(account.LoginRequestBody)
	if err := c.BodyParser(body); err != nil {
		return &common.GenericError{
			Message: "Unable to parse body", Err: err,
		}
	}

	// * Check if phone number is correct
	if len(body.PhoneNumber) != 10 {
		return &common.GenericError{
			Message: "Phone number is incorrect",
			Err:     fiber.ErrBadRequest,
		}
	}

	// * Check user existence
	var user *database.User
	if result := migrations.Gorm.First(&user, "phone_number = ?", body.PhoneNumber); errors.Is(result.Error, gorm.ErrRecordNotFound) {
		return &common.GenericError{
			Message: "User does not exist",
			Err:     result.Error,
		}
	} else if result.Error != nil {
		return &common.GenericError{
			Message: "Unable to find user from phone number",
			Err:     result.Error,
		}
	}

	// * Check user password
	if result := migrations.Gorm.First(&user, "password = ?", body.Password); errors.Is(result.Error, gorm.ErrRecordNotFound) {
		return &common.GenericError{
			Message: "User does not exist",
			Err:     result.Error,
		}
	} else if result.Error != nil {
		return &common.GenericError{
			Message: "Your password is incorrect",
			Err:     result.Error,
		}
	}

	// * Generate jwt token
	if token, err := common.SignJwt(
		&common.UserClaim{
			UserId: user.Id,
		},
	); err != nil {
		return &common.GenericError{
			Message: "Unable to login",
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
			Message: "Your login successful",
		})
	}

}
