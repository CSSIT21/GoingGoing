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

func PatchHandler(c *fiber.Ctx) error {

	body := new(profile.ProfileRequest)
	if err := c.BodyParser(&body); err != nil {
		return &common.GenericError{
			Message: "Unable to parse body",
		}
	}

	// * Parse cookie
	cookie := c.Locals("user").(*jwt.Token)
	claims := cookie.Claims.(*common.UserClaim)
	spew.Dump(claims.UserId)

	var user *database.User
	spew.Dump(body.PathProfilePicture)

	if result := migrations.Gorm.First(&user, "id = ?", claims.UserId).
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
		}
	}

	return c.JSON(common.SuccessResponse("Updating is success"))
}
