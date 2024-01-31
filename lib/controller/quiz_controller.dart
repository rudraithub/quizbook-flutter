// ignore_for_file: prefer_const_constructors, avoid_print, empty_catches, file_names

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rudra_it_hub/model/chap_of_sub_model.dart';
import 'package:rudra_it_hub/model/question2_model.dart';
import 'package:rudra_it_hub/services/remote_services.dart';

import '../model/question_api_data.dart';
import '../model/question_model.dart';

class QuestionController extends GetxController {
  RxInt currentQuestionIndex = 1.obs;
  RxList<Question2> questons2 = <Question2>[
    Question2(queid: 0, chapterid: 0, stdid: 0, subid: 0, questionNo: 0, question: '0', option: Option(a: 'a', b: 'b', c: 'c', d: 'd'), rightAns: '')
  ].obs;

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

  Rx<QuestionApiData>? apiQuestions;

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

  void getQusetionList(int chapterId, subId, stdId, BuildContext context) async {
    var isLoading = true.obs;
    // Rx<Chapter> stdList = Chapter(status: 0, data: [], message:'').obs;

    try {
      isLoading(true);
      // var products = await RemoteServices.getQuestionList(stdId, subId, chapterId, context);
      var products = await RemoteServices.getQuestionList(stdId: stdId, subId: subId, chapterId: chapterId, context: context);
      // products = questons2.value;
      apiQuestions = products.obs;
      products = products;
      print(questons2[0].question);
      // print(products.toString());
      // if (products.data.isNotEmpty) {
      //   questions.value = products;
      //
      // }
      // else{
      //   // stdList.value = stu
      // }
    } finally {
      isLoading(false);
    }
  }
}
