// To parse this JSON data, do
//
//     final modelLogin = modelLoginFromJson(jsonString);

import 'dart:convert';

ModelLogin modelLoginFromJson(String str) => ModelLogin.fromJson(json.decode(str));

String modelLoginToJson(ModelLogin data) => json.encode(data.toJson());

class ModelLogin {
    int value;
    String message;
    String fullname;
    String email;
    String phone;
    String address;
    int id_user;
 

    ModelLogin({
        required this.value,
        required this.message,
        required this.fullname,
        required this.email,
        required this.phone,
        required this.address,
        required this.id_user,

    });

    factory ModelLogin.fromJson(Map<String, dynamic> json) => ModelLogin(
        value: json["value"],
        message: json["message"],
        fullname: json["fullname"],
        email: json["email"],
        phone: json["phone"],
        address: json["address"],
        id_user: json["id_user"],

    );

    Map<String, dynamic> toJson() => {
        "value": value,
        "message": message,
        "fullname": fullname,
        "email": email,
        "phone": phone,
        "address": address,
        "id_user": id_user,

    };
}
