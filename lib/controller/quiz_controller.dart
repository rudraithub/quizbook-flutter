// ignore_for_file: prefer_const_constructors, avoid_print, empty_catches, file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rudra_it_hub/appUrl/all_url.dart';
import 'package:rudra_it_hub/http_methods/http_all_method.dart';
import 'package:rudra_it_hub/model/question2_model.dart';
import 'package:rudra_it_hub/model/result.dart';
import 'package:rudra_it_hub/splash_screen.dart';
import 'package:rudra_it_hub/view/screens/congratulation_view.dart';
import 'package:rudra_it_hub/widgets/common_snack_bar.dart';

import '../model/question_api_data.dart';

class QuestionController extends GetxController {
  RxInt currentQuestionIndex = 1.obs;
  RxList<Question2> questions2 = <Question2>[
    Question2(
        queid: 0,
        chapterid: 0,
        stdid: 0,
        subid: 0,
        questionNo: 0,
        question: '0',
        option: Option(a: 'a', b: 'b', c: 'c', d: 'd'),
        rightAns: '')
  ].obs;

  Rx<QuestionApiData>? apiQuestions;

  RxInt selectedOptionIndex = (-1).obs;

  Future<void> resultDataSend({

    required BuildContext context,
    required int stdid,
    required int subid,
    required int chapterid,
    required List questions,
  }) async {
    print('result send call');
    // print(stdid.toString() + subid.toString() + chapterid.toString());
    String url = '$baseUrl$resultUrl';
    try {
       Map <String, String>  headers = {
        'Content-Type' :'application/json',
        'Authorization' : userBearerToken!,
      };
      var body = <String, dynamic>{
        // "userID": userID,
        "stdid": 1,
        "subid": 1,
        "chapterid": 1,
        "questions": questions
      };
      print('here');

      // var encodedBody = jsonEncode(body);

      var response = await postMethod(url, body, headers ,context);
      print('here');
      print(userBearerToken);
      var finalResult = resultFromJson(response.body);

      if (response.statusCode == 200) {
        if (context.mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => CongratulationScreen(
                noOfTrueAns: finalResult.data!.totalRightQuestions!,
                noOfWrongAns: finalResult.data!.totalWrongQuestions!,
              ),
            ),
          );
        }
      } else {
        if (context.mounted) {
          commonSnackBar(context: context, msg: response.body);
        }
        print('object');
      }
    } catch (e) {
      if (context.mounted) {
        commonSnackBar(
            context: context, msg: "Catch2 ${e.toString()}", durationSeconds: 5);
      }
      print(e.toString());
    }
  }

  Future<QuestionApiData> getQuestionList(
      {required int stdId,
      required subId,
      required chapterId,
      required BuildContext context}) async {
    try {
      var body = <String, dynamic>{
        "stdid": stdId,
        "subid": subId,
        "chapterid": chapterId
      };
      final Map<String, String> headers = {'Content-Type': 'application/json'};

      var response = await postMethod('$baseUrl$questionUrl', body, headers ,context);
      if (response.statusCode == 200) {
        QuestionApiData tm = questionApiDataFromJson(response.body);
        return tm;
      } else {
        Map<String, dynamic> data = json.decode(response.body);
        String message = data['message'];
        print(message);
        if (context.mounted) {
          commonSnackBar(context: context, msg: message);
        }
        return QuestionApiData();
      }
    } catch (e) {
      print("error msg ${e.toString()}");
      if (context.mounted) {
        commonSnackBar(context: context, msg: "catch ${e.toString()}");
      }
      return QuestionApiData();
    }
  }
}
