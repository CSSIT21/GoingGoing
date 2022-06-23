import 'package:flutter/foundation.dart';
import '../../models/car_info.dart';

class CarInfoProvider with ChangeNotifier {
  CarInfo _userCarInfo = CarInfo(
    id: 1,
    carRegis: "ABC-123",
    carBrand: "Toyota",
    carColor: "Black",
    ownerId: 3,
  );

  List<CarInfo> _appointmentCarInfos = [
    CarInfo(carRegis: "AB-1234", carBrand: "Toyota", carColor: "Red", ownerId: 1),
    CarInfo(carRegis: "CD-4567", carBrand: "Honda Civic", carColor: "White", ownerId: 2),
  ];

  List<CarInfo> _historyCarInfos = [
    CarInfo(carRegis: "EF-7890", carBrand: "Toyota", carColor: "Red", ownerId: 1),
    CarInfo(carRegis: "GH-5678", carBrand: "Honda Civic", carColor: "White", ownerId: 2),
  ];

  List<CarInfo> _searchCarInfos = [
    CarInfo(carRegis: "IJ-9012", carBrand: "Toyota", carColor: "Red", ownerId: 3),
    CarInfo(carRegis: "KL-3456", carBrand: "Honda Civic", carColor: "White", ownerId: 4),
  ];

  CarInfo get userCarInfo => _userCarInfo;
  List<CarInfo> get appointmentCarInfos => _appointmentCarInfos;
  List<CarInfo> get historyCarInfos => _historyCarInfos;
  List<CarInfo> get searchCarInfos => _searchCarInfos;

  set userCarInfo(CarInfo carInfo) {
    _userCarInfo = carInfo;
    notifyListeners();
  }

  set appointmentCarInfos(List<CarInfo> carInfos) {
    _appointmentCarInfos = carInfos;
    notifyListeners();
  }

  set historyCarInfos(List<CarInfo> carInfos) {
    _historyCarInfos = carInfos;
    notifyListeners();
  }

  set searchCarInfos(List<CarInfo> carInfos) {
    _searchCarInfos = carInfos;
    notifyListeners();
  }
}
