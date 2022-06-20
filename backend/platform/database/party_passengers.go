package database

import "going-going-backend/platform/database/enum"

type PartyPassengers struct {
	Id          *uint64         `gorm:"primaryKey"`
	PartyId     *uint64         `gorm:"not null"`
	Party       *Parties        `gorm:"foreignKey:PartyId"`
	PassengerId *uint64         `gorm:"not null"`
	Passenger   *User           `gorm:"foreignKey:PassengerId"`
	Type        *enum.PartyType `gorm:"type:ENUM('temp', 'pending', 'confirmed'); not null"`
}
