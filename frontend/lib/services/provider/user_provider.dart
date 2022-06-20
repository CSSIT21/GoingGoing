import 'package:flutter/foundation.dart';

class UserProvider with ChangeNotifier {
  String _firstname = "Barbie";
  String _lastname = "Roberts";
  String _gender = "Female";
  DateTime _birthdate = DateTime.now();
  String _pathProfilePic = "";
  int _age = 18;
  
  String get firstname => _firstname;
  String get lastname => _lastname;
  String get gender => _gender;
  DateTime get birthdate => _birthdate;
  String get pathProfilePic => _pathProfilePic;
  int get age => _age;

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

