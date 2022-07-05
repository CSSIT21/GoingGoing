class CarInfo {
  int? id;
  String carRegis;
  String carBrand;
  String carColor;
  int ownerId;

  CarInfo({
    required this.carRegis,
    required this.carBrand,
    required this.carColor,
    required this.ownerId,
    this.id,
  });

  CarInfo.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        carRegis = json["car_registration"] ?? "",
        carBrand = json["car_brand"] ?? "",
        carColor = json["car_color"] ?? "",
        ownerId = json["owner_id"];

  Map<String, dynamic> toJson() => {
        "id": id,
        "car_registration": carRegis,
        "car_brand": carBrand,
        "car_color": carColor,
        "owner_id": ownerId,
      };
}
