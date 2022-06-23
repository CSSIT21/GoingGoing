import 'user.dart';

class Party {
  final int? id;
  final int maximumPassengers;
  final int driverId;
  final User driver;
  final List<int> passengerIds; // (no need to store type since we will fetch specific type from db)

  Party({
    this.id,
    required this.driverId,
    required this.maximumPassengers,
    required this.driver,
    required this.passengerIds,
  });

  Party.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        maximumPassengers = json["maximum_passengers"],
        driverId = json["driver_id"],
        driver = json['driver'],
        passengerIds = json['passenger_id_list'];

  Map<String, dynamic> toJson() => {
        "id": id,
        "maximum_passengers": maximumPassengers,
        "driver_id": driverId,
        "passenger_id_list": passengerIds,
      };
}
