package database

type Parties struct {
	Id       *uint64 `gorm:"primaryKey" json:"id"`
	DriverId *uint64 `gorm:"not null" json:"driver_id"`
	Driver   *User   `gorm:"foreignKey:DriverId" json:"driver"`
	MaxPsg   *uint64 `gorm:"not null" json:"maximum_passengers"`
}
