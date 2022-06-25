package account

// * Register
type RegisterRequest struct {
	PhoneNumber string `json:"phone_number"`
	Password 	string `json:"password"`
	FirstName 	string `json:"firstname"`
	LastName 	string `json:"lastname"`
	BirthDate 	string `json:"birthdate"`
	Gender 		string `json:"gender"`
}