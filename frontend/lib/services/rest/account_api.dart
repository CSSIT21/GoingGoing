import 'package:flutter/cupertino.dart';
import 'package:going_going_frontend/models/user.dart';
import 'package:going_going_frontend/services/native/local_storage_service.dart';
import 'package:going_going_frontend/services/provider/user_provider.dart';
import 'package:provider/provider.dart';

import 'dio_service.dart';

class AccountApi {
  static void login(
      String phoneNumber, String password, BuildContext context) async {
    try {
      final response = await DioClient.dio.post(
        '/account/login',
        data: {"phone_number": phoneNumber, "password": password},
      );
      print(response);
      if (response.statusCode == 200) {
        Response res = Response.fromJson(response.data);
        await LocalStorage.prefs.setString('user', res.token);
        final token = LocalStorage.prefs.getString('user');
        DioClient.dio.options.headers = {"Authorization": "Bearer " + token!};
      } else {
        throw Exception('Failed to load post');
      }
    } catch (err) {
      print(err);
    }
  }
}
