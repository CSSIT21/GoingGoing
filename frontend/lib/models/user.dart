class User {
  final int? id;
  final String firstname;
  final String lastname;
  final String gender;
  final DateTime birthdate;
  final String pathProfilePic;
  final int? age;

  User({
    required this.firstname,
    required this.lastname,
    required this.gender,
    required this.birthdate,
    required this.pathProfilePic,
    this.id,
    this.age,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        firstname = json["firstname"],
        lastname = json["lastname"],
        gender = json["gender"],
        birthdate = json["birthdate"],
        pathProfilePic = json["path_profile_picture"],
        age = json["age"];

  Map<String, dynamic> toJson() => {
        "id": id,
        "fistname": firstname,
        "lastname": lastname,
        "gender": gender,
        "birthdate": birthdate,
        "pathProfilePic": pathProfilePic,
        "age": age,
      };
}
