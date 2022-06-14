import 'dart:async' as async;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../config/themes/app_colors.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  _SplashscreenState() {
    async.Timer(const Duration(milliseconds: 3000), () async {
      final prefs = await SharedPreferences.getInstance();
      String? user = prefs.getString('user');
      if (user == null) {
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        Navigator.pushReplacementNamed(context, '/home');
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: Center(
            child: Image.asset(
          'assets/images/logo.png',
          height: 100,
          width: 100,
        )));
  }
}
