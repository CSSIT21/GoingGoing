package database

import "going-going-backend/platform/database/enum"

type PartyPassengers struct {
	Id          *uint64         `gorm:"primaryKey" json:"id"`
	PartyId     *uint64         `gorm:"not null" json:"party_id"`
	Party       *Parties        `gorm:"foreignKey:PartyId" json:"party"`
	PassengerId *uint64         `gorm:"not null" json:"passenger_id"`
	Passenger   *User           `gorm:"foreignKey:PassengerId" json:"passenger"`
	Type        *enum.PartyType `gorm:"type:VARCHAR(10); default:'pending'; not null" json:"type"`
}
