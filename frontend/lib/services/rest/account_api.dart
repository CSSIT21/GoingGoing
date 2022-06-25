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
        throw Exception('Failed to login');
      }
    } catch (err) {
      debugPrint(err.toString());
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
      if (response is ErrorInfoResponse) {
        ErrorInfoResponse error = ErrorInfoResponse.fromJson(response.data);
        debugPrint(error.error);
        debugPrint(error.message);
        throw Exception('Failed to load post');
      } else {
        print(response.data);
        AccountResponse res = AccountResponse.fromJson(response.data);
        await LocalStorage.prefs.setString('user', res.token);
        final token = LocalStorage.prefs.getString('user');
        debugPrint(token);
        DioClient.dio.options.headers = {"Authorization": "Bearer " + token!};
        debugPrint("------register1------");
        Timer(const Duration(milliseconds: 1500), () {
          Navigator.popAndPushNamed(context, Routes.home);
        });
      }
    } catch (err) {
      debugPrint(err.toString());
    }
  }
}
