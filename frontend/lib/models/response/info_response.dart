class InfoResponse {
  bool success;
  Map<String, dynamic>? data;
  String? message;

  InfoResponse({
    this.success = true,
    this.data,
    this.message,
  });

  InfoResponse.fromJson(Map<String, dynamic> json)
      : success = json["success"],
        data = json["data"],
        message = json["message"];

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data,
        "message": message,
      };
}
