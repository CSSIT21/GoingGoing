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

func GetDriverHandler(c *fiber.Ctx) error {

	// * Parse cookie
	cookie := c.Locals("user").(*jwt.Token)
	claims := cookie.Claims.(*common.UserClaim)

	// * Fetch the user info
	var carInfo *database.CarInformation
	if result := migrations.Gorm.First(&carInfo, "owner_id = ?", claims.UserId); result.RowsAffected == 0 {
		spew.Dump(carInfo)
		return c.JSON(common.SuccessResponse(&profile.ProfileDriverBody{
			Id:              0,
			CarRegistration: "",
			CarBrand:        "",
			CarColor:        "",
			OwnerId:         *claims.UserId,
		}, "Querying is success"))
	} else if result.Error != nil {
		return &common.GenericError{
			Message: "User does not has car info",
		}
	}

	return c.JSON(common.SuccessResponse(&profile.ProfileDriverBody{
		Id:              *carInfo.Id,
		CarRegistration: *carInfo.CarRegistration,
		CarBrand:        *carInfo.CarBrand,
		CarColor:        *carInfo.CarColor,
		OwnerId:         *carInfo.OwnerId,
	}, "Querying is success"))
}
