import 'package:dio/dio.dart';
import 'package:going_going_frontend/services/native/local_storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dio_service.dart';


class ScheduleApi {


  static void getSchedules() async {
    // final token = LocalStorage.prefs.getString('user');
    try {
      final response = await DioClient.dio.get(
        '/schedules',
        // options: Options(headers: {"Authorization": "Bearer " + (token ?? "")})
        // headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
      // call provider to store data
      } else {
        throw Exception('Failed to load post');
      }
    } catch (err) {
      print(err);
    }
  }



}
