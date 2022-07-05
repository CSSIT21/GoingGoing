package account

type LoginRequestBody struct {
	PhoneNumber string `json:"phone_number"`
	Password    string `json:"password"`
}
