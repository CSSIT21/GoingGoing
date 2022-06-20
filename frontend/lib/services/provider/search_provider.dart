import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

import '../../models/filter.dart';

class SearchProvider with ChangeNotifier {
  final Filters _filter = Filters([
    Filter(name: "Woman Only"),
    Filter(name: "Child in Car"),
    Filter(name: "Family Car"),
    Filter(name: "Elder in Car"),
    Filter(name: "20 Years Old Up"),
  ]);
  DateTime _appointmentDateTime = DateTime.now();
  int _partySize = 2;
  String locationName = "";

  Filters get filter => _filter;
  String get partySize => _partySize.toString();
  String get date => DateFormat('dd-MM-yyyy').format(_appointmentDateTime);
  String get time => DateFormat.jm().format(_appointmentDateTime);

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
