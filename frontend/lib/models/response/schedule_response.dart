import '../schedule.dart';
import '../car_info.dart';

class ScheduleResponse {
  List<Schedule> schedules;
  List<CarInfo> carInfoList;

  ScheduleResponse({required this.schedules, required this.carInfoList});
}
