package schedule

import (
	"github.com/davecgh/go-spew/spew"
	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v4"
	"going-going-backend/app/models/common"
	"going-going-backend/app/models/dto/party"
	"going-going-backend/app/models/dto/schedule"
	"going-going-backend/platform/database"
	"going-going-backend/platform/migrations"
)

func GetHandler(c *fiber.Ctx) error {
	// * Parse cookie
	cookie := c.Locals("user").(*jwt.Token)
	claims := cookie.Claims.(*common.UserClaim)

	// * party_id_list
	var partyIdList []*uint64
	if result := migrations.Gorm.Table("party_passengers").
		Select("party_id").
		Where("passenger_id = ?", claims.UserId).Scan(&partyIdList); result.Error != nil {
		return c.JSON(common.ErrorResponse("Error querying party_id", result.Error.Error()))
	}
	spew.Dump(partyIdList)

	// * appointments
	var appointmentTemp []*database.Schedule
	if result := migrations.Gorm.
		Where("party_id IN ?", partyIdList).
		Preload("Party.Driver").
		Preload("StartLocation").
		Preload("DestinationLocation").
		Find(&appointmentTemp); result.Error != nil {
		return c.JSON(common.ErrorResponse("Error querying histories", result.Error.Error()))
	}

	// party เพิ่ม driver_info and partyPsg
	// * passenger_id_list and driver_id_list
	var appointments []*schedule.Schedules
	var driverIdList []*uint64
	for _, val := range appointmentTemp {
		var passengerIdList []*uint64
		if result := migrations.Gorm.Table("party_passengers").
			Select("id").
			Where("party_id = ? AND type = 'confirmed' ", val.PartyId).
			Find(&passengerIdList); result.Error != nil {
			return c.JSON(common.ErrorResponse("Error querying passengerIdList", result.Error.Error()))
		}
		//spew.Dump(passengerIdList)
		var appointment *schedule.Schedules
		appointment = &schedule.Schedules{
			Id:      val.Id,
			PartyId: val.PartyId,
			Party: &party.Parties{
				Id:              val.Party.Id,
				DriverId:        val.Party.DriverId,
				Driver:          val.Party.Driver,
				MaxPsg:          val.Party.MaxPsg,
				PassengerIdList: passengerIdList,
			},
			StartTripDateTime:     val.StartTripDateTime,
			StartLocationId:       val.StartLocationId,
			StartLocation:         val.StartLocation,
			DestinationLocationId: val.DestinationLocationId,
			DestinationLocation:   val.DestinationLocation,
			Distance:              val.Distance,
			IsEnd:                 val.IsEnd,
			Filters:               val.Filters,
		}
		appointments = append(appointments, appointment)

		// use to find car_information
		driverIdList = append(driverIdList, val.Party.DriverId)
	}

	// * car_information
	var carDetails []*database.CarInformation
	if result := migrations.Gorm.Distinct().
		Preload("Owner").
		Where("owner_id IN ?", driverIdList).
		Order("id").
		Find(&carDetails); result.Error != nil {
		return c.JSON(common.ErrorResponse("Error querying cars information", result.Error.Error()))
	}
	// spew.Dump(carDetails)

	// * response
	response := &schedule.Response{
		Schedules:      appointments,
		CarInformation: carDetails,
	}

	return c.JSON(common.SuccessResponse(response, "Querying is success"))
}
