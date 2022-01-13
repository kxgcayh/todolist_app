import 'package:equatable/equatable.dart';

class RegistrationModel extends Equatable {
  const RegistrationModel({
    required this.statusCode,
    required this.message,
    this.errorMessage,
    this.data,
  });

  final int statusCode;
  final String message;
  final String? errorMessage;
  final String? data;

  factory RegistrationModel.fromJson(Map<String, dynamic> json) =>
      RegistrationModel(
        statusCode: json["statusCode"],
        message: json["message"],
        errorMessage: json["errorMessage"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "errorMessage": errorMessage,
        "data": data,
      };

  @override
  List<Object?> get props => [
        statusCode,
        message,
        errorMessage,
        data,
      ];
}
