import 'package:flutter/foundation.dart';
import '../../models/location.dart';
import '../../models/filter.dart';
import '../../models/party.dart';
import '../../models/schedule.dart';
import '../../models/user.dart';

class ScheduleProvider with ChangeNotifier {
  List<Schedule> _appointmentSchedules = [];
  // List<Schedule> _appointmentSchedules = [
  //   Schedule(
  //     id: 1,
  //     partyId: 1,
  //     party: Party(
  //       id: 1,
  //       driverId: 1,
  //       maximumPassengers: 4,
  //       driver: User(
  //         id: 1,
  //         firstname: 'John',
  //         lastname: 'Doe',
  //         gender: 'Female',
  //         birthdate: DateTime.now(),
  //         pathProfilePic: "",
  //       ),
  //       passengerIds: [1, 2],
  //     ),
  //     startTripDateTime: DateTime.now().add(const Duration(seconds: 30)),
  //     startLocationId: 1,
  //     startLocation: Location(lat: 13.2342, lng: 23.2342, address: "123", name: "123"),
  //     destinationLocationId: 2,
  //     destinationLocation:
  //         Location(lat: 13.2342, lng: 24.2342, address: "KMUTT, Bangmod", name: "KMUTT"),
  //     distance: 13.5,
  //     filter: Filters([Filter(name: "Woman Only")]),
  //   ),
  // ];

  List<Schedule> _historySchedules = [
    Schedule(
      id: 2,
      partyId: 2,
      party: Party(
        id: 2,
        driverId: 2,
        maximumPassengers: 6,
        driver: User(
          id: 1,
          firstname: 'John',
          lastname: 'Doe',
          gender: 'Female',
          birthdate: DateTime.now(),
          pathProfilePic: "",
        ),
        passengerIds: [1, 2],
      ),
      startTripDateTime: DateTime.now(),
      startLocationId: 3,
      startLocation: Location(
          lat: 13.2342, lng: 23.2342, address: "KMUTT, Bangmod", name: "KMUTT"),
      destinationLocationId: 4,
      destinationLocation: Location(
          lat: 13.2342, lng: 24.2342, address: "KMUTT, Bangmod", name: "KMUTT"),
      distance: 24,
      filter: Filters([Filter(name: "Women Only")]),
    ),
    Schedule(
      id: 2,
      partyId: 2,
      party: Party(
        id: 2,
        driverId: 2,
        maximumPassengers: 6,
        driver: User(
          id: 1,
          firstname: 'John',
          lastname: 'Doe',
          gender: 'Female',
          birthdate: DateTime.now(),
          pathProfilePic: "",
        ),
        passengerIds: [1, 2],
      ),
      startTripDateTime: DateTime.now(),
      startLocationId: 3,
      startLocation: Location(
          lat: 13.2342, lng: 23.2342, address: "KMUTT, Bangmod", name: "KMUTT"),
      destinationLocationId: 4,
      destinationLocation: Location(
          lat: 13.2342, lng: 24.2342, address: "KMUTT, Bangmod", name: "KMUTT"),
      distance: 24,
      filter: Filters([Filter(name: "Women Only")]),
    ),
  ];

  List<Schedule> _searchSchedules = [
    Schedule(
      id: 3,
      partyId: 1,
      party: Party(
        id: 1,
        driverId: 3,
        maximumPassengers: 4,
        driver: User(
          id: 1,
          firstname: 'John',
          lastname: 'Doe',
          gender: 'Female',
          birthdate: DateTime.now(),
          pathProfilePic: "",
        ),
        passengerIds: [1, 2],
      ),
      startTripDateTime: DateTime.now(),
      startLocationId: 1,
      startLocation: Location(
          lat: 13.6507151,
          lng: 100.4939209,
          address: "KMUTT, Bangmod",
          name: "KMUTT"),
      destinationLocationId: 2,
      destinationLocation: Location(
          lat: 13.6512522,
          lng: 100.4942541,
          address: "KMUTT, Bangmod",
          name: "KMUTT"),
      distance: 13.5,
      filter: Filters([Filter(name: "Women Only")]),
    ),
  ];

  List<Schedule> get appointmentSchedules => _appointmentSchedules;
  List<Schedule> get historySchedules => _historySchedules;
  List<Schedule> get searchSchedules => _searchSchedules;

  // use to fetch a schedule
  int selectedId = 0;

  set appointmentSchedules(List<Schedule> value) {
    _appointmentSchedules = value;
    notifyListeners();
  }

  set historySchedules(List<Schedule> value) {
    _historySchedules = value;
    notifyListeners();
  }

  set searchSchedules(List<Schedule> value) {
    _searchSchedules = value;
    notifyListeners();
  }

  Schedule getAppointmentScheduleById(int selectedId) {
    return _appointmentSchedules
        .firstWhere((schedule) => schedule.id == selectedId);
  }

  Schedule getHistoryScheduleById(int selectedId) {
    return _historySchedules
        .firstWhere((schedule) => schedule.id == selectedId);
  }

  Schedule getSearchScheduleById(int selectedId) {
    return _searchSchedules.firstWhere((schedule) => schedule.id == selectedId);
  }
}
