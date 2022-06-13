import 'package:shared_preferences/shared_preferences.dart';

class SharedPreference {
  static late final SharedPreferences prefs;

  static void init() async {
    prefs = await SharedPreferences.getInstance();
  }
}
