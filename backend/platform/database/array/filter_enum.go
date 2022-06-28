package array

import (
	"database/sql/driver"
	"encoding/json"
)

type Filter string

const (
	womenOnly        Filter = "Women Only"
	childInCar       Filter = "Child in Car"
	familyCar        Filter = "Family Car"
	elderInCar       Filter = "Elder in Car"
	twentyYearsOldUp Filter = "20 Years Old Up"
)

var Filters = struct {
	WomenOnly        Filter
	ChildInCar       Filter
	FamilyCar        Filter
	ElderInCar       Filter
	TwentyYearsOldUp Filter
}{
	WomenOnly:        womenOnly,
	ChildInCar:       childInCar,
	FamilyCar:        familyCar,
	ElderInCar:       elderInCar,
	TwentyYearsOldUp: twentyYearsOldUp,
}

type FilterArray []Filter

func (sla *FilterArray) Scan(src interface{}) error {
	return json.Unmarshal([]byte(src.(string)), &sla)
}

func (sla FilterArray) Value() (driver.Value, error) {
	val, err := json.Marshal(sla)
	return string(val), err
}
