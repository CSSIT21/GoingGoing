package database

type Location struct {
	Id         *uint64     `gorm:"primaryKey"`
	Name       *string     `gorm:"type:VARCHAR(255); not null"`
	Address    *string     `gorm:"type:VARCHAR(255); not null"`
	Coordinate [2]*float64 `gorm:"not null"`
}
