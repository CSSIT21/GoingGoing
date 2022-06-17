// ignore_for_file: prefer_final_fields

import 'package:flutter/foundation.dart';

class SearchProvider with ChangeNotifier {
  String _name = "";
  String _address = "";
  String _scheduleId = "";

  String get name => _name;
  String get address => _address;
  String get scheduleId => _scheduleId;

  set name(String value) {
    _name = value;
    notifyListeners();
  }

  set address(String value) {
    _address = value;
    notifyListeners();
  }

  set scheduleId(String value) {
    _scheduleId = value;
    notifyListeners();
  }
}
