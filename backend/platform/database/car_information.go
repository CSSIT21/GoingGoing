package database

type CarInformation struct {
	Id              *uint64 `gorm:"primaryKey"`
	CarRegistration *string `gorm:"type:VARCHAR(20); not null"`
	CarBrand        *string `gorm:"type:VARCHAR(100); not null"`
	CarColor        *string `gorm:"type:VARCHAR(100); not null"`
	OwnerId         *uint64 `gorm:"not null"`
	Owner           *User   `gorm:"foreignKey:OwnerId"`
}
