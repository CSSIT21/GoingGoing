package profile

import (
	"errors"
	"going-going-backend/app/models/common"
	"going-going-backend/app/models/dto/profile"
	"going-going-backend/pkg/utils/text"
	"going-going-backend/platform/database"
	"going-going-backend/platform/migrations"
	"gorm.io/gorm"

	"github.com/bearbin/go-age"
	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v4"
)

func GetHandler(c *fiber.Ctx) error {

	// * Parse token
	token := c.Locals("user").(*jwt.Token)
	claims := token.Claims.(*common.UserClaim)

	// * Fetch the user info
	var user *database.User
	if result := migrations.Gorm.First(&user, "id = ?", claims.UserId); errors.Is(result.Error, gorm.ErrRecordNotFound) {
		return &common.GenericError{
			Message: "User does not exist",
			Err:     fiber.ErrNotFound,
		}
	} else if result.Error != nil {
		return &common.GenericError{
			Message: "Unable to fetch user's information",
			Err:     result.Error,
		}
	}

	// * Get age
	var ageString = age.Age(*user.BirthDate)

	return c.JSON(common.SuccessResponse(&profile.Response{
		Id:                 *user.Id,
		FirstName:          *user.FirstName,
		LastName:           *user.LastName,
		BirthDate:          *user.BirthDate,
		Gender:             *user.Gender,
		Age:                ageString,
		PathProfilePicture: text.NilFallback(user.PathProfilePicture),
	}))
}
