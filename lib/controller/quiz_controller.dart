// ignore_for_file: prefer_const_constructors, avoid_print, empty_catches, file_names

import 'dart:convert';
import 'package:get/get.dart';

import '../model/question_model.dart';

class QuestionController extends GetxController {
  RxInt currentQuestionIndex = 1.obs;
  RxList<QuestionModel> questions = <QuestionModel>[
    QuestionModel(
      question:
          'Lassi paratha and mixed vegetables are staple food of which states?',
      options: ['A: Gujarat', 'B: Maharashtra', 'C: Rajasthan', 'D: Punjab'],
      trueAnswer: 3,
    ),
    QuestionModel(
      question: 'Second Question',
      options: ['A: Option A', 'B: Option B', 'C: Option C', 'D: Option D'],
      trueAnswer: 0,
    ),
    QuestionModel(
      question: 'Third Question',
      options: ['A: abc', 'B: def', 'C: jkl', 'D: xyz'],
      trueAnswer: 2,
    ),
    QuestionModel(
      question: 'Forth Question',
      options: ['A: Apple', 'B: Banana', 'C: Mango', 'D: Orange'],
      trueAnswer: 3,
    ),
  ].obs;

  RxInt selectedOptionIndex = (-1).obs;

  bool isOptionCorrect(int index) {
    return index == getCorrectOptionIndex();
  }

  void checkAnswer(int selectedOptionIndex) {
    this.selectedOptionIndex.value = selectedOptionIndex;

    Future.delayed(Duration(seconds: 2), () {
      moveToNextQuestion();
    });
  }

  int getCorrectOptionIndex() {
    return questions[currentQuestionIndex.value - 1].trueAnswer;
  }

  void moveToNextQuestion() {
    if (currentQuestionIndex < questions.length) {
      currentQuestionIndex++;
      selectedOptionIndex.value =
          -1; // Reset selected option for the new question
      print('hhhh');
    } else {
      // Get.to(CongratulationScreen());
    }
  }
}
