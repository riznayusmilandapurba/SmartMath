// To parse this JSON data, do
//
//     final modelVerified = modelVerifiedFromJson(jsonString);

import 'dart:convert';

ModelVerified modelVerifiedFromJson(String str) => ModelVerified.fromJson(json.decode(str));

String modelVerifiedToJson(ModelVerified data) => json.encode(data.toJson());

class ModelVerified {
    int value;
    String message;

    ModelVerified({
        required this.value,
        required this.message,
    });

    factory ModelVerified.fromJson(Map<String, dynamic> json) => ModelVerified(
        value: json["value"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "value": value,
        "message": message,
    };
}
