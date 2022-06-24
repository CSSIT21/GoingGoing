import 'location.dart';
import 'party.dart';
import 'filter.dart';

class Schedule {
  final int? id;
  final int partyId;
  final Party party;
  final DateTime startTripDateTime;
  final int startLocationId;
  final Location startLocation;
  final int destinationLocationId;
  final Location destinationLocation;
  final double distance;
  final Filters filter;
  final bool isEnd;

  const Schedule({
    this.id,
    required this.partyId,
    required this.party,
    required this.startTripDateTime,
    required this.startLocationId,
    required this.startLocation,
    required this.destinationLocationId,
    required this.destinationLocation,
    required this.distance,
    required this.filter,
    this.isEnd = false,
  });

  Schedule.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        partyId = json["party_id"],
        party = Party.fromJson(json["party"]),
        startTripDateTime = DateTime.parse(json["start_trip_date_time"]),
        startLocationId = json["start_location_id"],
        startLocation = Location.fromJson(json["start_location"]),
        destinationLocationId = json["destination_location_id"],
        destinationLocation = Location.fromJson(json["destination_location"]),
        distance = double.parse(json["distance"].toString()),
        filter = json["filter"] != null
            ? Filters.fromJson(json["filter"])
            : Filters([
                Filter(name: "Women Only", value: false),
                Filter(name: "Child in Car", value: false),
                Filter(name: "Family Car", value: false),
                Filter(name: "Elder in Car", value: false),
                Filter(name: "20 Years Old Up", value: false),
              ]),
        isEnd = json["is_end"];

  Map<String, dynamic> toJson() => {
        "id": id,
        "party_id": partyId,
        "party": party.toJson(),
        "start_trip_date_time": startTripDateTime.toIso8601String(),
        "start_location_id": startLocationId,
        "start_location": startLocation.toJson(),
        "destination_location_id": destinationLocationId,
        "destination_location": destinationLocation.toJson(),
        "distance": distance.toString(),
        "filter": filter.toJson(),
        "is_end": isEnd,
      };
}
