// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rudra_it_hub/appUrl/all_url.dart';
import 'package:rudra_it_hub/appUrl/http_all_method.dart';
import 'package:rudra_it_hub/controller/quiz_controller.dart';
import 'package:rudra_it_hub/model/chap_of_sub_model.dart';
import 'package:rudra_it_hub/model/study_model.dart';

import 'package:rudra_it_hub/view/widgets/common_snack_bar.dart';

import '../model/login_model_alpesh.dart';
import '../model/question_api_data.dart';
import '../splash_screen.dart';

class RemoteServices {
  static var client = http.Client();
  QuestionController questionController = QuestionController();
  // LoginController loginController = LoginController();
  // final TextEditingController _mobileController = TextEditingController();

  // static Future<Chapter> fatchChapter(int stdId, int subId) async {
  //   try {
  //     final uri = Uri.parse('$baseUrl$chapterUrl'
  //         // 'http://192.168.1.22:3000/std/$stdId/subject/$subId/chapter'
  //         );
  //
  //     var headers = <String, String>{};
  //     headers['Content-Type'] = 'application/json';
  //
  //     var body = <String, dynamic>{"stdid": stdId, "subid": subId};
  //     var response =await postMethod('$baseUrl$chapterUrl', body, headers);
  //
  //
  //     if (response.statusCode == 200) {
  //       var jsonString = response.body;
  //       return chapterFromJson(jsonString);
  //     } else {
  //       return Chapter(status: 0, data: [], message: '');
  //     }
  //   } catch (e) {
  //     return Chapter(status: 0, data: [], message: '');
  //   }
  // }

  static Future<bool> signUpApi(
      String firstName,
      String lastName,
      String email,
      int gender,
      DateTime dob,
      String mobileNo,
      int professionId,
      BuildContext context) async {
    DateTime dob2 = DateTime(dob.year, dob.month, dob.day);
    String formattedDOB = dob2.toUtc().toIso8601String();

    String formattedDate =
        "${dob.day.toString().padLeft(2, '0')}/${dob.month.toString().padLeft(2, '0')}/${dob.year.toString()}";
    print(gender);
    // String formattedDate = "${dob.day}-${dob.month}-${dob.year}";

    final Map<String, dynamic> requestBody = {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": 'Password Is here',
      "genderID": gender,
      "DOB": formattedDate,
      "mobileNumber": mobileNo,
      "professionId": professionId,
    };
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    // const uri = 'http://192.168.1.22:3000/users/signup';
    const uri = '$baseUrl$signupUrl';
    var response = await http.post(Uri.parse(uri),
        headers: headers, body: jsonEncode(requestBody));
    if (response.statusCode == 200) {
      commonSnackBar(
          context: context, msg: jsonDecode(response.body)['message']);
      return true;
    } else {
      Map<String, dynamic> error = json.decode(response.body);
      print(error['message']);

      commonSnackBar(context: context, msg: error['message']);

      print('${response.body.toString()}');
      return false;
    }
  }

  static Future<List<StudyModel>> fetchStudyModel() async {
    // final uri = Uri.parse('http://192.168.1.22:3000/std');
    final uri = Uri.parse('$baseUrl$dashboardUrl');
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      final List<StudyModel> mainList = [];
      final Map<String, dynamic> listData = json.decode(response.body);

      for (final item in listData['data']) {
        List<Subject> subb = [];
        for (final item2 in item['subject']) {
          subb.add(Subject(
              imageUrl: item2['img'],
              subName: item2['subjectName'],
              subId: item2['subid']));
          // print(item2['img']);
        }
        // print(item['stdid']);/
        mainList.add(StudyModel(
            std: item['std'].toString(), sub: subb, stdId: item['stdid']));
      }
      return mainList;
    } else {
      print('Error to load Data');
      return [];
    }
  }

  static Future<LogInModel> fatchUserDetails(
      String moNumber, BuildContext context) async {
    final Map<String, dynamic> reqebody = {
      "mobileNumber": moNumber,
    };
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    // const uri = 'http://192.168.1.22:3000/users/login';
    const uri = '$baseUrl$loginUrl';
    var response = await http.post(Uri.parse(uri),
        headers: headers, body: jsonEncode(reqebody));

    try {
      if (response.statusCode == 200) {
        return logInModelFromJson(response.body);
      } else {
        commonSnackBar(context: context, msg: "catch ${response.body}");
        return LogInModel();
      }
    } catch (e) {
      commonSnackBar(context: context, msg: "catch ${e.toString()}");
      return LogInModel();
    }
  }

//   static Future<bool> getUserAvailable(
//       String moNo, BuildContext context) async {
//     const uri = '$baseUrl$userVerifyUrl';
//     try {
//       var headers = <String, String>{};
//       headers['Content-Type'] = 'application/json';
//
// // Body map
//       var body = <String, dynamic>{"mobileNumber": moNo};
//
// // Encode body
//       var encodedBody = jsonEncode(body);
//
// // Make request
//       var response =
//           await http.post(Uri.parse(uri), headers: headers, body: encodedBody);
//
//       if (response.statusCode == 200) {
//         final responseString = response;
//         return true;
//       } else {
//         Map<String, dynamic> error = json.decode(response.body);
//         print(error['message']);
//
//         commonSnackBar(context: context, msg: error['message']);
//
//         return false;
//       }
//     } catch (e) {
//       commonSnackBar(context: context, msg: e.toString());
//
//       print('Prashant ' + e.toString());
//       return false;
//     }
//   }

  static Future<QuestionApiData> getQuestionList(
      {required int stdId,
      required subId,
      required chapterId,
      required BuildContext context}) async {
    try {
      print(
          "qution screen id stdId : ${stdId} subId : $subId chapterid : $chapterId");
      var body = <String, dynamic>{
        "stdid": stdId,
        "subid": subId,
        "chapterid": chapterId
      };
      final Map<String, String> headers = {'Content-Type': 'application/json'};

      var response = await http.post(Uri.parse('$baseUrl$questionUrl'),
          body: jsonEncode(body), headers: headers);
      if (response.statusCode == 200) {
        QuestionApiData tm = questionApiDataFromJson(response.body);
        return tm;
      } else {
        Map<String, dynamic> data = json.decode(response.body);
        String message = data['message'];
        print(message);
        commonSnackBar(context: context, msg: message);
        return QuestionApiData();
      }
    } catch (e) {
      print("error msg ${e.toString()}");
      commonSnackBar(context: context, msg: "catch ${e.toString()}");
      return QuestionApiData();
    }
  }

  static Future<bool> resultDataSend({
    required BuildContext context,
    required int stdid,
    required int subid,
    required int chapterid,
    required List questions,
  }) async {
    String uri = '$baseUrl$resultUrl';
    try {
      var headers = <String, String>{};
      headers['Content-Type'] = 'application/json';
      headers['Authorization'] = userBearerToken ?? '';

      var body = <String, dynamic>{
        // "userID": userID,
        "stdid": stdid,
        "subid": subid,
        "chapterid": chapterid,
        "questions": questions
      };

      var encodedBody = jsonEncode(body);

      var response =
          await http.post(Uri.parse(uri), headers: headers, body: encodedBody);

      print("just data for ${response}");
      if (response.statusCode == 200) {
        return true;
      } else {
        commonSnackBar(context: context, msg: response.body);
        return false;
      }
    } catch (e) {
      commonSnackBar(
          context: context, msg: "Catch ${e.toString()}", durationSeconds: 5);
      return false;
    }
  }
}


