class ErrorInfoResponse {
  final bool success = false;
  final String message;
  final String? code;
  final String? error;

  ErrorInfoResponse({
    required this.message,
    this.code,
    this.error,
  });

  ErrorInfoResponse.fromJson(Map<String, dynamic> json)
      : message = json["message"] ?? "",
        code = json["code"],
        error = json["error"];
}
