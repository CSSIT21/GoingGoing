// * Offer card info
class OfferCardInfo {
  int id;
  String name;
  String date;
  String time;
  String carRegistration;
  int partySize;
  String address;

  OfferCardInfo(
      {required this.id,
      required this.name,
      required this.date,
      required this.time,
      required this.carRegistration,
      required this.partySize,
      required this.address});

  factory OfferCardInfo.fromJson(Map<String, dynamic> json) {
    return OfferCardInfo(
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

// * Appointment card info
class AppointmentCardInfo {
  int id;
  String type;
  String date;
  String time;
  String carRegistration;
  int partySize;
  String address;
  DateTime startTripDateTime;

  AppointmentCardInfo(
      {required this.id,
      required this.type,
      required this.date,
      required this.time,
      required this.carRegistration,
      required this.partySize,
      required this.address,
      required this.startTripDateTime});

  factory AppointmentCardInfo.fromJson(Map<String, dynamic> json) {
    return AppointmentCardInfo(
        id: json["id"],
        type: json["type"],
        date: json["date"],
        time: json["time"],
        carRegistration: json["car_registration"],
        partySize: json["party_size"],
        address: json["address"],
        startTripDateTime: json["Start_trip_date_time"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "type": type,
      "date": date,
      "time": time,
      "car_registration": carRegistration,
      "party_size": partySize,
      "address": address,
      "Start_trip_date_time": startTripDateTime
    };
  }
}
