class InfoResponse {
  bool success;
  String code;
  Object data;

  InfoResponse(
      {required this.success,
        required this.code,
        required this.data,
        });

  InfoResponse.fromJson(Map<String, dynamic> json)
      : success = json["success"],
        code = json["code"],
        data = json["data"];

  Map<String, dynamic> toJson() => {
    "success": success,
    "code": code,
    "data": data,
  };
}
