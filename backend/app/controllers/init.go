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
	profile.Patch("info", Profile.PatchHandler)
	// * Driver
	driver := router.Group("driver/", Fiber.Jwt)
	driver.Get("info", Profile.GetDriverHandler)
	driver.Patch("", Profile.PatchDriverHandler)
	driver.Post("new", Profile.PostDriverHandler)

	// * Schedule
	schedule := router.Group("schedule/", Fiber.Jwt)
	schedule.Patch("set-end", Schedule.PatchIsEndHandler)
	schedule.Get("", Schedule.GetHandler)
	schedule.Get("search", Schedule.GetSearchHandler)

	// * Party
	party := router.Group("party/", Fiber.Jwt)
	party.Get(":id/check-is-requested", Party.GetIsRequestedHandler)
	party.Post(":id/request", Party.PostRequestHandler)
	party.Patch(":id/accept/:psg_id", Party.PatchAcceptHandler)
	party.Patch(":id/confirmed", Party.PatchConfirmedHandler)
	party.Delete(":id/cancel", Party.DeleteRequestHandler)

	// * History
	history := router.Group("history/", Fiber.Jwt)
	history.Get("", History.GetHandler)
}
