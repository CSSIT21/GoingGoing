import 'package:flutter/foundation.dart';

class CarInfoProvider with ChangeNotifier {
  String _carRegis = "AB-1234";
  String _carBrand = "Honda Civic";
  String _carColor = "White";
  
  
  String get carRegis => _carRegis;
  String get carBrand => _carBrand;
  String get carColor => _carColor;


  set carRegis(String value) {
    _carRegis = value;
    notifyListeners();
  }

  set carBrand(String value) {
    _carBrand = value;
    notifyListeners();
  }

  set carColor(String value) {
    _carColor = value;
    notifyListeners();
  }

}  



