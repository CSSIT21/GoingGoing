class InfoResponse {
  final bool success = true;
  final Map<String, dynamic>? data;
  final String? message;
  final String? code;

  InfoResponse({
    this.data,
    this.message,
    this.code,
  });

  InfoResponse.fromJson(Map<String, dynamic> json)
      : data = json["data"],
        message = json["message"],
        code = json["code"];
}
