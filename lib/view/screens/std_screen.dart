// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:rudra_it_hub/controller/subject_controller.dart';

import 'package:rudra_it_hub/model/study_model.dart';
import 'package:rudra_it_hub/view/widgets/study_item.dart';

class StudyScreen extends StatefulWidget {
  const StudyScreen({
    super.key,
  });


  @override
  State<StudyScreen> createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen> {
  List<StudyModel> studyList = [];
  StudyModel? studyModel;

  final SubjectProvider provider = Get.put(SubjectProvider());
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Standards",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 2,
          shadowColor: Colors.grey,
        ),
        body: Obx(
          () {
            if (provider.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else {
              // if(provider.stdList.isEmpty){
              //   return  const Center(child: Text("The  server is not responding please try again later."  ,textAlign: TextAlign.center,),) ;
              // }
              print("std screen in ${provider.stdList}");
              return ListView.builder(
                itemCount: provider.stdList.length,
                itemBuilder: (context, index) {
                  return StudyItem(model: provider.stdList[index]);
                },
              );
            }
          },
        ));
  }
}















// void loadData() async{
//     final uri = Uri.parse('http://192.168.1.19:3000/std');
//     try {
//       print('inside try');
//         http.Response response = await http.get(uri);
//         final Map<String,dynamic> listData = json.decode(response.body);
//         final List<StudyModel> mainList = [];
//         print(response.statusCode);
        
//         for(final item in listData['data']){
//           print(item['std']);
//           List<Subject> subb = [];
//           for (final item2 in item['subject']) {
//             subb.add(Subject(imageUrl: item2['img'], subName: item2['subjectName'])) ;                       
//             // print(item2['img']);
//           }
//           mainList.add(StudyModel(std: item['std'].toString(), sub: subb));
          
//         }
//         setState(() {
//         studyList = mainList;
//         _isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         _eror = e.toString();
//         print(e.toString());
//       });
//     }
//   }