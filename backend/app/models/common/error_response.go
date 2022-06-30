package common

type ErrorInfoResponse struct {
	Success bool   `json:"success"`
	Code    string `json:"code,omitempty"`
	Message string `json:"message,omitempty"`
	Error   string `json:"error,omitempty"`
}

func ErrorResponse(msg string, err string) *ErrorInfoResponse {
	return &ErrorInfoResponse{
		Success: false,
		Code:    "999",
		Message: msg,
		Error:   err,
	}
}
