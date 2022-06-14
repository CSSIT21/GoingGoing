package configs

type config struct {
	Address     string
	Cors        []string
	JwtSecret   string
	PostgresDsn string
}
