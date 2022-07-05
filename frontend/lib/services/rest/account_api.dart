import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

import 'dio_service.dart';
import '../../config/routes/routes.dart';
import '../../models/response/common/error_info_response.dart';
import '../../models/response/account_response.dart';
import '../../services/native/local_storage_service.dart';
import '../../widgets/common/alert_dialog.dart';

class AccountApi {
  static Future<void> login(
    String phoneNumber,
    String password,
    BuildContext context,
  ) async {
    try {
      final response = await DioClient.dio.post(
        '/account/login',
        data: {"phone_number": phoneNumber, "password": password},
      );
      if (response.statusCode == 200) {
        AccountResponse res = AccountResponse.fromJson(response.data);
        await LocalStorage.prefs.setString('user', res.token);
        DioClient.dio.options.headers = {"Authorization": "Bearer " + res.token};
        Navigator.popAndPushNamed(context, Routes.home);
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 400 ||
          e.response?.statusCode == 401 ||
          e.response?.statusCode == 404) {
        ErrorInfoResponse error = ErrorInfoResponse.fromJson(e.response?.data);
        // * Show dialog
        showAlertDialog(context, error.message);
      } else {
        throw Exception('Failed to login');
      }
    }
  }

  static Future<void> register(
    String phoneNumber,
    String password,
    String firstname,
    String lastname,
    String birthdate,
    String gender,
    BuildContext context,
  ) async {
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
      if (response.statusCode == 200) {
        AccountResponse res = AccountResponse.fromJson(response.data);

        await LocalStorage.prefs.setString('user', res.token);
        DioClient.dio.options.headers = {"Authorization": "Bearer " + res.token};

        showAlertDialog(
          context,
          "Your account successfully registered :)",
          success: true,
          onOk: () {
            Navigator.popAndPushNamed(context, Routes.home);
          },
        );
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 400 ||
          e.response?.statusCode == 401 ||
          e.response?.statusCode == 404) {
        ErrorInfoResponse error = ErrorInfoResponse.fromJson(e.response?.data);
        // * Show dialog
        showAlertDialog(context, error.message);
      } else {
        throw Exception('Failed to register');
      }
    }
  }
}
