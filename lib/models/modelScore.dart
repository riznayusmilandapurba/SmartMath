// To parse this JSON data, do
//
//     final modelScore = modelScoreFromJson(jsonString);

import 'dart:convert';

ModelScore modelScoreFromJson(String str) => ModelScore.fromJson(json.decode(str));

String modelScoreToJson(ModelScore data) => json.encode(data.toJson());

class ModelScore {
    bool success;
    String totalScore;

    ModelScore({
        required this.success,
        required this.totalScore,
    });

    factory ModelScore.fromJson(Map<String, dynamic> json) => ModelScore(
        success: json["success"],
        totalScore: json["total_score"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "total_score": totalScore,
    };
}
