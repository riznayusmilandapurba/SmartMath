// To parse this JSON data, do
//
//     final modelUserQuiz = modelUserQuizFromJson(jsonString);

import 'dart:convert';

ModelUserQuiz modelUserQuizFromJson(String str) => ModelUserQuiz.fromJson(json.decode(str));

String modelUserQuizToJson(ModelUserQuiz data) => json.encode(data.toJson());

class ModelUserQuiz {
  String status;
  String message;
  Data data;

  ModelUserQuiz({
    required this.status,
    required this.message,
    required this.data,
  });

  factory ModelUserQuiz.fromJson(Map<String, dynamic> json) => ModelUserQuiz(
    status: json["status"],
    message: json["message"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  int idUserQuiz;
  int idQuiz;
  String submissionData;
  int score;

  Data({
    required this.idUserQuiz,
    required this.idQuiz,
    required this.submissionData,
    required this.score,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    idUserQuiz: json["id_user_quiz"],
    idQuiz: json["id_quiz"],
    submissionData: json["submission_data"],
    score: json["score"],
  );

  Map<String, dynamic> toJson() => {
    "id_user_quiz": idUserQuiz,
    "id_quiz": idQuiz,
    "submission_data": submissionData,
    "score": score,
  };
}