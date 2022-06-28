import 'dart:async' as async;

import 'package:flutter/material.dart';
import 'package:going_going_frontend/screens/general/home.dart';
import 'package:going_going_frontend/screens/onboarding/login.dart';
import 'package:going_going_frontend/services/rest/dio_service.dart';

import '../../constants/assets_path.dart';
import '../../services/native/local_storage_service.dart';
import '../../config/themes/app_colors.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  _SplashscreenState() {
    // Get user token from shared preferences
    String token = LocalStorage.prefs.getString('user') ?? "";
    DioClient.dio.options.headers = {"Authorization": "Bearer " + token};
    // Navigate to next screen
    async.Timer(const Duration(milliseconds: 2500), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => token == ""
                  ? const LoginScreen()
                  : const HomeScreen())); // Use pushReplacement for clear backstack.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Center(
          child: Image.asset(
            AssetsConstants.logo,
            height: 100,
            width: 100,
          ),
        ));
  }
}
