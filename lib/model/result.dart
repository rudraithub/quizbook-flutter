// To parse this JSON data, do
//
//     final temperatures = temperaturesFromJson(jsonString);

import 'dart:convert';

Result resultFromJson(String str) => Result.fromJson(json.decode(str));

String resultToJson(Result data) => json.encode(data.toJson());

class Result {
  int status;
  Data data;
  String message;

  Result({
    required this.status,
    required this.data,
    required this.message,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        status: json["status"],
        data: Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
        "message": message,
      };
}

class Data {
  String userId;
  int stdid;
  int subid;
  int chapterid;
  List<Question> questions;
  String id;
  int v;
  int totalRightQuestions;
  int totalWrongQuestions;

  Data({
    required this.userId,
    required this.stdid,
    required this.subid,
    required this.chapterid,
    required this.questions,
    required this.id,
    required this.v,
    required this.totalRightQuestions,
    required this.totalWrongQuestions,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["userID"],
        stdid: json["stdid"],
        subid: json["subid"],
        chapterid: json["chapterid"],
        questions: List<Question>.from(
            json["questions"].map((x) => Question.fromJson(x))),
        id: json["_id"],
        v: json["__v"],
        totalRightQuestions: json["totalRightQuestions"],
        totalWrongQuestions: json["totalWrongQuestions"],
      );

  Map<String, dynamic> toJson() => {
        "userID": userId,
        "stdid": stdid,
        "subid": subid,
        "chapterid": chapterid,
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
        "_id": id,
        "__v": v,
        "totalRightQuestions": totalRightQuestions,
        "totalWrongQuestions": totalWrongQuestions,
      };
}

class Question {
  int queid;
  int userAnswer;
  bool userResult;
  String id;

  Question({
    required this.queid,
    required this.userAnswer,
    required this.userResult,
    required this.id,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        queid: json["queid"],
        userAnswer: json["user_answer"],
        userResult: json["user_result"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "queid": queid,
        "user_answer": userAnswer,
        "user_result": userResult,
        "_id": id,
      };
}
