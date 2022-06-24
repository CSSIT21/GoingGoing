package database

import "going-going-backend/platform/database/enum"

type Location struct {
	Id         *uint64         `gorm:"primaryKey" json:"id"`
	Name       *string         `gorm:"type:VARCHAR(255); not null" json:"name"`
	Address    *string         `gorm:"type:VARCHAR(255); not null" json:"address"`
	Coordinate enum.Coordinate `gorm:"type:string;" json:"coordinate"`
}
