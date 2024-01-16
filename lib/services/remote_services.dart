import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:rudra_it_hub/model/chap_of_sub_model.dart';
import 'package:rudra_it_hub/model/study_model.dart';
import 'package:rudra_it_hub/model/user.dart';


class RemoteServices {
  static var client = http.Client();

  static Future <Chapter> fatchChepter()async{
    final uri = Uri.parse('http://192.168.1.19:3000/std/1/subject/1/chapter');
    var response = await client.get(uri);
    if (response.statusCode ==200) {
      print('success');
      var jsonString = response.body;      
      return welcomeFromJson(jsonString);

    }
    else {
      return Chapter(status: 0, data: [], message: '');
    }
  }



  static Future<String> signUpApi(String firstName, String lastName, String email,
      String gender, DateTime dob, String mobileNo, int professionId ,BuildContext context) async {
    DateTime dob2 = DateTime(dob.year,dob.month,dob.day);
    String formattedDOB = dob2.toUtc().toIso8601String();

    String formattedDate = DateFormat('dd-MM-yyyy').format(dob);
    // String formattedDate = "${dob.day}-${dob.month}-${dob.year}";
    print(formattedDate);
    final Map<String, dynamic> requestBody = {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": 'Password Is here',
      "gender": gender,
      "DOB": formattedDOB,
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
      Map<String , dynamic> error = json.decode(response.body);
      print(error['message']);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error['message'],
              style: TextStyle(fontSize: 15)),
          duration: Duration(seconds: 2),
        ),
      );
      print('${response.body.toString()}');
      return response.body.toString();
    }
  }



  static Future<List<StudyModel>> fetchStudyModel() async {
    final uri = Uri.parse('http://192.168.1.19:3000/std/sub');
    var response = await client.get(uri);
    
    if (response.statusCode == 200) {
      final List<StudyModel> mainList = [];
      final Map<String, dynamic> listData = json.decode(response.body);
      
     

      for (final item in listData['data']) {
        
        List<Subject> subb = [];
        for (final item2 in item['subject']) {
          subb.add(
              Subject(imageUrl: item2['img'], subName: item2['subjectName']));
          // print(item2['img']);
        }
        mainList.add(StudyModel(std: item['std'].toString(), sub: subb));
      }
      
      return mainList;
    }
    else{
      print('Error to load Data');
      return [];
    }
  }
  static Future<User> fatchUserDetails() async {
    final Map<String, dynamic> reqebody = {
      "mobileNumber": '7513444577',
      "OTP": '1234',
    };
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    const uri = 'http://192.168.1.19:3000/users/login';
    var response = await http.post(Uri.parse(uri),
        headers: headers, body: jsonEncode(reqebody));

    if (response.statusCode == 200) {
      // print('success');
      final responseString = response;
      final User user = await userFromJson(responseString.body);
      // print(response.body);
      return user;
    } else {
      return User(
          status: 0,
          data: UserData(
              id: '',
              firstName: '',
              lastName: '',
              email: 'prashant',
              gender: '',
              dob: DateTime(2000),
              mobileNumber: '',
              profession: [],
              userId: 0,
              v: 0),
          message: '');
    }
  }
}



class RemoteServices2 {
  static var client = http.Client();

}

