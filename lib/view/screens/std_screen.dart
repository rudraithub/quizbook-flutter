// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:rudra_it_hub/controller/subject_controller.dart';

import 'package:rudra_it_hub/model/study_model.dart';
import 'package:rudra_it_hub/widgets/study_item.dart';

class StudyScreen extends StatefulWidget {
  const StudyScreen({
    super.key,
  });

  @override
  State<StudyScreen> createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen> {
  List<Temperatures> studyList = [];
  Temperatures? studyModel;

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
        body: RefreshIndicator(
          color: Colors.purple,
          strokeWidth: 2,
          displacement: 180,
          onRefresh: () async {
            setState(() {
              provider.fetchStudyModel(context);
            });
          },
          child: Obx(
            () {
              if (provider.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              } else if (provider.stdList.value.data.isEmpty) {
                return const Center(
                  child: Text(
                    "Currently No Quiz Available",
                    style: TextStyle(fontSize: 20),
                  ),
                );
              } else {
                bool anySubjectNotEmpty = provider.stdList.value.data.any((element) => element.subjects.isNotEmpty);
                if (anySubjectNotEmpty) {
                  return ListView.builder(
                  itemCount: provider.stdList.value.data.length,
                  itemBuilder: (context, index) {
                    if (provider.stdList.value.data[index].subjects.isEmpty) {
                      return null;
                    }
                    return StudyItem(
                      model: provider.stdList.value.data[index],
                    );
                  },
                );
                }
                else{
                   return const Center(
                  child: Text(
                    "Currently No Quiz Available",
                    style: TextStyle(fontSize: 20),
                  ),
                );
                }
              }
            },
          ),
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