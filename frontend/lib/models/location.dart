class Location {
  int? id;
  double lat;
  double lng;
  String name;
  String address;

  Location({
    this.id,
    required this.lat,
    required this.lng,
    this.name = "",
    this.address = "",
  });

  Location.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        lat = double.parse(json["lat"]),
        lng = double.parse(json["lng"]),
        name = json["name"],
        address = json["address"];

  Map<String, dynamic> toJson() => {
        "id": id,
        "coordinate": [lat, lng],
        "name": name,
        "address": address,
      };
}
