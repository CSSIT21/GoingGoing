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

      if (response.data is ErrorInfoResponse) {
        ErrorInfoResponse error = ErrorInfoResponse.fromJson(response.data);
        debugPrint(error.error);
        debugPrint(error.message);
        throw Exception('Failed to load user profile');
      } else {
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
    } catch (err) {
      debugPrint(err.toString());
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

      final response = await DioClient.dio.patch('/profile/', data: {
        "firstname": firstname,
        "lastname": lastname,
        "gender": gender,
        "birthdate": birthdate,
        "path_profile_picture": pathProfilePic
      });
      debugPrint("------updateUserProfile0------");
      if (response.data is ErrorInfoResponse) {
        ErrorInfoResponse error = ErrorInfoResponse.fromJson(response.data);
        debugPrint(error.error);
        debugPrint(error.message);
        throw Exception('Failed to load user profile');
      } else {
        debugPrint("------updateUserProfile1------");
        debugPrint(response.data.toString());
        // call provider to store data
        InfoResponse res = InfoResponse.fromJson(response.data);
        print(res.data);
        debugPrint("------updateUserProfile2------");
        Timer(const Duration(milliseconds: 1500), () {
          Navigator.pop(context);
        });

      }
    } catch (err) {
      debugPrint(err.toString());
    }
  }




  //--------------------------------------Driver-------------------------------------





  //*get driver profile
  static void getDriverProfile(BuildContext context) async {
    try {
      final response = await DioClient.dio.get(
        '/profile/driver',
      );
      debugPrint("------getDriverProfile0------");

      if (response.data is ErrorInfoResponse) {
        ErrorInfoResponse error = ErrorInfoResponse.fromJson(response.data);
        debugPrint(error.error);
        debugPrint(error.message);
        throw Exception('Failed to load user profile');
      } else {
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

        // debugPrint(appointments.toString());
        debugPrint("------getDriverProfile2------");
      }
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  //*post driver profile
  static void postDriverProfile(
      String carRegis,
      String carBrand,
      String carColor,
      BuildContext context) async {
    try {
      final response = await DioClient.dio.post('/profile/driver/post', data: {
        "car_registration": carRegis,
        "car_brand": carBrand,
        "car_color": carColor,
      });
      debugPrint("------postDriverPofile0------");
      if (response.data is ErrorInfoResponse) {
        ErrorInfoResponse error = ErrorInfoResponse.fromJson(response.data);
        debugPrint(error.error);
        debugPrint(error.message);
        throw Exception('Failed to load user profile');
      } else {
        debugPrint("------postDriverPofile1------");
        debugPrint(response.data.toString());
        // call provider to store data
        InfoResponse res = InfoResponse.fromJson(response.data);
        print(res.data);
        debugPrint("------postDriverPofile2------");
        Timer(const Duration(milliseconds: 1500), () {
          Navigator.pop(context);
        });

      }
      // debugPrint(appointments.toString());
      debugPrint("------postDriverProfile2------");
    }on DioError  catch (ex) {
      throw Exception(ex.message);
    }
  }


  //*patch driver profile
  static void updateDriverProfile(
      String carRegis,
      String carBrand,
      String carColor,
      BuildContext context) async {
    try {
      final response = await DioClient.dio.patch('/profile/driver', data: {
        "car_registration": carRegis,
        "car_brand": carBrand,
        "car_color": carColor,
      });
      debugPrint("------updateDriverProfile0------");
      if (response.data is ErrorInfoResponse) {
        ErrorInfoResponse error = ErrorInfoResponse.fromJson(response.data);
        debugPrint(error.error);
        debugPrint(error.message);
        throw Exception('Failed to load user profile');
      } else {
        debugPrint("------updateDriverProfile1------");
        debugPrint(response.data.toString());
        // call provider to store data
        InfoResponse res = InfoResponse.fromJson(response.data);
        print(res.data);
        debugPrint("------updateDriverProfile2------");
        Timer(const Duration(milliseconds: 1500), () {
          Navigator.popAndPushNamed(context, Routes.profile);
        });

      }
      // debugPrint(appointments.toString());
      debugPrint("------updateDriverProfile2------");

    }on DioError  catch (ex) {
      throw Exception(ex.message);
    }
  }
}



