package profile

type ProfileDriverBody struct {
	Id              uint64 `json:"id"`
	CarRegistration string `json:"car_registration"`
	CarBrand        string `json:"car_brand"`
	CarColor        string `json:"car_color"`
	OwnerId         uint64 `json:"owner_id"`
}
