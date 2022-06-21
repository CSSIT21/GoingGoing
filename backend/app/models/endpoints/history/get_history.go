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
	result := migrations.Gorm.Table("schedules sc").
		Select("sc.id as id, sc.partyId as party_id").
		Where("() AND () AND ()", claims.UserId).
		Joins("join locations lc on sc.start_location_id = lc.id OR sc.destination_location_id = lc.id").
		Joins("join parties pts on sc.party_id = pts.id").
		Order("sc.start_trip_date_time desc").
		Scan(&histories)
	if result.Error != nil {
		return c.JSON(common.ErrorResponse("Error querying history information", result.Error.Error()))
	}

	return c.JSON(common.SuccessResponse(histories, "Querying is success"))
}
