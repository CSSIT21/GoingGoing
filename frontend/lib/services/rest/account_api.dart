import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:going_going_frontend/config/routes/routes.dart';
import 'package:going_going_frontend/models/response/error_info_reponse.dart';
import 'package:going_going_frontend/models/user.dart';
import 'package:going_going_frontend/services/native/local_storage_service.dart';

import 'dio_service.dart';

class AccountApi {
  static void login(
      String phoneNumber, String password, BuildContext context) async {
    try {
      final response = await DioClient.dio.post(
        '/account/login',
        data: {"phone_number": phoneNumber, "password": password},
      );
      debugPrint("------login0------");
      if (response.statusCode == 200) {
        AccountResponse res = AccountResponse.fromJson(response.data);
        await LocalStorage.prefs.setString('user', res.token);
        final token = LocalStorage.prefs.getString('user');
        debugPrint(token);
        DioClient.dio.options.headers = {"Authorization": "Bearer " + token!};
        debugPrint("------login1------");
        Timer(const Duration(milliseconds: 1500), () {
          Navigator.popAndPushNamed(context, Routes.home);
        });
      } else {
        debugPrint(response.data);
        throw Exception('Failed to load post');
      }
    }
      catch (err) {
      debugPrint(err.toString());
    }
  }
}
