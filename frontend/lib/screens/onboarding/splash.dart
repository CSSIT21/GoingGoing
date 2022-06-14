import 'dart:async' as async;

import 'package:flutter/material.dart';

import '../../constants/assets_path.dart';
import '../../services/local_storage_service.dart';
import '../../config/routes/routes.dart';
import '../../config/themes/app_colors.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  _SplashscreenState() {
    async.Timer(const Duration(milliseconds: 3000), () async {
      String? user = LocalStorage.prefs.getString('user');
      if (user == null) {
        Navigator.pushReplacementNamed(context, Routes.login);
      } else {
        Navigator.pushReplacementNamed(context, Routes.home);
      }
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
