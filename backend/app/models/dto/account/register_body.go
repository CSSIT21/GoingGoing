package account

import "time"

// * Register
type RegisterRequest struct {
	PhoneNumber string `json:"phone_number"`
	Password 	string `json:"password"`
	FirstName 	string `json:"firstname"`
	LastName 	string `json:"lastname"`
	BirthDate 	time.Time `json:"birthdate"`
	Gender 		string `json:"gender"`
}