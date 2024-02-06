import 'dart:convert';

class QuizModel {
  final int totalQuestions = 5;
  final int rightAnswers = 2;
  final int wrongAnswers = 3;

  final List<String> questions = [
    'Lassi paratha and mixed vegetables are staple food of which states?',
    'Another question goes here.',
    'And one more question for variety.',
    'Yet another interesting question.',
    'Last question for the quiz.'
  ];

  final List<List<String>> options = [
    ['A: Gujarat', 'B: Maharashtra', 'C: Rajasthan', 'D: Punjab'],
    ['A: Option A', 'B: Option B', 'C: Option C', 'D: Option D'],
    ['A: abc', 'B: def', 'C: jkl', 'D: xyz'],
    ['A: Apple', 'B: Banana', 'C: Mango', 'D: Orange'],
    ['A: january', 'B: February', 'C: march', 'D: april'],
  ];
}
// To parse this JSON data, do
//
//     final temperatures = temperaturesFromJson(jsonString);

HistoryModel historyModelFromJson(String str) =>
    HistoryModel.fromJson(json.decode(str));

String historyModelToJson(HistoryModel data) => json.encode(data.toJson());

class HistoryModel {
  int status;
  List<Data> data;
  String message;

  HistoryModel({
    required this.status,
    required this.data,
    required this.message,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
        status: json["status"],
        data: List<Data>.from(json["data"].map((x) => Data.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class Data {
  int stdId;
  String std;
  int subId;
  String subjectName;
  int chapterId;
  String chapterName;
  String teacher;
  List<HistorQuestion> historyQuestions;
  String id;
  int v;

  Data({
    required this.stdId,
    required this.std,
    required this.subId,
    required this.subjectName,
    required this.chapterId,
    required this.chapterName,
    required this.teacher,
    required this.historyQuestions,
    required this.id,
    required this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        stdId: json["stdID"],
        std: json["std"],
        subId: json["subID"],
        subjectName: json["subjectName"],
        chapterId: json["chapterID"],
        chapterName: json["chapterName"],
        teacher: json["teacher"],
        historyQuestions: List<HistorQuestion>.from(
            json["questions"].map((x) => HistorQuestion.fromJson(x))),
        id: json["_id"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "stdID": stdId,
        "std": std,
        "subID": subId,
        "subjectName": subjectName,
        "chapterID": chapterId,
        "chapterName": chapterName,
        "teacher": teacher,
        "questions":
            List<dynamic>.from(historyQuestions.map((x) => x.toJson())),
        "_id": id,
        "__v": v,
      };
}

class HistorQuestion {
  int questionId;
  String questionName;
  List<String> option;
  int rightAnswer;
  int? userAns;
  bool userResult;
  String id;

  HistorQuestion({
    required this.questionId,
    required this.questionName,
    required this.option,
    required this.rightAnswer,
    required this.userAns,
    required this.userResult,
    required this.id,
  });

  factory HistorQuestion.fromJson(Map<String, dynamic> json) => HistorQuestion(
        questionId: json["questionID"],
        questionName: json["questionName"],
        option: List<String>.from(json["option"].map((x) => x)),
        rightAnswer: json["rightAnswer"],
        userAns: json["user_Ans"],
        userResult: json["user_Result"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "questionID": questionId,
        "questionName": questionName,
        "option": List<dynamic>.from(option.map((x) => x)),
        "rightAnswer": rightAnswer,
        "user_Ans": userAns,
        "user_Result": userResult,
        "_id": id,
      };
}
