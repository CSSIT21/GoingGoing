package account

type Response struct {
	Success bool   `json:"success"`
	Token   string `json:"token"`
	Message string `json:"message"`
}
