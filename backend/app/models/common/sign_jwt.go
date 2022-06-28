package common

import (
	"github.com/golang-jwt/jwt/v4"
	"going-going-backend/pkg/configs"
)

//Use in Login process
func SignJwt(claim *UserClaim) (string, *GenericError) {
	// * Create token
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, claim)

	// * Generate signed token string
	if signedToken, err := token.SignedString([]byte(configs.C.JwtSecret)); err != nil {
		return "", &GenericError{
			Message: "Unable to sign JWT token",
			Err:     err,
		}
	} else {
		//fmt.Sprintf(signedToken)
		return signedToken, nil
	}
}
