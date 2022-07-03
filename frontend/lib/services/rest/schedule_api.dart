import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'dio_service.dart';
import '../provider/car_informations_provider.dart';
import '../provider/schedule_provider.dart';
import '../../config/routes/routes.dart';
import '../../models/car_info.dart';
import '../../models/response/schedule_response.dart';
import '../../models/response/common/error_info_reponse.dart';
import '../../models/response/common/info_response.dart';
import '../../models/schedule.dart';
import '../../widgets/common/alert_dialog.dart';

class ScheduleApi {
  static Future<void> getAppointmentSchedules(BuildContext context) async {
    try {
      debugPrint("------appointment-1------");

      final response = await DioClient.dio.get('/schedule/');
      debugPrint("------appointment0------");
      if (response.statusCode == 200) {
        debugPrint("------appointment1------");
        debugPrint(response.data.toString());
        // call provider to store data
        InfoResponse res = InfoResponse.fromJson(response.data);

        // debugPrint(res.toString());
        debugPrint("------appointment1.5------");

        List<Schedule> appointments = [];
        if (res.data!["schedules"] != null) {
          res.data!["schedules"].forEach((e) => appointments.add(Schedule.fromJson(e)));
        }
        List<CarInfo> carInfoList = [];
        if (res.data!["cars_information"] != null) {
          res.data!["cars_information"].forEach((e) => carInfoList.add(CarInfo.fromJson(e)));
        }
        context.read<ScheduleProvider>().appointmentSchedules = appointments;
        context.read<CarInfoProvider>().appointmentCarInfos = carInfoList;

        // debugPrint(appointments.toString());
        debugPrint("------appointment2------");
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
  }

  static Future<void> getHistorySchedules(BuildContext context) async {
    try {
      debugPrint("------histories0------");

      final response = await DioClient.dio.get('/history/');
      debugPrint("------histories1------");

      if (response.statusCode == 200) {
        debugPrint("------histories2------");
        debugPrint(response.data.toString());
        // call provider to store data
        InfoResponse res = InfoResponse.fromJson(response.data);

        // debugPrint(res.toString());
        debugPrint("------histories3------");

        List<Schedule> histories = [];
        if (res.data!["schedules"] != null) {
          res.data!["schedules"].forEach((e) => histories.add(Schedule.fromJson(e)));
        }
        List<CarInfo> carInfoList = [];
        if (res.data!["cars_information"] != null) {
          res.data!["cars_information"].forEach((e) => carInfoList.add(CarInfo.fromJson(e)));
        }
        context.read<ScheduleProvider>().historySchedules = histories;
        context.read<CarInfoProvider>().historyCarInfos = carInfoList;

        // debugPrint(histories.toString());
        debugPrint("------histories4------");
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
  }

  static Future<ScheduleResponse?> getSearchSchedule(
    BuildContext context,
    String name,
    String address,
  ) async {
    try {
      final response = await DioClient.dio.get('/schedule/search?name=$name&address=$address');

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
        showAlertDialog(context, error.message);
      } else {
        debugPrint(e.response?.data.toString());
        throw Exception('Failed to get search schedules');
      }
    }
    return null;
  }

  static Future<void> patchIsEnd(int scheduleId, BuildContext context) async {
    try {
      debugPrint("------patchIsEnd1------");
      final response = await DioClient.dio.patch('/schedule/is_end?schedule_id=$scheduleId');
      debugPrint("------patchIsEnd2------");
      if (response.statusCode == 200) {
        debugPrint("------patchIsEnd3------");
        // debugPrint(response.data.toString());
        InfoResponse res = InfoResponse.fromJson(response.data);
        debugPrint(res.data!["id"].toString());

        // Calculate totalPrice from distance*35.0 in Provider
        context.read<ScheduleProvider>().selectedId = scheduleId;
        // Push route EndRideScreen
        Navigator.pushNamed(context, Routes.endRide);
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
