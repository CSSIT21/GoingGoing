import 'package:flutter/foundation.dart';

import '../../models/car_info.dart';

class CarInfoProvider with ChangeNotifier {
  CarInfo _userCarInfo = CarInfo(
    id: 1,
    carRegis: "",
    carBrand: "",
    carColor: "",
    ownerId: 3,
  );

  List<CarInfo> _appointmentCarInfoList = [];

  List<CarInfo> _historyCarInfoList = [
    CarInfo(
        carRegis: "EF-7890", carBrand: "Toyota", carColor: "Red", ownerId: 1),
    CarInfo(
        carRegis: "GH-5678",
        carBrand: "Honda Civic",
        carColor: "White",
        ownerId: 2),
  ];

  List<CarInfo> _searchCarInfoList = [
    CarInfo(
        carRegis: "IJ-9012", carBrand: "Toyota", carColor: "Red", ownerId: 3),
    CarInfo(
        carRegis: "KL-3456",
        carBrand: "Honda Civic",
        carColor: "White",
        ownerId: 4),
  ];

  CarInfo get userCarInfo => _userCarInfo;

  List<CarInfo> get appointmentCarInfoList => _appointmentCarInfoList;

  List<CarInfo> get historyCarInfoList => _historyCarInfoList;

  List<CarInfo> get searchCarInfoList => _searchCarInfoList;

  set userCarInfo(CarInfo carInfo) {
    _userCarInfo = carInfo;
    notifyListeners();
  }

  set appointmentCarInfoList(List<CarInfo> carInfoList) {
    _appointmentCarInfoList = carInfoList;
    notifyListeners();
  }

  set historyCarInfoList(List<CarInfo> carInfoList) {
    _historyCarInfoList = carInfoList;
    notifyListeners();
  }

  set searchCarInfoList(List<CarInfo> carInfoList) {
    _searchCarInfoList = carInfoList;
    notifyListeners();
  }

  CarInfo getAppointmentCarInfoById(int driverId) {
    return _appointmentCarInfoList
        .firstWhere((carInfo) => carInfo.ownerId == driverId);
  }

  CarInfo getHistoryCarInfoById(int driverId) {
    return _historyCarInfoList
        .firstWhere((carInfo) => carInfo.ownerId == driverId);
  }

  CarInfo getSearchCarInfoById(int driverId) {
    return _searchCarInfoList
        .firstWhere((carInfo) => carInfo.ownerId == driverId);
  }
}
