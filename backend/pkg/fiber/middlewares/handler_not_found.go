package middlewares

import (
	"github.com/gofiber/fiber/v2"
	"going-going-backend/app/models/common"
)

func NotfoundHandler(ctx *fiber.Ctx) error {
	return ctx.Status(fiber.StatusNotFound).JSON(common.GenericError{
		Success: false,
		Code:    "404_NOT_FOUND",
		Message: "404_NOT_FOUND",
		Err:     fiber.ErrBadRequest,
	})
}
