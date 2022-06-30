import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:going_going_frontend/models/user.dart';
import 'package:going_going_frontend/services/native/local_storage_service.dart';
import 'package:going_going_frontend/services/provider/car_informations_provider.dart';
import 'package:going_going_frontend/services/provider/user_provider.dart';
import 'package:provider/provider.dart';
import '../../config/routes/routes.dart';
import '../../models/car_info.dart';
import '../../models/response/error_info_reponse.dart';
import '../../models/response/info_response.dart';
import '../../widgets/common/alert_dialog.dart';
import 'dio_service.dart';

class ProfileApi {
  //--------------------------------------User-------------------------------------

  //*get user profile
  static void getUserProfile(BuildContext context) async {
    try {
      final response = await DioClient.dio.get(
        '/profile/',
      );
      debugPrint("------getUserProfile0------");

      if (response.statusCode == 200) {
        debugPrint("------getUserProfile1------");
        debugPrint(response.data.toString());
        // call provider to store data
        InfoResponse res = InfoResponse.fromJson(response.data);
        User user = User.fromJson(res.data);
        debugPrint(res.toString());
        debugPrint("------getUserProfile1.5------");
        context.read<UserProvider>().pathProfilePic = user.pathProfilePic!;
        context.read<UserProvider>().firstname = user.firstname;
        context.read<UserProvider>().lastname = user.lastname;
        context.read<UserProvider>().birthdate = user.birthdate;
        context.read<UserProvider>().gender = user.gender;
        context.read<UserProvider>().age = user.age!;

        // debugPrint(appointments.toString());
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

  //*patch user profile
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
        debugPrint(response.data.toString());
        // call provider to store data
        InfoResponse res = InfoResponse.fromJson(response.data);
        debugPrint(res.data.toString());
        debugPrint("------updateUserProfile2------");
        Navigator.pop(context);
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
        CarInfo carInfo = CarInfo.fromJson(res.data);
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
      debugPrint("------postDriverPofile0------");
      if (response.statusCode == 200) {
        debugPrint("------postDriverPofile1------");
        debugPrint(response.data.toString());
        // call provider to store data
        InfoResponse res = InfoResponse.fromJson(response.data);
        debugPrint(res.data.toString());

        debugPrint("------postDriverPofile2------");
        Navigator.pop(context);
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
        // throw Exception('Failed to upload information');
        // Show dialog
        showAlertDialog(context, error.message);
      } else {
        debugPrint(e.response?.data.toString());
        throw Exception('Failed to upload information');
      }
    }
  }

  //*patch driver profile
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
        debugPrint(res.data.toString());
        debugPrint("------updateDriverProfile2------");
        Navigator.pop(context);
      }
      // debugPrint(appointments.toString());
      debugPrint("------updateDriverProfile2------");
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
