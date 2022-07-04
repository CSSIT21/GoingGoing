package middlewares

import (
	"github.com/gofiber/fiber/v2"
	"github.com/gofiber/fiber/v2/middleware/cors"
	"going-going-backend/pkg/configs"
)

var Cors = func() fiber.Handler {
	origins := ""
	for i, s := range configs.C.Cors {
		origins += s
		if i < len(configs.C.Cors)-1 {
			origins += ", "
		}
	}

	conf := cors.Config{
		AllowOrigins:     origins,
		AllowCredentials: true,
	}

	return cors.New(conf)
}()
