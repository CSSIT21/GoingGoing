package enum

type PartyType string

const (
	temp      Filter = "temp"
	pending   Filter = "pending"
	confirmed Filter = "confirmed"
)

var PartyTypes = struct {
	Temp      Filter
	Pending   Filter
	Confirmed Filter
}{
	Temp:      temp,
	Pending:   pending,
	Confirmed: confirmed,
}
