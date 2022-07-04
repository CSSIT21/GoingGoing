import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'dio_service.dart';
import '../provider/schedule_provider.dart';
import '../../models/car_info.dart';
import '../../models/response/schedule_response.dart';
import '../../models/response/common/error_info_response.dart';
import '../../models/response/common/info_response.dart';
import '../../models/schedule.dart';
import '../../widgets/common/alert_dialog.dart';

class ScheduleApi {
  static Future<ScheduleResponse?> getAppointmentSchedules(
      BuildContext context) async {
    try {
      final response = await DioClient.dio.get('/schedule/');
      if (response.statusCode == 200) {
        InfoResponse res = InfoResponse.fromJson(response.data);

        List<Schedule> schedules = [];
        if (res.data!["schedules"] != null) {
          res.data!["schedules"]
              .forEach((e) => schedules.add(Schedule.fromJson(e)));
        }

        List<CarInfo> carInfoList = [];
        if (res.data!["cars_information"] != null) {
          res.data!["cars_information"]
              .forEach((e) => carInfoList.add(CarInfo.fromJson(e)));
        }

        return ScheduleResponse(schedules: schedules, carInfoList: carInfoList);
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 400 ||
          e.response?.statusCode == 401 ||
          e.response?.statusCode == 404) {
        ErrorInfoResponse error = ErrorInfoResponse.fromJson(e.response?.data);
        // * Show dialog
        showAlertDialog(context, error.message);
      } else {
        throw Exception('Failed to get appointments');
      }
    }
    return null;
  }

  static Future<ScheduleResponse?> getHistorySchedules(
      BuildContext context) async {
    try {
      final response = await DioClient.dio.get('/history/');
      if (response.statusCode == 200) {
        InfoResponse res = InfoResponse.fromJson(response.data);

        List<Schedule> schedules = [];
        if (res.data!["schedules"] != null) {
          res.data!["schedules"]
              .forEach((e) => schedules.add(Schedule.fromJson(e)));
        }

        List<CarInfo> carInfoList = [];
        if (res.data!["cars_information"] != null) {
          res.data!["cars_information"]
              .forEach((e) => carInfoList.add(CarInfo.fromJson(e)));
        }
        return ScheduleResponse(schedules: schedules, carInfoList: carInfoList);
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 400 ||
          e.response?.statusCode == 401 ||
          e.response?.statusCode == 404) {
        ErrorInfoResponse error = ErrorInfoResponse.fromJson(e.response?.data);
        // * Show dialog
        showAlertDialog(context, error.message);
      } else {
        throw Exception('Failed to get histories');
      }
    }
    return null;
  }

  static Future<ScheduleResponse?> getSearchSchedule(
    BuildContext context,
    String name,
    String address,
  ) async {
    try {
      final response = await DioClient.dio
          .get('/schedule/search?name=$name&address=$address');

      if (response.statusCode == 200) {
        InfoResponse res = InfoResponse.fromJson(response.data);

        List<Schedule> schedules = [];
        if (res.data!["schedules"] != null) {
          res.data!["schedules"]
              .forEach((e) => schedules.add(Schedule.fromJson(e)));
        }

        List<CarInfo> carInfoList = [];
        if (res.data!["cars_information"] != null) {
          res.data!["cars_information"]
              .forEach((e) => carInfoList.add(CarInfo.fromJson(e)));
        }

        return ScheduleResponse(schedules: schedules, carInfoList: carInfoList);
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 400 ||
          e.response?.statusCode == 401 ||
          e.response?.statusCode == 404) {
        ErrorInfoResponse error = ErrorInfoResponse.fromJson(e.response?.data);
        showAlertDialog(context, error.message);
      } else {
        throw Exception('Failed to get search schedules');
      }
    }
    return null;
  }

  static Future<void> patchIsEnd(int scheduleId, BuildContext context) async {
    try {
      final response = await DioClient.dio
          .patch('/schedule/set-end?schedule_id=$scheduleId');
      if (response.statusCode == 200) {
        InfoResponse res = InfoResponse.fromJson(response.data);
        context.read<ScheduleProvider>().selectedId = scheduleId;
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 400 ||
          e.response?.statusCode == 401 ||
          e.response?.statusCode == 404) {
        ErrorInfoResponse error = ErrorInfoResponse.fromJson(e.response?.data);
        // * Show dialog
        showAlertDialog(context, error.message);
      } else {
        throw Exception('Failed to update information');
      }
    }
  }
}
