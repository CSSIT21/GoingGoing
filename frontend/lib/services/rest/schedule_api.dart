import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
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

      if (response is ErrorInfoResponse) {
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
        res.data["schedules"]
            .forEach((e) => appointments.add(Schedule.fromJson(e)));
        List<CarInfo> carInfoList = [];
        res.data["cars_information"]
            .forEach((e) => carInfoList.add(CarInfo.fromJson(e)));
        context.read<ScheduleProvider>().appointmentSchedules = appointments;
        context.read<CarInfoProvider>().appointmentCarInfos = carInfoList;


        // debugPrint(appointments.toString());
        debugPrint("------appointment2------");
      }
    } catch (err) {
      debugPrint(err.toString());
    }
  }
}
