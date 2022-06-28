class InfoResponse {
  bool success;
  String message;
  Map<String, dynamic> data;

  InfoResponse(
      {required this.success,
        required this.message,
        required this.data,
        });

  InfoResponse.fromJson(Map<String, dynamic> json)
      : success = json["success"],
        message = json["message"],
        data = json["data"];

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data,
  };
}
