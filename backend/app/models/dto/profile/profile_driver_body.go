package profile


type ProfileDriverBody struct {
	CarRegistration    string    `json:"car_registration"`
	CarBrand           string    `json:"car_brand"`
	CarColor           string    `json:"car_color"`
}