class History {
  int id;
  String name;
  String date;
  String time;
  String carRegistration;
  int partySize;
  String address;

  History(
      {required this.id,
      required this.name,
      required this.date,
      required this.time,
      required this.carRegistration,
      required this.partySize,
      required this.address});

  factory History.fromJson(Map<String, dynamic> json) {
    return History(
        id: json["id"],
        name: json["name"],
        date: json["date"],
        time: json["time"],
        carRegistration: json["car_registration"],
        partySize: json["party_size"],
        address: json["address"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "date": date,
      "time": time,
      "car_registration": carRegistration,
      "party_size": partySize,
      "address": address,
    };
  }
}
