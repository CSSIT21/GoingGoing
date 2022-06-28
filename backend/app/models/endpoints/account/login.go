package account

import (
	"github.com/davecgh/go-spew/spew"
	"github.com/gofiber/fiber/v2"

	"going-going-backend/app/models/common"
	"going-going-backend/app/models/dto/account"
	"going-going-backend/platform/database"
	"going-going-backend/platform/migrations"

	"time"
)

func Login(c *fiber.Ctx) error {

	body := new(account.LoginRequest)
	if err := c.BodyParser(&body); err != nil { // Get req form client side
		return &common.GenericError{
			Message: "Unable to parse body",
		}
	}

	// * Check user existence
	var user *database.User
	if result := migrations.Gorm.First(&user, "phone_number = ?", body.PhoneNumber); result.Error != nil {
		return &common.GenericError{
			Message: "Phone number is incorrect",
		}
	} else if result.RowsAffected == 0 {
		return &common.GenericError{
			Message: "User does not exist",
		}
	}

	// * Check user password
	if result := migrations.Gorm.First(&user, "password = ?", body.Password); result.Error != nil {
		return &common.GenericError{
			Message: "Your password is incorrect",
		}
	} else if result.RowsAffected == 0 {
		return &common.GenericError{
			Message: "User does not exist",
		}
	}

	spew.Dump(user.Id)

	// * Generate jwt token
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
			Message: "Your login successful",
		})
	}

}
