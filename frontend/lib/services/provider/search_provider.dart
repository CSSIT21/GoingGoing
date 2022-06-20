import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../../models/filter.dart';
import '../../models/location.dart';

class SearchProvider with ChangeNotifier {
  final Location _location = Location(
    lat: 0.0,
    lng: 0.0,
    name: "",
    address: "",
  );
  final Filters _filter = Filters([
    Filter(name: "Woman Only"),
    Filter(name: "Child in Car"),
    Filter(name: "Family Car"),
    Filter(name: "Elder in Car"),
    Filter(name: "20 Years Old Up"),
  ]);
  DateTime _appointmentDateTime = DateTime.now();
  int _partySize = 2;

  Location get location => _location;
  double get lat => _location.lat;
  double get lng => _location.lng;
  String get name => _location.name;
  String get address => _location.address;

  Filters get filter => _filter;

  String get partySize => _partySize.toString();

  String get date => DateFormat('dd-MM-yyyy').format(_appointmentDateTime);
  String get time => DateFormat.jm().format(_appointmentDateTime);

  set name(String name) {
    _location.name = name;
  }

  set address(String address) {
    _location.address = address;
  }

  set lat(double lat) {
    _location.lat = lat;
  }

  set lng(double lng) {
    _location.lng = lng;
  }

  set partySize(String partySize) {
    _partySize = int.parse(partySize);
  }

  set date(String date) {
    _appointmentDateTime = DateTime.parse('$date $time');
  }

  set time(String time) {
    _appointmentDateTime = DateTime.parse('$date $time');
  }

  void setFilters(String key, bool value) {
    _filter.setFilter(key, value);
    notifyListeners();
  }
}
