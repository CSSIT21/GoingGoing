import 'dio_service.dart';

class ScheduleApi {
  static void getSchedules() async {
    try {
      final response = await DioClient.dio.get(
        '/schedules',
        // headers: {'Authorization': 'Bearer $token'},
      );

      // if (response.statusCode == 200) {
      // call provider to store data
      // } else {
      //   throw Exception('Failed to load post');
      // }
    } catch (err) {
      print(err);
    }
  }
}
