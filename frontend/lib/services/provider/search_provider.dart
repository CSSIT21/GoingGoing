import 'package:flutter/material.dart';

import '../../models/filter.dart';
import '../../models/google_api/place.dart';

class SearchProvider with ChangeNotifier {
  late Place _place;

  final Filters _filters = Filters([
    Filter(name: "Women Only", value: false),
    Filter(name: "Child in Car", value: false),
    Filter(name: "Family Car", value: false),
    Filter(name: "Elder in Car", value: false),
    Filter(name: "20 Years Old Up", value: false),
  ]);
  DateTime? _date;
  TimeOfDay? _time;
  int? _partySize;

  Place get place => _place;

  Filters get filters => _filters;

  DateTime? get date => _date;

  TimeOfDay? get time => _time;

  String get partySize {
    if (_partySize == null) {
      return "-";
    } else {
      return _partySize.toString();
    }
  }

  set place(Place place) {
    _place = place;
    notifyListeners();
  }

  set partySize(String? partySize) {
    _partySize = partySize == null ? null : int.parse(partySize);
    notifyListeners();
  }

  set date(DateTime? date) {
    _date = date;
    notifyListeners();
  }

  set time(TimeOfDay? time) {
    _time = time;
    notifyListeners();
  }

  void setFilters(String key, bool value) {
    _filters.setFilter(key, value);
    notifyListeners();
  }

  void clearAll() {
    for (var el in _filters.filters) {
      el.value = false;
    }
    _date = null;
    _time = null;
    _partySize = null;

    notifyListeners();
  }
}
