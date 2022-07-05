package profile

import (
	"going-going-backend/app/models/common"
	"going-going-backend/app/models/dto/profile"
	"going-going-backend/platform/database"
	"going-going-backend/platform/migrations"

	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v4"
)

func PatchHandler(c *fiber.Ctx) error {
	// * Parse token
	token := c.Locals("user").(*jwt.Token)
	claims := token.Claims.(*common.UserClaim)

	// * Parse body
	body := new(profile.RequestBody)
	if err := c.BodyParser(body); err != nil {
		return &common.GenericError{
			Message: "Unable to parse body", Err: err,
		}
	}

	// * Update user info
	user := new(database.User)
	if result := migrations.Gorm.Model(user).Where("id = ?", claims.UserId).
		Updates(
			database.User{
				FirstName:          &body.FirstName,
				LastName:           &body.LastName,
				Gender:             &body.Gender,
				BirthDate:          &body.BirthDate,
				PathProfilePicture: &body.PathProfilePicture,
			}); result.Error != nil {
		return &common.GenericError{
			Message: "Unable to update information",
			Err:     result.Error,
		}
	}

	return c.JSON(common.SuccessResponse("Your profile already updated"))
}
