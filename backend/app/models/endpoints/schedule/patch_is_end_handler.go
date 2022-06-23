package schedule

import (
	"github.com/gofiber/fiber/v2"
	"going-going-backend/app/models/common"
	"going-going-backend/platform/database"
	"going-going-backend/platform/migrations"
	"strconv"
)

func PatchIsEndHandler(c *fiber.Ctx) error {
	// * Parse cookie
	//cookie := c.Locals("user").(*jwt.Token)
	//claims := cookie.Claims.(*common.UserClaim)

	// * Parse parameters
	scheduleId, err := strconv.ParseUint(c.Query("schedule_id"), 10, 64)
	if err != nil {
		return c.JSON(common.ErrorResponse("Unable to parse query parameter", err.Error()))
	}

	isEnd := new(bool)
	*isEnd = true
	if result := migrations.Gorm.Table("schedules").
		Where("id = ?", scheduleId).
		Updates(
			database.Schedule{
				IsEnd: isEnd,
			}); result.Error != nil {
		return c.JSON(common.ErrorResponse("Unable to update isEnd", result.Error.Error()))
	}

	return c.JSON(common.SuccessResponse(&scheduleId, "Querying is success"))
}
