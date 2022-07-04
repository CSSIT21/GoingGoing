import 'package:flutter/material.dart';

import '../../screens/boarding/login.dart';
import '../../screens/boarding/sign_up.dart';
import '../../screens/boarding/splash.dart';
import '../../screens/general/home.dart';
import '../../screens/general/search.dart';
import '../../screens/general/show_offer.dart';
import '../../screens/general/filter.dart';
import '../../screens/general/offer_detail.dart';
import '../../screens/general/waiting_request.dart';
import '../../screens/general/end_ride.dart';
import '../../screens/general/profile.dart';
import '../../screens/general/edit_profile.dart';
import '../../screens/general/become_driver.dart';

class Routes {
  Routes._();

  // * Authed
  static const String login = '/login';
  static const String signUp = '/sign-up';

  // * Main
  static const String splash = '/splash';
  static const String home = '/home';
  static const String search = '/search';
  static const String showOffer = '/show-offer';
  static const String filter = '/filter';
  static const String offerDetail = '/offer-detail';
  static const String waiting = '/waiting';
  static const String endRide = '/end-ride';

  // * Profile
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';
  static const String becomeDriver = '/become-driver';

  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => const SplashScreen(),
    login: (BuildContext context) => const LoginScreen(),
    signUp: (BuildContext context) => const SignUpScreen(),
    home: (BuildContext context) => const HomeScreen(),
    search: (BuildContext context) => const SearchScreen(),
    showOffer: (BuildContext context) => const ShowOfferScreen(),
    filter: (BuildContext context) => const FilterScreen(),
    offerDetail: (BuildContext context) => const OfferDetailScreen(),
    waiting: (BuildContext context) => const WaitingRequestScreen(),
    endRide: (BuildContext context) => const EndRideScreen(),
    profile: (BuildContext context) => const ProfileScreen(),
    editProfile: (BuildContext context) => const EditProfileScreen(),
    becomeDriver: (BuildContext context) => const BecomeDriverScreen(),
  };
}
