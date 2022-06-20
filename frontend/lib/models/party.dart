class Party {
  final int? id;
  final int maximumPassengers;
  final int driverId;
  // User driver;
  // User[] passengers;  (no need to store type since we will fetch specific type from db)

  const Party({
    this.id,
    required this.driverId,
    required this.maximumPassengers,
    // required this.driver,
    // required this.passengers,
  });

  Party.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        maximumPassengers = json["maximum_passengers"],
        driverId = json["driver_id"];
  // driver = json['driver'],
  // passengers = json['passengers'];

  Map<String, dynamic> toJson() => {
        "id": id,
        "maximum_passengers": maximumPassengers,
        "driver_id": driverId,
      };
}
