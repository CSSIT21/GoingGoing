package database

import "time"

type User struct {
	Id                 *uint64 `gorm:"primaryKey"`
	FirstName          *string `gorm:"type:VARCHAR(255); not null"`
	LastName           *string `gorm:"type:VARCHAR(255); not null"`
	PhoneNumber        *string `gorm:"type:VARCHAR(11); not null"`
	Password           *string `gorm:"type:VARCHAR(255); not null"`
	Gender             *string `gorm:"type:VARCHAR(20); not null"`
	CreatedAt          *time.Time
	BirthDate          *time.Time
	PathProfilePicture *string `gorm:"type:VARCHAR(255)"`
}
