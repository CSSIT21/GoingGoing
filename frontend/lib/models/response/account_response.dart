class AccountResponse {
  bool success;
  String token;
  String message;

  AccountResponse({required this.success, required this.token, required this.message});

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
