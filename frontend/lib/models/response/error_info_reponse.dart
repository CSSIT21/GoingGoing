class ErrorInfoResponse {
  bool success;
  String code;
  String message;
  String error;

  ErrorInfoResponse(
      {required this.success,
      required this.code,
      required this.message,
      required this.error});

  ErrorInfoResponse.fromJson(Map<String, dynamic> json)
      : success = json["success"],
        code = json["code"],
        message = json["message"],
        error = json["error"].toString();

  Map<String, dynamic> toJson() => {
        "success": success,
        "code": code,
        "message": message,
        "error": error,
      };
}
