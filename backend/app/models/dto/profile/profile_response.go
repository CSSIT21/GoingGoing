package profile

import "time"

type Response struct {
	Id                 uint64    `json:"id"`
	FirstName          string    `json:"firstname"`
	LastName           string    `json:"lastname"`
	BirthDate          time.Time `json:"birthdate"`
	Gender             string    `json:"gender"`
	Age                int       `json:"age"`
	PathProfilePicture string    `json:"path_profile_picture"`
}
