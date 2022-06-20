package jwt

import (
	"github.com/golang-jwt/jwt/v4"
	"going-going-backend/app/models/common"
	"going-going-backend/pkg/configs"
)

//Use in Login process
func SignJwt(claim *common.UserClaim) (string, *common.GenericError) {
	// * Create token
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claim)

	// * Generate signed token string
	if signedToken, err := token.SignedString([]byte(configs.C.JwtSecret)); err != nil {
		return "", &common.GenericError{
			Success: false,
			Code:    err.Error(),
			Message: "Unable to sign JWT token",
			Err:     err,
		}
	} else {
		return signedToken, nil
	}
}
