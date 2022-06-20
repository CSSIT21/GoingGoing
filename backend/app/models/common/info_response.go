package common

type InfoResponse struct {
	Success bool        `json:"success"`
	Message string      `json:"message,omitempty"`
	Data    interface{} `json:"data,omitempty"`
}

//func SuccessResponse(data any, msg string) *InfoResponse {
//	return &InfoResponse{
//		Success: true,
//		Message: msg,
//		Data:    data,
//	}
//}
