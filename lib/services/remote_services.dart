import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rudra_it_hub/model/chap_of_sub_model.dart';
import 'package:rudra_it_hub/model/study_model.dart';


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
              Subject(imageUrl: item2['img'], subName: item2['subjectName']));
          // print(item2['img']);
        }
        mainList.add(StudyModel(std: item['std'].toString(), sub: subb));
      }
      
      return mainList;
    }
    else{
      return [];
    }
  }
}
