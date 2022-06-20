class CarInfo {
  final String carRegis;
  final String carBrand;
  final String carColor;
 

  CarInfo(
    this.carRegis,
    this.carBrand,
    this.carColor,

  );

  CarInfo.fromJson(Map<String, dynamic> json) 
    : carRegis = json["car_registration"],
      carBrand = json["car_brand"],
      carColor = json["car_color"];

  Map<String, dynamic> toJson() =>{
    "car_registration" : carRegis,
    "car_brand" : carBrand,
    "car_color" : carColor,
  };

}