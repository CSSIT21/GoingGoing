// packages
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:going_going_frontend/screens/general/end_ride.dart';
import 'package:going_going_frontend/screens/general/home.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
// config
import 'config/routes/routes.dart';
import 'config/themes/app_colors.dart';
import 'config/themes/app_text_theme.dart';

// services
import 'services/provider/search_provider.dart';
import 'services/rest/dio_service.dart';
import 'services/native/local_storage_service.dart';
// screens
import 'screens/general/profile.dart';
import 'screens/onboarding/splash.dart';
import 'screens/general/become_driver.dart';

void main() {
  if (defaultTargetPlatform == TargetPlatform.android) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SearchProvider()),
      ],
      child: const MyApp(),
    ),
  );
  DioClient.init();
  LocalStorage.init();
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
      home: const ProfileScreen(),
    );
  }
}
