import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  int _id = 0;
  String _firstname = "";
  String _lastname = "";
  String _gender = "";
  DateTime _birthdate = DateTime.parse('1969-07-20 20:18:04Z');
  String _pathProfilePic = "";
  int _age = 0;
  // String _firstname = "Barbie";
  // String _lastname = "Roberts";
  // String _gender = "Female";
  // DateTime _birthdate = DateTime.parse('1969-07-20 20:18:04Z');
  // String _pathProfilePic = "";
  // int _age = 18;

  int get id => _id;
  String get firstname => _firstname;
  String get lastname => _lastname;
  String get gender => _gender;
  DateTime get birthdate => _birthdate;
  String get pathProfilePic => _pathProfilePic;
  int get age => _age;

  set id(int id) {
    _id = id;
    notifyListeners();
  }

  set firstname(String value) {
    _firstname = value;
    notifyListeners();
  }

  set lastname(String value) {
    _lastname = value;
    notifyListeners();
  }

  set gender(String value) {
    _gender = value;
    notifyListeners();
  }

  set birthdate(DateTime value) {
    _birthdate = value;
    notifyListeners();
  }

  set pathProfilePic(String value) {
    _pathProfilePic = value;
    notifyListeners();
  }

  set age(int value) {
    _age = value;
    notifyListeners();
  }
}
