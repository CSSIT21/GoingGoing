import 'package:flutter/foundation.dart';

import '../../models/schedule.dart';

class ScheduleProvider with ChangeNotifier {
  List<Schedule> _appointmentSchedules = [];
  List<Schedule> _historySchedules = [];
  List<Schedule> _searchSchedules = [];

  List<Schedule> get appointmentSchedules => _appointmentSchedules;

  List<Schedule> get historySchedules => _historySchedules;

  List<Schedule> get searchSchedules => _searchSchedules;

  // * Use to fetch a schedule
  int selectedId = 0;
  String selectedRoute = '';

  set appointmentSchedules(List<Schedule> value) {
    _appointmentSchedules = value;
    notifyListeners();
  }

  set historySchedules(List<Schedule> value) {
    _historySchedules = value;
    notifyListeners();
  }

  set searchSchedules(List<Schedule> value) {
    _searchSchedules = value;
    notifyListeners();
  }

  Schedule getAppointmentScheduleById(int selectedId) {
    return _appointmentSchedules
        .firstWhere((schedule) => schedule.id == selectedId);
  }

  Schedule getHistoryScheduleById(int selectedId) {
    return _historySchedules
        .firstWhere((schedule) => schedule.id == selectedId);
  }

  Schedule getSearchScheduleById(int selectedId) {
    return _searchSchedules.firstWhere((schedule) => schedule.id == selectedId);
  }
}
