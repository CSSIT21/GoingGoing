package middlewares

import (
	"github.com/gofiber/fiber/v2"
	"going-going-backend/app/models/common"
)

func NotfoundHandler(ctx *fiber.Ctx) error {
	return ctx.Status(fiber.StatusNotFound).JSON(common.ErrorInfoResponse{
		Success: false,
		Error:   fiber.ErrNotFound.Error(),
	})
}
