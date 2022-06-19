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

func PatchDriverHandler(c *fiber.Ctx) error { 
	body := new(profile.ProfileDriverBody)

	if err := c.BodyParser(&body); err != nil {
		return &common.GenericError{
			Message: "Unable to parse body",
			Err:     err,
			Code:    "INVALID_INFORMATION",
		}
	}

	// * Parse cookie
	cookie := c.Locals("user").(*jwt.Token)
	claims := cookie.Claims.(*common.UserClaim)
	spew.Dump(claims.UserId)
	
	var car *database.CarInformation

	if result := migrations.Gorm.First(&car, "owner_id = ?", claims.UserId).
		Updates(
			database.CarInformation{
					CarRegistration:	&body.CarRegistration,
					CarBrand:           &body.CarBrand,
					CarColor: 			&body.CarColor,
			}); result.Error != nil {
			return &common.GenericError{
				Message: "Unable to update user information",
				Code:    "INVALID_INFORMATION",
				Err:     result.Error,
				}
			}
		

	return c.JSON(common.InfoResponse{
		Success: true,
		Message: "Profile information updated successfully",
	})

}
