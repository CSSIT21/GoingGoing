package enum

import "encoding/json"

type Coordinate [2]float64

func (sla *Coordinate) Scan(src interface{}) error {
	return json.Unmarshal([]byte(src.(string)), &sla)
}
