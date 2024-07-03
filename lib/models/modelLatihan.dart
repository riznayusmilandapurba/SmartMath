// To parse this JSON data, do
//
//     final ModelLatihan = ModelLatihanFromJson(jsonString);

import 'dart:convert';

ModelLatihan ModelLatihanFromJson(String str) => ModelLatihan.fromJson(json.decode(str));

String ModelLatihanToJson(ModelLatihan data) => json.encode(data.toJson());

class ModelLatihan {
    bool isSuccess;
    String message;
    List<Datum> data;

    ModelLatihan({
        required this.isSuccess,
        required this.message,
        required this.data,
    });

    factory ModelLatihan.fromJson(Map<String, dynamic> json) => ModelLatihan(
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
    int idLatihan;
    String soal;
    String optionA;
    String optionB;
    String optionC;
    String optionD;
    String optionE;
    String namaKelas;

    Datum({
        required this.idLatihan,
        required this.soal,
        required this.optionA,
        required this.optionB,
        required this.optionC,
        required this.optionD,
        required this.optionE,
        required this.namaKelas,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        idLatihan: json["id_latihan"],
        soal: json["soal"],
        optionA: json["option_A"],
        optionB: json["option_B"],
        optionC: json["option_C"],
        optionD: json["option_D"],
        optionE: json["option_E"],
        namaKelas: json["nama_kelas"],
    );

    Map<String, dynamic> toJson() => {
        "id_latihan": idLatihan,
        "soal": soal,
        "option_A": optionA,
        "option_B": optionB,
        "option_C": optionC,
        "option_D": optionD,
        "option_E": optionE,
        "nama_kelas": namaKelas,
    };
}
