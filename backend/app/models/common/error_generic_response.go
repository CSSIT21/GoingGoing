package common

type GenericError struct {
	Success bool   `json:"success"`
	Code    string `json:"code"`
	Message string `json:"message"`
	Err     error  `json:"error"`
}

func (v *GenericError) Error() string {
	return v.Message
}
