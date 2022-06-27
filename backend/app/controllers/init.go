package controllers

import (
	"github.com/gofiber/fiber/v2"
	Account "going-going-backend/app/models/endpoints/account"
	History "going-going-backend/app/models/endpoints/history"
	Party "going-going-backend/app/models/endpoints/party"
	Profile "going-going-backend/app/models/endpoints/profile"
	Schedule "going-going-backend/app/models/endpoints/schedule"
	Fiber "going-going-backend/pkg/fiber/middlewares"
)

func Init(router fiber.Router) {
	// * Account
	account := router.Group("account/")
	account.Post("login", Account.Login)
	account.Post("register", Account.Register)

	// * Profile
	profile := router.Group("profile/", Fiber.Jwt)
	profile.Get("", Profile.GetHandler)
	profile.Patch("", Profile.PatchHandler)
	profile.Get("driver", Profile.GetDriverHandler)
	profile.Patch("driver", Profile.PatchDriverHandler)
	profile.Post("driver/post", Profile.PostDriverHandler)

	// * Schedule
	schedule := router.Group("schedule/", Fiber.Jwt)
	schedule.Post("", Schedule.PostHandler)
	schedule.Patch("is_end", Schedule.PatchIsEndHandler)
	schedule.Get("", Schedule.GetHandler)
	schedule.Get("search", Schedule.GetSearchHandler)

	// * Party
	party := router.Group("party/", Fiber.Jwt)
	party.Patch("temp", Party.PatchTempHandler)
	party.Patch("pending", Party.PatchPendingHandler)
	party.Patch("confirmed", Party.PatchConfirmedHandler)

	// * History
	history := router.Group("history/", Fiber.Jwt)
	history.Get("", History.GetHandler)
}
