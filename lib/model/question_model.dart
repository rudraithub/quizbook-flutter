// ignore_for_file: file_names

class QuestionModel {
  String question;
  List<String> options;
  int trueAnswer;

  QuestionModel({
    required this.question,
    required this.options,
    required this.trueAnswer,
  });
}
