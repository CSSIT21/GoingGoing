package database

import "time"

type User struct {
	Id                 *uint64    `gorm:"primaryKey" json:"id"`
	FirstName          *string    `gorm:"type:VARCHAR(255); not null" json:"firstname"`
	LastName           *string    `gorm:"type:VARCHAR(255); not null" json:"lastname"`
	PhoneNumber        *string    `gorm:"type:VARCHAR(11); not null" json:"phone_number"`
	Password           *string    `gorm:"type:VARCHAR(255); not null" json:"password"`
	Gender             *string    `gorm:"type:VARCHAR(20); not null" json:"gender"`
	CreatedAt          *time.Time `json:"created_at"`
	BirthDate          *time.Time `json:"birthdate"`
	PathProfilePicture *string    `gorm:"type:VARCHAR(255)" json:"path_profile_picture"`
}
