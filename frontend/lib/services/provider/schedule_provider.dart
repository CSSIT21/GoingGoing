import 'package:flutter/foundation.dart';
import '../../models/location.dart';
import '../../models/filter.dart';
import '../../models/party.dart';
import '../../models/schedule.dart';

class ScheduleProvider with ChangeNotifier {
  List<Schedule> _homeSchedules = [
    Schedule(
      id: 1,
      partyId: 1,
      party: const Party(
        id: 1,
        driverId: 1,
        maximumPassengers: 4,
      ),
      startTripDateTime: DateTime.now().add(const Duration(seconds: 30)),
      startLocationId: 1,
      startLocation: Location(lat: 13.2342, lng: 23.2342, address: "123", name: "123"),
      destinationLocationId: 2,
      destinationLocation:
          Location(lat: 13.2342, lng: 24.2342, address: "KMUTT, Bangmod", name: "KMUTT"),
      distance: 13.5,
      filter: Filters([Filter(name: "Woman Only")]),
    ),
  ];

  List<Schedule> _historySchedules = [
    Schedule(
      id: 2,
      partyId: 2,
      party: const Party(
        id: 2,
        driverId: 2,
        maximumPassengers: 6,
      ),
      startTripDateTime: DateTime.now(),
      startLocationId: 3,
      startLocation: Location(lat: 13.2342, lng: 23.2342, address: "KMUTT, Bangmod", name: "KMUTT"),
      destinationLocationId: 4,
      destinationLocation:
          Location(lat: 13.2342, lng: 24.2342, address: "KMUTT, Bangmod", name: "KMUTT"),
      distance: 24,
      filter: Filters([Filter(name: "Woman Only")]),
    ),
  ];

  List<Schedule> _searchSchedules = [
    Schedule(
      id: 3,
      partyId: 1,
      party: const Party(
        id: 1,
        driverId: 1,
        maximumPassengers: 4,
      ),
      startTripDateTime: DateTime.now(),
      startLocationId: 1,
      startLocation: Location(lat: 13.2342, lng: 23.2342, address: "KMUTT, Bangmod", name: "KMUTT"),
      destinationLocationId: 2,
      destinationLocation:
          Location(lat: 13.2342, lng: 24.2342, address: "KMUTT, Bangmod", name: "KMUTT"),
      distance: 13.5,
      filter: Filters([Filter(name: "Woman Only")]),
    ),
  ];

  List<Schedule> get homeSchedules => _homeSchedules;
  List<Schedule> get historySchedules => _historySchedules;
  List<Schedule> get searchSchedules => _searchSchedules;

  // use to fetch a schedule to show in offer detail screen
  int selectedId = 0;

  Map<String, double> _prices = {'total': 0.0, 'price': 0.0};
  Map<String, double> get prices => _prices;

  // void setSelectedId(int id) {
  //   selectedId = id;
  // }

  void setPrices(Map<String, double> prices) {
    _prices = prices;
  }

  set homeSchedules(List<Schedule> value) {
    _homeSchedules = value;
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
}
