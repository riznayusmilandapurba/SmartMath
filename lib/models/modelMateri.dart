import 'dart:convert';

ModelMateri modelMateriFromJson(String str) => ModelMateri.fromJson(json.decode(str));

String modelMateriToJson(ModelMateri data) => json.encode(data.toJson());

class ModelMateri {
  bool success;
  String message;
  List<MateriDatum> data;

  ModelMateri({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ModelMateri.fromJson(Map<String, dynamic> json) => ModelMateri(
    success: json["success"],
    message: json["message"],
    data: List<MateriDatum>.from(json["data"].map((x) => MateriDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class MateriDatum {
  String id_materi; // Ubah tipe data sesuai dengan response yang sebenarnya (String, int, dll)
  String id_kelas; // Ubah tipe data sesuai dengan response yang sebenarnya (String, int, dll)
  String title;
  String content;

  MateriDatum({
    required this.id_materi,
    required this.id_kelas,
    required this.title,
    required this.content,
  });

  factory MateriDatum.fromJson(Map<String, dynamic> json) => MateriDatum(
    id_materi: json["id_materi"],
    id_kelas: json["id_kelas"],
    title: json["title"],
    content: json["content"],
  );

  Map<String, dynamic> toJson() => {
    "id_materi": id_materi,
    "id_kelas": id_kelas,
    "title": title,
    "content": content,
  };
}
