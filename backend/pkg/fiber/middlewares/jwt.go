package middlewares

import (
	"fmt"
	"going-going-backend/app/models/common"
	"going-going-backend/pkg/configs"

	"github.com/gofiber/fiber/v2"
	jwtware "github.com/gofiber/jwt/v3"
)

var Jwt = func() fiber.Handler {
	conf := jwtware.Config{
		SigningKey:  []byte(configs.C.JwtSecret),
		TokenLookup: "header:Authorization",
		AuthScheme:  "Bearer",
		ContextKey:  "user",
		Claims:      &common.UserClaim{},
		ErrorHandler: func(c *fiber.Ctx, err error) error {
			return c.JSON(common.ErrorResponse("JWT validation failure", err.Error()))
		},
	}

	fmt.Sprint(jwtware.New(conf))
	return jwtware.New(conf)
}()
