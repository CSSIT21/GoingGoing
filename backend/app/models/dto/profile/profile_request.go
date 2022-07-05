package profile

import "time"

type RequestBody struct {
	FirstName          string    `json:"firstname"`
	LastName           string    `json:"lastname"`
	BirthDate          time.Time `json:"birthdate"`
	Gender             string    `json:"gender"`
	PathProfilePicture string    `json:"path_profile_picture"`
}
