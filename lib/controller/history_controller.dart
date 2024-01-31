import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../model/history_model_data.dart';

class QuizController extends GetxController {
  final QuizModel _model = QuizModel();

  int get totalQuestions => _model.totalQuestions;
  int get rightAnswers => _model.rightAnswers;
  int get wrongAnswers => _model.wrongAnswers;

  String getQuestion(int index) => _model.questions[index - 1];
  List<String> getOptions(int index) => _model.options[index - 1];
  String getCorrectAnswer(int index) => _model.options[index - 1][0];
}
