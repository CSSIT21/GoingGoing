package database

type Parties struct {
	Id       *uint64 `gorm:"primaryKey"`
	DriverId *uint64 `gorm:"not null"`
	Driver   *User   `gorm:"foreignKey:DriverId"`
	MaxPsg   *uint64 `gorm:"not null"`
}
