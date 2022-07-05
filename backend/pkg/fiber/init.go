package fiber

import (
	"going-going-backend/app/controllers"
	"going-going-backend/app/models/common"
	"going-going-backend/pkg/configs"
	"going-going-backend/pkg/fiber/middlewares"
	"log"
	"time"

	"github.com/gofiber/fiber/v2"
)

var app *fiber.App

func Init() {
	// * Initialize fiber instance
	app = fiber.New(fiber.Config{
		ErrorHandler:  middlewares.ErrorHandler,
		Prefork:       false,
		StrictRouting: true,
		ReadTimeout:   5 * time.Second,
		WriteTimeout:  5 * time.Second,
	})

	// * Register root endpoint
	app.All("/", func(c *fiber.Ctx) error {
		return c.JSON(common.InfoResponse{
			Success: true,
			Message: "GOINGGOING_API_ROOT",
		})
	})

	// * Register API endpoints
	apiGroup := app.Group("api/")
	apiGroup.Use(middlewares.Cors)
	controllers.Init(apiGroup)

	// * Register not found handler
	app.Use(middlewares.NotfoundHandler)

	// * Startup
	err := app.Listen(configs.C.Address)
	if err != nil {
		println("UNABLE TO MIGRATE GORM MODEL")
		log.Fatalf("error: %s", err.Error())
	}
}
