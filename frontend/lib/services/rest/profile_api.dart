import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import 'dio_service.dart';
import '../provider/car_information_provider.dart';
import '../provider/user_provider.dart';
import '../../models/user.dart';
import '../../models/car_info.dart';
import '../../models/response/common/error_info_response.dart';
import '../../models/response/common/info_response.dart';
import '../../widgets/common/alert_dialog.dart';

class ProfileApi {

  // * Get user profile
  static Future<void> getUserProfile(BuildContext context) async {
    try {
      final response = await DioClient.dio.get(
        '/profile/',
      );

      if (response.statusCode == 200) {
        // * Call provider to store data
        InfoResponse res = InfoResponse.fromJson(response.data);
        User user = User.fromJson(res.data!);
        context.read<UserProvider>().pathProfilePic = user.pathProfilePic!;
        context.read<UserProvider>().id = user.id!;
        context.read<UserProvider>().firstname = user.firstname;
        context.read<UserProvider>().lastname = user.lastname;
        context.read<UserProvider>().birthdate = user.birthdate;
        context.read<UserProvider>().gender = user.gender;
        context.read<UserProvider>().age = user.age!;
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 400 ||
          e.response?.statusCode == 401 ||
          e.response?.statusCode == 404) {
        ErrorInfoResponse error = ErrorInfoResponse.fromJson(e.response?.data);

        // * Show dialog
        showAlertDialog(context, error.message);
      } else {
        throw Exception('Failed to get profile');
      }
    }
  }

  // * Patch user profile
  static void updateUserProfile(
      String firstname,
      String lastname,
      String gender,
      String birthdate,
      String pathProfilePic,
      BuildContext context) async {
    try {
      final response = await DioClient.dio.patch(
        '/profile/info',
        data: {
          "firstname": firstname,
          "lastname": lastname,
          "gender": gender,
          "birthdate": birthdate,
          "path_profile_picture": pathProfilePic
        },
      );
      if (response.statusCode == 200) {
        // * Call provider to store data
        InfoResponse res = InfoResponse.fromJson(response.data);
        Navigator.of(context).pop();
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 400 ||
          e.response?.statusCode == 401 ||
          e.response?.statusCode == 404) {
        ErrorInfoResponse error = ErrorInfoResponse.fromJson(e.response?.data);
        // * Show dialog
        showAlertDialog(context, error.message);
      } else {
        throw Exception('Failed to update information');
      }
    }
  }

  // * Get driver profile
  static Future<void> getDriverProfile(BuildContext context) async {
    try {
      final response = await DioClient.dio.get(
        '/driver/info',
      );

      if (response.statusCode == 200) {
        // * Call provider to store data
        InfoResponse res = InfoResponse.fromJson(response.data);
        CarInfo carInfo = CarInfo.fromJson(res.data!);
        context.read<CarInfoProvider>().userCarInfo.carRegis = carInfo.carRegis;
        context.read<CarInfoProvider>().userCarInfo.carBrand = carInfo.carBrand;
        context.read<CarInfoProvider>().userCarInfo.carColor = carInfo.carColor;
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 400 ||
          e.response?.statusCode == 401 ||
          e.response?.statusCode == 404) {
        ErrorInfoResponse error = ErrorInfoResponse.fromJson(e.response?.data);
        // * Show dialog
        showAlertDialog(context, error.message);
      } else {
        throw Exception('Failed to get driver information');
      }
    }
  }

  // * Post driver profile
  static void postDriverProfile(String carRegis, String carBrand,
      String carColor, BuildContext context) async {
    try {
      final response = await DioClient.dio.post(
        '/driver/new',
        data: {
          "car_registration": carRegis,
          "car_brand": carBrand,
          "car_color": carColor,
        },
      );
      if (response.statusCode == 200) {
        // * Call provider to store data
        InfoResponse res = InfoResponse.fromJson(response.data);
        Navigator.of(context).pop();
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 400 ||
          e.response?.statusCode == 401 ||
          e.response?.statusCode == 404) {
        ErrorInfoResponse error = ErrorInfoResponse.fromJson(e.response?.data);
        // * Show dialog
        showAlertDialog(context, error.message);
      } else {
        throw Exception('Failed to upload information');
      }
    }
  }

  // * Patch driver profile
  static void updateDriverProfile(String carRegis, String carBrand,
      String carColor, BuildContext context) async {
    try {
      final response = await DioClient.dio.patch(
        '/driver/',
        data: {
          "car_registration": carRegis,
          "car_brand": carBrand,
          "car_color": carColor,
        },
      );
      if (response.statusCode == 200) {
        // * Call provider to store data
        InfoResponse res = InfoResponse.fromJson(response.data);
      }
      Navigator.of(context).pop();
    } on DioError catch (e) {
      if (e.response?.statusCode == 400 ||
          e.response?.statusCode == 401 ||
          e.response?.statusCode == 404) {
        ErrorInfoResponse error = ErrorInfoResponse.fromJson(e.response?.data);
        // * Show dialog
        showAlertDialog(context, error.message);
      } else {
        throw Exception('Failed to update information');
      }
    }
  }
}
