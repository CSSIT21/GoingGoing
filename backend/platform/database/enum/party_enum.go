package enum

type PartyType string

const (
	temp      PartyType = "temp"
	pending   PartyType = "pending"
	confirmed PartyType = "confirmed"
)

var PartyTypes = struct {
	Temp      PartyType
	Pending   PartyType
	Confirmed PartyType
}{
	Temp:      temp,
	Pending:   pending,
	Confirmed: confirmed,
}
