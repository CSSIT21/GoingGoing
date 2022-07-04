package history

import (
	"github.com/bearbin/go-age"
	"github.com/gofiber/fiber/v2"
	"github.com/golang-jwt/jwt/v4"
	"going-going-backend/app/models/common"
	"going-going-backend/app/models/dto/party"
	"going-going-backend/app/models/dto/profile"
	"going-going-backend/app/models/dto/schedule"
	"going-going-backend/pkg/utils/text"
	"going-going-backend/platform/database"
	"going-going-backend/platform/migrations"
)

func GetHandler(c *fiber.Ctx) error {
	// * Parse token
	token := c.Locals("user").(*jwt.Token)
	claims := token.Claims.(*common.UserClaim)

	// * Fetch party id list
	var partyIdList []*uint64
	if result := migrations.Gorm.Table("party_passengers").
		Select("party_id").
		Where("passenger_id = ?", claims.UserId).Scan(&partyIdList); result.Error != nil {
		return &common.GenericError{
			Message: "Error querying party id",
			Err:     result.Error,
		}
	}

	// * Fetch history schedules
	var historiesTemp []*database.Schedule
	if result := migrations.Gorm.
		Where("party_id IN ? AND is_end = true", partyIdList).
		Preload("Party.Driver").
		Preload("StartLocation").
		Preload("DestinationLocation").
		Order("start_trip_date_time").
		Find(&historiesTemp); result.Error != nil {
		return &common.GenericError{
			Message: "Error querying histories",
			Err:     result.Error,
		}
	}

	// * passenger_id_list and driver_id_list
	var histories []*schedule.Schedule
	var driverIdList []*uint64
	for _, val := range historiesTemp {
		var passengerIdList []*uint64
		if result := migrations.Gorm.Table("party_passengers").
			Select("passenger_id").
			Where("party_id = ? AND type = 'confirmed' ", val.PartyId).
			Find(&passengerIdList); result.Error != nil {
			return &common.GenericError{
				Message: "Error querying passengerIdList",
				Err:     result.Error,
			}
		}
		//spew.Dump(passengerIdList)
		var history *schedule.Schedule
		history = &schedule.Schedule{
			Id:      val.Id,
			PartyId: val.PartyId,
			Party: &party.Response{
				Id:       val.Party.Id,
				DriverId: val.Party.DriverId,
				Driver: &profile.Response{
					Id:                 *val.Party.Driver.Id,
					FirstName:          *val.Party.Driver.FirstName,
					LastName:           *val.Party.Driver.LastName,
					BirthDate:          *val.Party.Driver.BirthDate,
					Gender:             *val.Party.Driver.Gender,
					Age:                age.Age(*val.Party.Driver.BirthDate),
					PathProfilePicture: text.NilFallback(val.Party.Driver.PathProfilePicture),
				},
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
		histories = append(histories, history)

		// use to find car_information
		driverIdList = append(driverIdList, val.Party.DriverId)
	}

	if histories == nil {
		histories = []*schedule.Schedule{}
	}

	// * car_information
	var carDetails []*database.CarInformation
	for _, val := range driverIdList {
		var carDetail *database.CarInformation
		if result := migrations.Gorm.Distinct().
			Preload("Owner").
			Where("owner_id = ?", val).
			Find(&carDetail); result.Error != nil {
			return &common.GenericError{
				Message: "Error querying cars information",
				Err:     result.Error,
			}
		}
		carDetails = append(carDetails, carDetail)
	}

	// * response
	response := &schedule.Response{
		Schedules:      histories,
		CarInformation: carDetails,
	}

	return c.JSON(common.SuccessResponse(response))
}
