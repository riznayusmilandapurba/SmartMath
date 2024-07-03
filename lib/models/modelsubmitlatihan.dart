// To parse this JSON data, do
//
//     final modelSubmitLatihan = modelSubmitLatihanFromJson(jsonString);

import 'dart:convert';

ModelSubmitLatihan modelSubmitLatihanFromJson(String str) => ModelSubmitLatihan.fromJson(json.decode(str));

String modelSubmitLatihanToJson(ModelSubmitLatihan data) => json.encode(data.toJson());

class ModelSubmitLatihan {
    bool success;
    String message;

    ModelSubmitLatihan({
        required this.success,
        required this.message,
    });

    factory ModelSubmitLatihan.fromJson(Map<String, dynamic> json) => ModelSubmitLatihan(
        success: json["success"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
    };
}
