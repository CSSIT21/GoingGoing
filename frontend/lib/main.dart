// packages
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:going_going_frontend/screens/onboarding/splash.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// config
import 'config/routes/routes.dart';
import 'config/themes/app_colors.dart';
import 'config/themes/app_text_theme.dart';
// services
import 'services/dio.dart';
import 'services/shared_preferences.dart';

void main() {
  if (defaultTargetPlatform == TargetPlatform.android) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }

  runApp(const MyApp());
  DioBase.init();
  SharedPreference.init();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Going Going',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: AppColors.primaryColor,
          secondary: AppColors.secondaryColor,
        ),
        textTheme: AppTextTheme.textTheme,
      ),
      routes: Routes.routes,
      home: const Splashscreen(),
    );
  }
}
