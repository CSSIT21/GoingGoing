package enum

type Filter string

const (
	womanOnly        Filter = "Woman Only"
	childInCar       Filter = "Child in Car"
	familyCar        Filter = "Family Car"
	elderInCar       Filter = "Elder in Car"
	twentyYearsOldUp Filter = "20 Years Old Up"
)

var Filters = struct {
	WomanOnly        Filter
	ChildInCar       Filter
	FamilyCar        Filter
	ElderInCar       Filter
	TwentyYearsOldUp Filter
}{
	WomanOnly:        womanOnly,
	ChildInCar:       childInCar,
	FamilyCar:        familyCar,
	ElderInCar:       elderInCar,
	TwentyYearsOldUp: twentyYearsOldUp,
}
