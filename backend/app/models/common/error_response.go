package common

type ErrorInfoResponse struct {
	Success bool   `json:"success"`
	Code    string `json:"code"`
	Message string `json:"message"`
	Error   string `json:"error"`
}

func ErrorResponse(msg string, err string) *ErrorInfoResponse {
	return &ErrorInfoResponse{
		Success: false,
		Code:    "999",
		Message: msg,
		Error:   err,
	}
}
