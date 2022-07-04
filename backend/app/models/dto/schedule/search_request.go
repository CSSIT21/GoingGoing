package schedule

type SearchRequestQuery struct {
	Name    string `query:"name"`
	Address string `query:"address"`
}
