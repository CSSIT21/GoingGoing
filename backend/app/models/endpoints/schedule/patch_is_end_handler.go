package schedule

import (
	"github.com/gofiber/fiber/v2"
	"going-going-backend/app/models/common"
	"going-going-backend/platform/database"
	"going-going-backend/platform/migrations"
	"strconv"
)

func PatchIsEndHandler(c *fiber.Ctx) error {
	// * Parse parameters
	scheduleId, err := strconv.ParseUint(c.Query("schedule_id"), 10, 64)
	if err != nil {
		return &common.GenericError{
			Message: "Unable to parse query parameter",
		}
	}

	isEnd := new(bool)
	*isEnd = true
	if result := migrations.Gorm.Table("schedules").
		Where("id = ?", scheduleId).
		Updates(
			database.Schedule{
				IsEnd: isEnd,
			}); result.Error != nil {
		return &common.GenericError{
			Message: "Unable to update isEnd",
		}
	}

	return c.JSON(common.SuccessResponse(common.UpdateResponse{
		Id: &scheduleId,
	}, "Querying is success"))
}
