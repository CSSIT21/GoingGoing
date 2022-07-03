class InfoResponse {
  final bool success = true;
  final Map<String, dynamic>? data;
  final String? message;

  InfoResponse({
    this.data,
    this.message,
  });

  InfoResponse.fromJson(Map<String, dynamic> json)
      : data = json["data"],
        message = json["message"];
}
