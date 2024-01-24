import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:rudra_it_hub/controller/quiz_controller.dart';
import 'package:rudra_it_hub/model/chap_of_sub_model.dart';
import 'package:rudra_it_hub/model/question2_model.dart';
import 'package:rudra_it_hub/model/question_model.dart';
import 'package:rudra_it_hub/model/study_model.dart';
import 'package:rudra_it_hub/model/user.dart';

class RemoteServices {
  static var client = http.Client();
  QuestionController questionController = QuestionController();

  static Future<Chapter> fatchChepter(int stdId , int subId) async {
    try{
      final uri = Uri.parse('http://192.168.1.19:3000/std/$stdId/subject/$subId/chapter');
      var response = await client.get(uri);
      if (response.statusCode == 200) {
        print('success');
        var jsonString = response.body;
        return chapterFromJson(jsonString);
      } else {
        print('hiiiii');
        return Chapter(status: 0, data: [], message: '');
      }
    }
    catch(e){
      print(e.toString());
      return Chapter(status: 0, data: [], message: '');
    }
  }

  static Future<String> signUpApi(
      String firstName,
      String lastName,
      String email,
      String gender,
      DateTime dob,
      String mobileNo,
      int professionId,
      BuildContext context) async {
    DateTime dob2 = DateTime(dob.year, dob.month, dob.day);
    String formattedDOB = dob2.toUtc().toIso8601String();

    String formattedDate = "${dob.day.toString().padLeft(2,'0')}/${dob.month.toString().padLeft(2,'0')}/${dob.year.toString()}";
print(formattedDate);
    // String formattedDate = "${dob.day}-${dob.month}-${dob.year}";
    print(formattedDate);
    final Map<String, dynamic> requestBody = {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": 'Password Is here',
      "gender": gender,
      "DOB": formattedDate,
      "mobileNumber": mobileNo,
      "professionId": professionId,
    };
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    const uri = 'http://192.168.1.19:3000/users/signup';
    var response = await http.post(Uri.parse(uri),
        headers: headers, body: jsonEncode(requestBody));
    if (response.statusCode == 200) {
      print(response.statusCode);
      return '';
    } else {
      Map<String, dynamic> error = json.decode(response.body);
      print(error['message']);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error['message'], style: TextStyle(fontSize: 15)),
          duration: Duration(seconds: 2),
        ),
      );
      print('${response.body.toString()}');
      return response.body.toString();
    }
  }

  static Future<List<StudyModel>> fetchStudyModel() async {
    final uri = Uri.parse('http://192.168.1.19:3000/std');
    var response = await client.get(uri);

    if (response.statusCode == 200) {
      final List<StudyModel> mainList = [];
      final Map<String, dynamic> listData = json.decode(response.body);

      for (final item in listData['data']) {
        List<Subject> subb = [];
        for (final item2 in item['subject']) {
          subb.add(
              Subject(imageUrl: item2['img'], subName: item2['subjectName'] , subId: item2['subid']));
          // print(item2['img']);
        }
        // print(item['stdid']);/
        mainList.add(StudyModel(std: item['std'].toString(), sub: subb , stdId: item['stdid']));
      }

      return mainList;
    } else {
      print('Error to load Data');
      return [];
    }
  }

  static Future<User2> fatchUserDetails(String moNumber) async {
    final Map<String, dynamic> reqebody = {
      "mobileNumber": moNumber,
    };
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    const uri = 'http://192.168.1.19:3000/users/login';
    var response = await http.post(Uri.parse(uri),
        headers: headers, body: jsonEncode(reqebody));

    if (response.statusCode == 200) {
      // print('success');
      final responseString = response;
      final User2 user =  userFromJson(responseString.body);
      // print(response.body);
      return user;
    }
    else {
      return User2(
          status: 0,
          data: UserData(
              id: '',
              firstName: '',
              lastName: '',
              email: '',
              gender: '',
              dob: '',
              mobileNumber: '',
              profession: [],
              userId: 0,
              v: 0),
          message: '');
    }
  }

  static Future<bool> getUserAvailable(
      String moNo, BuildContext context) async {
    final Map<String, String> body = {"mobileNumber": "7513444577"};
    final Map<String, String> head = {'Content-Type': 'application/json'};
    const uri = 'http://192.168.1.22:3000/user/varify';
    try {
      // print(body);
      // var response = await http.post(Uri.parse(uri),
      //     headers: <String, String>{'Content-Type': 'application/json'},
      //   body: jsonEncode(<String, dynamic>{
      //     "mobileNumber": '7513444577',
      //   }),);
      var headers = <String, String>{};
      headers['Content-Type'] = 'application/json';

// Body map
      var body = <String, dynamic>{};
      body['mobileNumber'] = "9484779764";

// Encode body
      var encodedBody = jsonEncode(body);

// Make request
      var response = await http.post(
          Uri.parse(uri),
          headers: headers,
          body: encodedBody
      );


      if (response.statusCode == 200) {
        // print('success');
        final responseString = response;

        // print(response.body);
        // print('hi1234');
        return true;
      } else {
        Map<String, dynamic> error = json.decode(response.body);
        print(error['message']);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error['message'], style: TextStyle(fontSize: 15)),
            duration: Duration(seconds: 2),
          ),
        );
        return false;
      }
    } catch (e) {
      print('Prashant '  + e.toString());
      return false;
    }
  }

  static Future<Object>getQuestionList(int stdId , subId , chapterId ,
      BuildContext context)async{

    try {


      var response = await http.get(
          Uri.parse('http://192.168.1.19:3000/std/$stdId/subject/$subId/chapter/$chapterId/questions'),

      );


      if (response.statusCode == 200) {
        final responseString = response;
        print('Chapter Get Succefuly');
        final String st = response.body;
        Temperatures tm =   temperaturesFromJson(st);
        return tm.data;
      } else {
        Map<String, dynamic> error = json.decode(response.body);
        print(error['message']);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error['message'], style: TextStyle(fontSize: 15)),
            duration: Duration(seconds: 2),
          ),
        );
        return Question2(queid: 0, chapterid: 0, stdid: 0, subid: 0, questionNo: 0, question: '0', option: Option(a: 'a', b: 'b', c: 'c', d: 'd'), rightAns: '');
      }
    } catch (e) {
      print('Makwwana '  + e.toString());
      return Question2(queid: 0, chapterid: 0, stdid: 0, subid: 0, questionNo: 0, question: '0', option: Option(a: 'a', b: 'b', c: 'c', d: 'd'), rightAns: '');
    }
}
}
