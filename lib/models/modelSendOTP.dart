// To parse this JSON data, do
//
//     final modelSendOtp = modelSendOtpFromJson(jsonString);

import 'dart:convert';

ModelSendOtp modelSendOtpFromJson(String str) => ModelSendOtp.fromJson(json.decode(str));

String modelSendOtpToJson(ModelSendOtp data) => json.encode(data.toJson());

class ModelSendOtp {
    int value;
    String message;

    ModelSendOtp({
        required this.value,
        required this.message,
    });

    factory ModelSendOtp.fromJson(Map<String, dynamic> json) => ModelSendOtp(
        value: json["value"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "value": value,
        "message": message,
    };
}
