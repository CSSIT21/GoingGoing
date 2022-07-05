import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';

import '../general/home.dart';
import '../../constants/assets_path.dart';
import '../../services/rest/dio_service.dart';
import '../../config/themes/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _isLogin = false;

  _SplashScreenState();

  Future<void> _checkLogin() async {
    // * Get user token from shared preferences
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('user');

    if (token != null) {
      DioClient.dio.options.headers = {"Authorization": "Bearer " + token};
      setState(() {
        _isLogin = true;
      });
    } else {
      setState(() {
        _isLogin = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: AnimatedSplashScreen(
        splash: AssetsConstants.logo,
        nextScreen: _isLogin ? const HomeScreen() : const LoginScreen(),
        splashIconSize: 100,
        pageTransitionType: PageTransitionType.fade,
        duration: 2000,
        backgroundColor: AppColors.primaryColor,
      ),
    );
  }
}
