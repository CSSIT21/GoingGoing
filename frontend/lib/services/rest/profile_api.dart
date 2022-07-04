import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../provider/car_information_provider.dart';
import '../provider/user_provider.dart';
import '../../models/user.dart';
import '../../models/car_info.dart';
import '../../models/response/common/error_info_reponse.dart';
import '../../models/response/common/info_response.dart';
import '../../widgets/common/alert_dialog.dart';
import 'dio_service.dart';

class ProfileApi {
  //-------------------------------------- User -------------------------------------

  // * Get user profile
  static Future<void> getUserProfile(BuildContext context) async {
    try {
      final response = await DioClient.dio.get(
        '/profile/',
      );
      debugPrint("------getUserProfile0------");

      if (response.statusCode == 200) {
        debugPrint("------getUserProfile1------");
        // call provider to store data
        InfoResponse res = InfoResponse.fromJson(response.data);
        User user = User.fromJson(res.data!);
        debugPrint("------getUserProfile1.5------");
        context.read<UserProvider>().pathProfilePic = user.pathProfilePic!;
        context.read<UserProvider>().id = user.id!;
        context.read<UserProvider>().firstname = user.firstname;
        context.read<UserProvider>().lastname = user.lastname;
        context.read<UserProvider>().birthdate = user.birthdate;
        context.read<UserProvider>().gender = user.gender;
        context.read<UserProvider>().age = user.age!;
        debugPrint(res.data.toString());
        debugPrint("------getUserProfile2------");
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 400 ||
          e.response?.statusCode == 401 ||
          e.response?.statusCode == 404) {
        debugPrint("------getUserProfile--error------");
        ErrorInfoResponse error = ErrorInfoResponse.fromJson(e.response?.data);
        debugPrint(error.message);

        // Show dialog
        showAlertDialog(context, error.message);
      } else {
        debugPrint(e.response?.data.toString());
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
      debugPrint("------updateUserProfile0------");
      if (response.statusCode == 200) {
        debugPrint("------updateUserProfile1------");
        // call provider to store data
        InfoResponse res = InfoResponse.fromJson(response.data);
        debugPrint(res.message);
        debugPrint("------updateUserProfile2------");
        Navigator.of(context).pop();
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 400 ||
          e.response?.statusCode == 401 ||
          e.response?.statusCode == 404) {
        debugPrint("------updateUserProfile--error------");
        ErrorInfoResponse error = ErrorInfoResponse.fromJson(e.response?.data);
        debugPrint(error.message);
        // Show dialog
        showAlertDialog(context, error.message);
      } else {
        debugPrint(e.response?.data.toString());
        throw Exception('Failed to update information');
      }
    }
  }

  //--------------------------------------Driver-------------------------------------

  //*get driver profile
  static void getDriverProfile(BuildContext context) async {
    try {
      final response = await DioClient.dio.get(
        '/driver/info',
      );
      debugPrint("------getDriverProfile0------");

      if (response.statusCode == 200) {
        debugPrint("------getDriverProfile1------");
        debugPrint(response.data.toString());
        // call provider to store data
        InfoResponse res = InfoResponse.fromJson(response.data);
        CarInfo carInfo = CarInfo.fromJson(res.data!);
        debugPrint(res.toString());
        debugPrint("------getDriverProfile1.5------");
        context.read<CarInfoProvider>().userCarInfo.carRegis = carInfo.carRegis;
        context.read<CarInfoProvider>().userCarInfo.carBrand = carInfo.carBrand;
        context.read<CarInfoProvider>().userCarInfo.carColor = carInfo.carColor;
        debugPrint("------getDriverProfile2------");
      }
    } on DioError catch (e) {
      if (e.response?.statusCode == 400 ||
          e.response?.statusCode == 401 ||
          e.response?.statusCode == 404) {
        debugPrint("------getDriverProfile--error------");
        ErrorInfoResponse error = ErrorInfoResponse.fromJson(e.response?.data);
        debugPrint(error.message);
        // Show dialog
        showAlertDialog(context, error.message);
      } else {
        debugPrint(e.response?.data.toString());
        throw Exception('Failed to get driver information');
      }
    }
  }

  //*post driver profile
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
      debugPrint("------postDriverProfile0------");
      if (response.statusCode == 200) {
        debugPrint("------postDriverProfile1------");
        debugPrint(response.data.toString());
        // call provider to store data
        InfoResponse res = InfoResponse.fromJson(response.data);
        debugPrint(res.message);
        Navigator.of(context).pop();
      }
      // debugPrint(appointments.toString());
      debugPrint("------postDriverProfile2------");
    } on DioError catch (e) {
      if (e.response?.statusCode == 400 ||
          e.response?.statusCode == 401 ||
          e.response?.statusCode == 404) {
        debugPrint("------postDriverProfile--error------");
        ErrorInfoResponse error = ErrorInfoResponse.fromJson(e.response?.data);
        debugPrint(error.message);
        // Show dialog
        showAlertDialog(context, error.message);
      } else {
        debugPrint(e.response?.data.toString());
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
      debugPrint("------updateDriverProfile0------");
      if (response.statusCode == 200) {
        debugPrint("------updateDriverProfile1------");
        debugPrint(response.data.toString());
        // call provider to store data
        InfoResponse res = InfoResponse.fromJson(response.data);
        debugPrint(res.message);
        debugPrint("------updateDriverProfile2------");
      }
      Navigator.of(context).pop();
    } on DioError catch (e) {
      if (e.response?.statusCode == 400 ||
          e.response?.statusCode == 401 ||
          e.response?.statusCode == 404) {
        debugPrint("------updateDriverProfile--error------");
        ErrorInfoResponse error = ErrorInfoResponse.fromJson(e.response?.data);
        debugPrint(error.message);
        // Show dialog
        showAlertDialog(context, error.message);
      } else {
        debugPrint(e.response?.data.toString());
        throw Exception('Failed to update information');
      }
    }
  }
}
