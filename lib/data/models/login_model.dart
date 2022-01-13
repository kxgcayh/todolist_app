class LoginModel {
  LoginModel({
    required this.statusCode,
    required this.message,
    this.errorMessage,
    this.data,
  });

  final int statusCode;
  final String message;
  final String? errorMessage;
  final Data? data;

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        statusCode: json["statusCode"],
        message: json["message"],
        errorMessage: json["errorMessage"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "errorMessage": errorMessage,
        "data": data?.toJson(),
      };
}

class Data {
  Data({required this.token});

  final String token;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}
