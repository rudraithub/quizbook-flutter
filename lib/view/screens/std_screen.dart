import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:rudra_it_hub/controller/subject_provider.dart';

import 'package:rudra_it_hub/model/study_model.dart';
import 'package:rudra_it_hub/view/widgets/study_item.dart';

class StudyScreen extends StatefulWidget {
  const StudyScreen({
    super.key,
  });
  // final List<StudyModel> dataList;

  @override
  State<StudyScreen> createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen> {
  List<StudyModel> studyList = [];
  final SubjectProvider provider = Get.put(SubjectProvider());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Widget content = Center(child: Text('data'));

    // if (widget.dataList.isNotEmpty) {
    //   content =ListView.builder(
    //   itemCount: widget.dataList.length,
    //   itemBuilder: (context, index) {
    //     return StudyItem(model: provider.stdList[index]);
    //   },
    // );
    // }
    return Obx(
      () {
        if (provider.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
            itemCount: provider.stdList.length,
            itemBuilder: (context, index) {
              return StudyItem(model: provider.stdList[index]);
              
            },
          );
        }
      },
    );
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