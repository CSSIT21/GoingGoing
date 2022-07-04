import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:going_going_frontend/models/response/schedule_response.dart';
import 'package:provider/provider.dart';

import 'dio_service.dart';
import '../provider/car_information_provider.dart';
import '../provider/schedule_provider.dart';
import '../../config/routes/routes.dart';
import '../../models/car_info.dart';
import '../../models/response/error_info_response.dart';
import '../../models/response/info_response.dart';
import '../../models/schedule.dart';
import '../../widgets/common/alert_dialog.dart';

class ScheduleApi {
  static Future<ScheduleResponse?> getAppointmentSchedules(BuildContext context) async {
    try {
      debugPrint("------appointment-1------");

      final response = await DioClient.dio.get('/schedule/');
      debugPrint("------appointment0------");
      if (response.statusCode == 200) {
        InfoResponse res = InfoResponse.fromJson(response.data);

        List<Schedule> schedules = [];
        if (res.data!["schedules"] != null) {
          res.data!["schedules"].forEach((e) => schedules.add(Schedule.fromJson(e)));
        }

        List<CarInfo> carInfoList = [];
        if (res.data!["cars_information"] != null) {
          res.data!["cars_information"].forEach((e) => carInfoList.add(CarInfo.fromJson(e)));
        }

        return ScheduleResponse(schedules: schedules, carInfos: carInfoList);
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 400 ||
          e.response?.statusCode == 401 ||
          e.response?.statusCode == 404) {
        debugPrint("------register--error------");
        ErrorInfoResponse error = ErrorInfoResponse.fromJson(e.response?.data);
        debugPrint(error.message);
        // Show dialog
        showAlertDialog(context, error.message);
      } else {
        debugPrint(e.response?.data.toString());
        throw Exception('Failed to get appointments');
      }
    }
    return null;
  }

  static Future<ScheduleResponse?> getHistorySchedules(BuildContext context) async {
    try {
      debugPrint("------histories0------");

      final response = await DioClient.dio.get('/history/');
      debugPrint("------histories1------");

      if (response.statusCode == 200) {
        InfoResponse res = InfoResponse.fromJson(response.data);

        List<Schedule> schedules = [];
        if (res.data!["schedules"] != null) {
          res.data!["schedules"].forEach((e) => schedules.add(Schedule.fromJson(e)));
        }

        List<CarInfo> carInfoList = [];
        if (res.data!["cars_information"] != null) {
          res.data!["cars_information"].forEach((e) => carInfoList.add(CarInfo.fromJson(e)));
        }
        return ScheduleResponse(schedules: schedules, carInfos: carInfoList);
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 400 ||
          e.response?.statusCode == 401 ||
          e.response?.statusCode == 404) {
        debugPrint("------register--error------");
        ErrorInfoResponse error = ErrorInfoResponse.fromJson(e.response?.data);
        debugPrint(error.message);
        // Show dialog
        showAlertDialog(context, error.message);
      } else {
        debugPrint(e.response?.data.toString());
        throw Exception('Failed to get histories');
      }
    }
    return null;
  }

  static Future<ScheduleResponse?> getSearchSchedule(BuildContext context, String address) async {
    try {
      debugPrint('address : $address');
      final response = await DioClient.dio.get('/schedule/search?address=$address');

      if (response.statusCode == 200) {
        InfoResponse res = InfoResponse.fromJson(response.data);

        List<Schedule> schedules = [];
        if (res.data!["schedules"] != null) {
          res.data!["schedules"].forEach((e) => schedules.add(Schedule.fromJson(e)));
        }

        List<CarInfo> carInfoList = [];
        if (res.data!["cars_information"] != null) {
          res.data!["cars_information"].forEach((e) => carInfoList.add(CarInfo.fromJson(e)));
        }

        return ScheduleResponse(schedules: schedules, carInfos: carInfoList);
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 400 ||
          e.response?.statusCode == 401 ||
          e.response?.statusCode == 404) {
        ErrorInfoResponse error = ErrorInfoResponse.fromJson(e.response?.data);
        debugPrint(error.message);
        showAlertDialog(context, error.message);
      } else {
        debugPrint(e.response?.data.toString());
        throw Exception('Failed to get search schedules');
      }
    }
    return null;
  }

  static void patchIsEnd(int scheduleId, BuildContext context) async {
    try {
      debugPrint("------patchIsEnd1------");
      final response = await DioClient.dio.patch('/schedule/set-end?schedule_id=$scheduleId');
      debugPrint("------patchIsEnd2------");
      if (response.statusCode == 200) {
        debugPrint("------patchIsEnd3------");
        // debugPrint(response.data.toString());
        InfoResponse res = InfoResponse.fromJson(response.data);
        debugPrint(res.message);
        // Calculate totalPrice from distance*35.0 in Provider
        context.read<ScheduleProvider>().selectedId = scheduleId;
        // Push route EndRideScreen
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 400 ||
          e.response?.statusCode == 401 ||
          e.response?.statusCode == 404) {
        debugPrint("------register--error------");
        ErrorInfoResponse error = ErrorInfoResponse.fromJson(e.response?.data);
        debugPrint(error.message);
        // Show dialog
        showAlertDialog(context, error.message);
      } else {
        debugPrint(e.response?.data.toString());
        throw Exception('Failed to update information');
      }
    }
  }
}
