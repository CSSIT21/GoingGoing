import '../schedule.dart';
import '../car_info.dart';

class ScheduleResponse {
  List<Schedule> schedules;
  List<CarInfo> carInfos;

  ScheduleResponse({required this.schedules, required this.carInfos});
}
