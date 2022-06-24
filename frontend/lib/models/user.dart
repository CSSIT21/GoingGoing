class User {
  final int? id;
  final String firstname;
  final String lastname;
  final String gender;
  final DateTime birthdate;
  final String? pathProfilePic;
  final int? age;

  User({
    required this.firstname,
    required this.lastname,
    required this.gender,
    required this.birthdate,
    this.pathProfilePic,
    this.id,
    this.age,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        firstname = json["firstname"],
        lastname = json["lastname"],
        gender = json["gender"],
        birthdate = DateTime.parse(json["birthdate"]),
        pathProfilePic = json["path_profile_picture"] ?? "" ,
        age = json["age"];

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstname": firstname,
        "lastname": lastname,
        "gender": gender,
        "birthdate": birthdate,
        "path_profile_picture": pathProfilePic,
        "age": age,
      };
}

class AccountResponse {
  bool success;
  String token;
  String message;

  AccountResponse(
      {required this.success, required this.token, required this.message});

  AccountResponse.fromJson(Map<String, dynamic> json)
      : success = json["success"],
        token = json["token"],
        message = json["message"];

  Map<String, dynamic> toJson() => {
        "success": success,
        "token": token,
        "message": message,
      };
}
