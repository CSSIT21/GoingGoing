package schedule

import (
	"going-going-backend/app/models/common"
	"going-going-backend/app/models/dto/party"
	"going-going-backend/app/models/dto/profile"
	"going-going-backend/app/models/dto/schedule"
	"going-going-backend/pkg/utils/text"
	"going-going-backend/platform/database"
	"going-going-backend/platform/migrations"
	"strings"
	"time"

	"github.com/bearbin/go-age"
	"github.com/gofiber/fiber/v2"
)

func GetSearchHandler(c *fiber.Ctx) error {
	// * Parse Query
	query := new(schedule.SearchRequestQuery)
	if err := c.QueryParser(query); err != nil {
		return &common.GenericError{
			Message: "Unable to parse query",
			Err:     err,
		}
	}

	// * Fetch destination location id list
	var locationIdList []*uint64
	if result := migrations.Gorm.Model(new(database.Location)).
		Select("id").
		Where("name = ?", query.Name).
		Scan(&locationIdList); result.RowsAffected == 0 {
		if result := migrations.Gorm.Model(new(database.Location)).
			Select("id").
			Where("address LIKE ?", "%"+strings.Split(query.Address, ",")[0]+"%").
			Or("address LIKE ?", "%"+strings.Split(query.Address, ",")[1]+"%").
			Scan(&locationIdList); result.Error != nil {
			return &common.GenericError{
				Message: "Error querying location id list from address",
				Err:     result.Error,
			}
		}
	} else if result.Error != nil {
		return &common.GenericError{
			Message: "Error querying location id list from name",
			Err:     result.Error,
		}
	}

	// * Fetch schedules from address
	var tempSchedules []*database.Schedule
	if result := migrations.Gorm.
		Preload("DestinationLocation").
		Preload("Party.Driver").
		Preload("StartLocation").
		Find(&tempSchedules, "destination_location_id IN ? AND start_trip_date_time < ? AND is_end = false", locationIdList, time.Now().UTC()); result.Error != nil {
		return &common.GenericError{
			Message: "Error querying appointments",
			Err:     result.Error,
		}
	}

	// * Get passenger id list and driver id list
	schedules := make([]*schedule.Schedule, 0)
	var driverIdList []*uint64
	for _, val := range tempSchedules {
		var passengerIdList []*uint64
		if result := migrations.Gorm.Table("party_passengers").
			Select("passenger_id").
			Where("party_id = ? AND type = 'temp' ", val.PartyId).
			Find(&passengerIdList); result.Error != nil {
			return &common.GenericError{
				Message: "Error querying passengerIdList",
				Err:     result.Error,
			}
		}

		offer := new(schedule.Schedule)
		offer = &schedule.Schedule{
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
		schedules = append(schedules, offer)

		// use to find car_information
		driverIdList = append(driverIdList, val.Party.DriverId)
	}

	// * Fetch car information list
	carDetails := make([]*database.CarInformation, 0)
	for _, val := range driverIdList {
		carDetail := new(database.CarInformation)

		if result := migrations.Gorm.Distinct().
			Preload("Owner").
			Where("owner_id = ?", val).
			Find(carDetail); result.Error != nil {
			return &common.GenericError{
				Message: "Error querying cars information",
				Err:     result.Error,
			}
		}
		carDetails = append(carDetails, carDetail)
	}

	// * response
	response := &schedule.Response{
		Schedules:      schedules,
		CarInformation: carDetails,
	}

	return c.JSON(common.SuccessResponse(response))
}
