// To parse this JSON data, do
//
//     final modelQuiz = modelQuizFromJson(jsonString);

import 'dart:convert';

List<ModelQuiz> modelQuizFromJson(String str) => List<ModelQuiz>.from(json.decode(str).map((x) => ModelQuiz.fromJson(x)));

String modelQuizToJson(List<ModelQuiz> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ModelQuiz {
  String idQuiz;
  String idMateri;
  String questions;
  String answer;

  ModelQuiz({
    required this.idQuiz,
    required this.idMateri,
    required this.questions,
    required this.answer,
  });

  factory ModelQuiz.fromJson(Map<String, dynamic> json) => ModelQuiz(
    idQuiz: json["id_quiz"],
    idMateri: json["id_materi"],
    questions: json["questions"],
    answer: json["answer"],
  );

  Map<String, dynamic> toJson() => {
    "id_quiz": idQuiz,
    "id_materi": idMateri,
    "questions": questions,
    "answer": answer,
  };
}
