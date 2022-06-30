import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:going_going_frontend/config/routes/routes.dart';
import 'package:going_going_frontend/models/response/error_info_reponse.dart';
import 'package:going_going_frontend/models/user.dart';
import 'package:going_going_frontend/services/native/local_storage_service.dart';

import '../../widgets/common/alert_dialog.dart';
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
        DioClient.dio.options.headers = {
          "Authorization": "Bearer " + res.token
        };
        debugPrint("------login1------");
        Navigator.popAndPushNamed(context, Routes.home);
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 400 ||
          e.response?.statusCode == 401 ||
          e.response?.statusCode == 404) {
        ErrorInfoResponse error = ErrorInfoResponse.fromJson(e.response?.data);
        debugPrint(error.message);
        // Show dialog
        showAlertDialog(context, error.message);
      } else {
        debugPrint(e.response?.data.toString());
        throw Exception('Failed to login');
      }
    }
  }

  static void register(
      String phoneNumber,
      String password,
      String firstname,
      String lastname,
      DateTime birthdate,
      String gender,
      BuildContext context) async {
    try {
      final response = await DioClient.dio.post(
        '/account/register',
        data: {
          "phone_number": phoneNumber,
          "password": password,
          "firstname": firstname,
          "lastname": lastname,
          "birthdate": birthdate.toString(),
          "gender": gender
        },
      );
      debugPrint("------register0------");
      if (response.statusCode == 200) {
        debugPrint(response.data.success);
        AccountResponse res = AccountResponse.fromJson(response.data);
        await LocalStorage.prefs.setString('user', res.token);
        DioClient.dio.options.headers = {
          "Authorization": "Bearer " + res.token
        };
        debugPrint("------register1------");
        Navigator.popAndPushNamed(context, Routes.home);
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
        throw Exception('Failed to register');
      }
    }
  }
}
