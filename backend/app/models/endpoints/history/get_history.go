package history

import (
	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v4"
	"going-going-backend/app/models/common"
	"going-going-backend/platform/database"
	"going-going-backend/platform/migrations"
)

func GetHandler(c *fiber.Ctx) error {
	// * Parse cookie
	cookie := c.Locals("user").(*jwt.Token)
	claims := cookie.Claims.(*common.UserClaim)

	var histories []*database.Schedule
	var parties []*uint64

	if result := migrations.Gorm.Table("party_passengers").
		Select("party_id").
		Where("passenger_id = ?", claims.UserId).Scan(&parties); result.Error != nil {
		return c.JSON(common.ErrorResponse("Error querying party_id", result.Error.Error()))
	}

	if result := migrations.Gorm.Where("party_id IN ?", parties).Preload("Party").Preload("StartLocation").Preload("DestinationLocation").Find(&histories); result.Error != nil {
		return c.JSON(common.ErrorResponse("Error querying party_id", result.Error.Error()))
	}

	// schedules
	// car_info
	// parties เพิ่ม driver_info and partyPsg

	// schedules --> หา distinct เอา car_info

	return c.JSON(common.SuccessResponse(histories, "Querying is success"))
}
