package account

// * Login
type LoginRequest struct {
	PhoneNumber string `json:"phone_number"`
	Password 	string `json:"password"`
}