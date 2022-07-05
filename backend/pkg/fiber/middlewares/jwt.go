package middlewares

import (
	"going-going-backend/app/models/common"
	"going-going-backend/pkg/configs"

	"github.com/gofiber/fiber/v2"
	jwtware "github.com/gofiber/jwt/v3"
)

var Jwt = func() fiber.Handler {
	conf := jwtware.Config{
		SigningKey:   []byte(configs.C.JwtSecret),
		TokenLookup:  "header:Authorization",
		AuthScheme:   "Bearer",
		ContextKey:   "user",
		Claims:       &common.UserClaim{},
		ErrorHandler: AuthError,
	}

	return jwtware.New(conf)
}()

func AuthError(c *fiber.Ctx, e error) error {
	c.Status(fiber.StatusUnauthorized).JSON(
		&common.GenericError{
			Message: "Unauthorized",
			Err:     e,
		})
	return nil
}
