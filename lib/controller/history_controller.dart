import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rudra_it_hub/appUrl/all_url.dart';
import 'package:rudra_it_hub/http_methods/http_all_method.dart';
import 'package:rudra_it_hub/splash_screen.dart';
import 'package:rudra_it_hub/widgets/common_snack_bar.dart';

import '../model/history_model_data.dart';

class HistoryController extends GetxController {
  final QuizModel _model = QuizModel();
  Rx<HistoryModel> historyModel =
      HistoryModel(data: [], message: '', status: 0).obs;
  int get totalQuestions => _model.totalQuestions;
  int get rightAnswers => _model.rightAnswers;
  int get wrongAnswers => _model.wrongAnswers;
  var isLoading = false.obs;
  

  String getQuestion(int index) => _model.questions[index - 1];
  List<String> getOptions(int index) => _model.options[index - 1];
  String getCorrectAnswer(int index) => _model.options[index - 1][0];

  void loadData(BuildContext context) async {
    print('Load Data Call');
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': userBearerToken!,
    };
    String url = '$baseUrl$historyUrl';
    try {
      
      isLoading.value =true;
      print("inside try");
      var response = await getMethode(url, context, headers);
      if (response.statusCode == 200) {
        historyModel.value = historyFromJson(response.body);
        print('Respones Success');

      } else {
        Map<String, dynamic> error = json.decode(response.body);
        print('error[' 'message' ']');
        isLoading(false);
        if (context.mounted) {
          commonSnackBar(context: context, msg: error['message']);
        }
      }
    } catch (e) {
      isLoading.value =false;
      print(e.toString());
      isLoading(false);
    } finally {
      print('finally');
      isLoading(false);
    }
  }
}
