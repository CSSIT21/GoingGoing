package schedule

import (
	"github.com/gofiber/fiber/v2"
	"going-going-backend/app/models/common"
	"going-going-backend/platform/migrations"
	"strconv"
)

func PatchIsEndHandler(c *fiber.Ctx) error {
	// * Parse parameters
	scheduleId, err := strconv.ParseUint(c.Query("schedule_id"), 10, 64)
	if err != nil {
		return &common.GenericError{
			Message: "Unable to parse query parameter",
			Err:     err,
		}
	}

	// * Update status to end ride
	isEnd := new(bool)
	*isEnd = true
	if result := migrations.Gorm.Table("schedules").
		Where("id = ?", scheduleId).
		Update("is_end", isEnd); result.Error != nil {
		return &common.GenericError{
			Message: "Unable to update isEnd",
			Err:     result.Error,
		}
	}

	return c.JSON(common.SuccessResponse("This ride ended"))
}
