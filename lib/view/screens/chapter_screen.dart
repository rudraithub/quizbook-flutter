import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rudra_it_hub/controller/chapter_cantroller.dart';
 final ChpaterProvider chProvider = Get.put(ChpaterProvider());
class ChapterScreen extends StatelessWidget {
  const ChapterScreen({super.key , required this.subject , required this.std});
 
final String subject;
final String std;
  @override
  Widget build(BuildContext context) {
    return Obx(() => 
    Scaffold(
      appBar: AppBar(title: Text("$std : ${subject.toUpperCase()}"),),
      body: ListView.builder(
        itemCount: chProvider.stdList.value.data.length,
        itemBuilder: (context, index) {
          
          print('llllll');
          final item = chProvider.stdList.value.data[index];
          print(index.toString());
          if (chProvider.isLoading.value) {
            return Center(child: CircularProgressIndicator(),)            ;

          }
          else{
            return CustomItem(
            logoIndex: item.chapterno.toString(),
            chName: item.content,
            teacherName: item.teacher,
            questionNo: item.que,
            min: item.minute,
          );
          }
        },
      ),
    )
    );
  }
}

class CustomItem extends StatelessWidget {
  final String logoIndex;

  final String chName;

  final String teacherName;
  final int questionNo;
  final String min;

  const CustomItem(
      {super.key,
      required this.logoIndex,
      required this.chName,
      required this.teacherName,
      required this.questionNo,
      required this.min,
      logoImage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color:Colors.white,
        // color: Colors.white,
        elevation: 10,
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: const AssetImage('assets/images/normal_number_bg.png'),
            child: Text(
              logoIndex,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          title: Text(
            chName,
            style: const TextStyle(color: Colors.black, fontSize: 20),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                 const CircleAvatar(
                    radius: 12,
                    backgroundImage: AssetImage(
                      'assets/images/logo.png',
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(teacherName),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                      height: 17,
                      width: 20,
                      child: Image.asset('assets/images/question_icon.png')),
                  const SizedBox(
                    width: 5,
                  ),
                  Text('Question No: $questionNo'),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                      height: 20,
                      width: 20,
                      child: Image.asset('assets/images/time_icon.png')),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(min),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
