import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../../models/filter.dart';

class SearchProvider with ChangeNotifier {
  final Filters _filters = Filters([
    Filter(name: "Women Only", value: false),
    Filter(name: "Child in Car", value: false),
    Filter(name: "Family Car", value: false),
    Filter(name: "Elder in Car", value: false),
    Filter(name: "20 Years Old Up", value: false),
  ]);
  DateTime _appointmentDateTime = DateTime.now();
  int _partySize = 2;
  String locationName = "";

  Filters get filters => _filters;
  String get partySize => _partySize.toString();
  String get date => DateFormat('dd-MM-yyyy').format(_appointmentDateTime);
  String get time => DateFormat.jm().format(_appointmentDateTime);

  set partySize(String partySize) {
    _partySize = int.parse(partySize);
    notifyListeners();
  }

  set date(String date) {
    _appointmentDateTime = DateTime.parse('$date $time');
    notifyListeners();
  }

  set time(String time) {
    _appointmentDateTime = DateTime.parse('$date $time');
    notifyListeners();
  }

  void setFilters(String key, bool value) {
    _filters.setFilter(key, value);
    notifyListeners();
  }
}
