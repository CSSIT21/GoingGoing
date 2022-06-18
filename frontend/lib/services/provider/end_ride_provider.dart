import 'package:flutter/foundation.dart';

class EndRideProvider with ChangeNotifier {
  double _total = 0;
  double _price = 0;
  int _partySize = 0;

  double get total => _total;
  double get price => _price;
  int get partySize => _partySize;

  set partySize(int value) {
    _partySize = value;
    notifyListeners();
  }

  void totalAndPrice(double distance) {
    _total = distance * 35.00;
    _price = _total/_partySize;
    notifyListeners();
  }
}
