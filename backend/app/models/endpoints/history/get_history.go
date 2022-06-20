package history

import (
	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v4"
	"going-going-backend/app/models/common"
	"going-going-backend/platform/database"
	"going-going-backend/platform/migrations"
	"time"
)

func GetHandler(c *fiber.Ctx) error {
	// * Parse cookie
	cookie := c.Locals("user").(*jwt.Token)
	claims := cookie.Claims.(*common.UserClaim)

	var histories []*database.Schedule
	result := migrations.Gorm.Table("schedules").
		Select("transactions.name as transaction_name, transactions.date, transactions.amount, transactions.category_id as category_id, categories.name as category_name, categories.color as category_color").
		Where("transactions.owner_id = ? AND DATE(transactions.date) = DATE(?)", claims.UserId, time.Now()).
		Joins("left join categories on categories.id = transactions.category_id").
		Order("transactions.date desc").
		Scan(&histories)
	if result.Error != nil {
		return c.JSON(common.ErrorResponse("Error querying history information", result.Error.Error()))
		//return *common.ErrorResponse("Error querying transaction and category information", result.Error)
	}

	return nil
}
