class UserInfo {
  final String firstname;
  final String lastname;
  final String gender;
  final DateTime birthdate;
  final String pathProfilePic;
  final int?age;

  UserInfo(
    this.firstname,
    this.lastname,
    this.gender,
    this.birthdate,
    this.pathProfilePic,
    this.age
  );

  UserInfo.fromJson(Map<String, dynamic> json) 
    : firstname = json["firstname"],
      lastname = json["lastname"],
      gender = json["gender"],
      birthdate = json["birthdate"],
      pathProfilePic = json["path_profile_picture"],
      age = json["age"];

  Map<String, dynamic> toJson() =>{
    "fistname" : firstname,
    "lastname" : lastname,
    "gender" : gender,
    "birthdate" : birthdate,
    "pathProfilePic" : pathProfilePic,
    "age" : age,
  };

}