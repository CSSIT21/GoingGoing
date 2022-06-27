import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:going_going_frontend/config/routes/routes.dart';
import 'package:going_going_frontend/models/car_info.dart';
import 'package:going_going_frontend/models/response/error_info_reponse.dart';
import 'package:going_going_frontend/models/response/info_response.dart';
import 'package:going_going_frontend/models/schedule.dart';
import 'package:going_going_frontend/services/native/local_storage_service.dart';
import 'package:going_going_frontend/services/provider/car_informations_provider.dart';
import 'package:going_going_frontend/services/provider/schedule_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import 'dio_service.dart';

class ScheduleApi {
  static void getAppointmentSchedules(BuildContext context) async {
    try {
      debugPrint("------appointment-1------");

      final response = await DioClient.dio.get(
        '/schedule/',
      );
      debugPrint("------appointment0------");

      if (response.data is ErrorInfoResponse) {
        ErrorInfoResponse error = ErrorInfoResponse.fromJson(response.data);
        debugPrint(error.error);
        debugPrint(error.message);
        throw Exception('Failed to load post');
      } else {
        debugPrint("------appointment1------");
        debugPrint(response.data.toString());
        // call provider to store data
        InfoResponse res = InfoResponse.fromJson(response.data);

        // debugPrint(res.toString());
        debugPrint("------appointment1.5------");

        List<Schedule> appointments = [];
        if (res.data["schedules"] != null ){
          res.data["schedules"]
            .forEach((e) => appointments.add(Schedule.fromJson(e)));
        }
        List<CarInfo> carInfoList = [];
        if (res.data["cars_information"] != null ) {
          res.data["cars_information"]
              .forEach((e) => carInfoList.add(CarInfo.fromJson(e)));
        }
        context.read<ScheduleProvider>().appointmentSchedules = appointments;
        context.read<CarInfoProvider>().appointmentCarInfos = carInfoList;

        // debugPrint(appointments.toString());
        debugPrint("------appointment2------");
      }
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  static void getHistorySchedules(BuildContext context) async {
    try {
      debugPrint("------histories0------");

      final response = await DioClient.dio.get(
        '/history/',
      );
      debugPrint("------histories1------");

      if (response.data is ErrorInfoResponse) {
        ErrorInfoResponse error = ErrorInfoResponse.fromJson(response.data);
        debugPrint(error.error);
        debugPrint(error.message);
        throw Exception('Failed to load post');
      } else {
        debugPrint("------histories2------");
        debugPrint(response.data.toString());
        // call provider to store data
        InfoResponse res = InfoResponse.fromJson(response.data);

        // debugPrint(res.toString());
        debugPrint("------histories3------");

        List<Schedule> histories = [];
        if (res.data["schedules"] != null ){
          res.data["schedules"]
              .forEach((e) => histories.add(Schedule.fromJson(e)));
        }
        List<CarInfo> carInfoList = [];
        if (res.data["cars_information"] != null ) {
          res.data["cars_information"]
              .forEach((e) => carInfoList.add(CarInfo.fromJson(e)));
        }
        context.read<ScheduleProvider>().historySchedules = histories;
        context.read<CarInfoProvider>().historyCarInfos = carInfoList;

        // debugPrint(histories.toString());
        debugPrint("------histories4------");
      }
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  static void patchIsEnd(int scheduleId, BuildContext context) async {
    try {
      debugPrint("------patchIsEnd1------");
      final response = await DioClient.dio.patch(
        '/schedule/is_end?schedule_id=$scheduleId'
      );
      debugPrint("------patchIsEnd2------");
      if (response.data is ErrorInfoResponse) {
        ErrorInfoResponse error = ErrorInfoResponse.fromJson(response.data);
        debugPrint(error.error);
        debugPrint(error.message);
        throw Exception('Failed to load post');
      } else {
        debugPrint("------patchIsEnd3------");
        // debugPrint(response.data.toString());
        InfoResponse res = InfoResponse.fromJson(response.data);
        debugPrint(res.data["id"].toString());

        // Calculate totalPrice from distance*35.0 in Provider
        context.read<ScheduleProvider>().selectedId = scheduleId;
        // Push route EndRideScreen
        Navigator.pushNamed(context, Routes.endRide);
      }
    } catch (err) {
      debugPrint(err.toString());
    }
  }
}
