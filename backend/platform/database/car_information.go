package database

type CarInformation struct {
	Id              *uint64 `gorm:"primaryKey" json:"id"`
	CarRegistration *string `gorm:"type:VARCHAR(20); not null" json:"car_registration"`
	CarBrand        *string `gorm:"type:VARCHAR(100); not null" json:"car_brand"`
	CarColor        *string `gorm:"type:VARCHAR(100); not null" json:"car_color"`
	OwnerId         *uint64 `gorm:"not null" json:"owner_id"`
	Owner           *User   `gorm:"foreignKey:OwnerId" json:"owner"`
}
