package profile

import (
	"going-going-backend/app/models/common"
	"going-going-backend/app/models/dto/profile"
	"going-going-backend/pkg/utils/text"
	"going-going-backend/platform/database"
	"going-going-backend/platform/migrations"

	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v4"
	age "github.com/bearbin/go-age"
)

func GetHandler(c *fiber.Ctx) error { 
	
	// * Parse cookie
	cookie := c.Locals("user").(*jwt.Token)
	claims := cookie.Claims.(*common.UserClaim)

	// * Fetch the user info
	var user *database.User
	if result := migrations.Gorm.First(&user, claims.UserId); result.Error != nil {
		return c.JSON(common.ErrorResponse("User does not exist", "There is no error"))
	}

	var ageString = age.Age(*user.BirthDate);

	return c.JSON(common.SuccessResponse(&profile.ProfileResponse{
		FirstName: *user.FirstName,
		LastName: *user.LastName,
		BirthDate: *user.BirthDate,
		Gender: *user.Gender,
		Age: ageString,
		PathProfilePicture: text.NilFallback(user.PathProfilePicture),

	}, ""))

}
