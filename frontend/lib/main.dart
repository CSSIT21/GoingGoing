// * Packages
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

// * Config
import 'config/routes/routes.dart';
import 'config/themes/app_colors.dart';
import 'config/themes/app_text_theme.dart';

// * Services
import 'services/provider/car_information_provider.dart';
import 'services/provider/schedule_provider.dart';
import 'services/provider/search_provider.dart';
import 'services/provider/user_provider.dart';
import 'services/rest/dio_service.dart';
import 'services/native/local_storage_service.dart';

// * Screens
import 'screens/boarding/splash.dart';

void main() {
  if (defaultTargetPlatform == TargetPlatform.android) {
    AndroidGoogleMapsFlutter.useAndroidViewSurface = true;
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        ChangeNotifierProvider(create: (_) => ScheduleProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => CarInfoProvider()),
      ],
      child: const MyApp(),
    ),
  );
  DioClient.init();
  LocalStorage.init();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // * This widget is the root of your application.
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
        scaffoldBackgroundColor: AppColors.white,
      ),
      routes: Routes.routes,
      home: const SplashScreen(),
    );
  }
}
