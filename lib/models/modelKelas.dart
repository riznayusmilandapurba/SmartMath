// To parse this JSON data, do
//
//     final modelKelas = modelKelasFromJson(jsonString);

import 'dart:convert';

ModelKelas modelKelasFromJson(String str) => ModelKelas.fromJson(json.decode(str));

String modelKelasToJson(ModelKelas data) => json.encode(data.toJson());

class ModelKelas {
    bool success;
    String message;
    List<Datum> data;

    ModelKelas({
        required this.success,
        required this.message,
        required this.data,
    });

    factory ModelKelas.fromJson(Map<String, dynamic> json) => ModelKelas(
        success: json["success"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    String idKelas;
    String namaKelas;

    Datum({
        required this.idKelas,
        required this.namaKelas,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        idKelas: json["id_kelas"],
        namaKelas: json["nama_kelas"],
    );

    Map<String, dynamic> toJson() => {
        "id_kelas": idKelas,
        "nama_kelas": namaKelas,
    };
}
