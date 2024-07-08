// To parse this JSON data, do
//
//     final modelRating = modelRatingFromJson(jsonString);

import 'dart:convert';

ModelRating modelRatingFromJson(String str) => ModelRating.fromJson(json.decode(str));

String modelRatingToJson(ModelRating data) => json.encode(data.toJson());

class ModelRating {
    bool isSuccess;
    String message;
    List<Datum> data;

    ModelRating({
        required this.isSuccess,
        required this.message,
        required this.data,
    });

    factory ModelRating.fromJson(Map<String, dynamic> json) => ModelRating(
        isSuccess: json["isSuccess"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "isSuccess": isSuccess,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    String idRating;
    String idUser;
    String rating;

    Datum({
        required this.idRating,
        required this.idUser,
        required this.rating,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        idRating: json["id_rating"],
        idUser: json["id_user"],
        rating: json["rating"],
    );

    Map<String, dynamic> toJson() => {
        "id_rating": idRating,
        "id_user": idUser,
        "rating": rating,
    };
}
