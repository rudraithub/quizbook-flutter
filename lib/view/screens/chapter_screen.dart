import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rudra_it_hub/controller/chapter_cantroller.dart';
import 'package:rudra_it_hub/utils/constans.dart';
import 'package:rudra_it_hub/view/screens/quiz_view.dart';

final ChpaterProvider chProvider = Get.put(ChpaterProvider());

class ChapterScreen extends StatelessWidget {
  const ChapterScreen({super.key, required this.subject, required this.std});

  final String subject;
  final String std;
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(

            title: Text(
              "$std : ${subject.toUpperCase()}",
              style: TextStyle(fontSize: getScreenHeight(context) * 0.035),
            ),
          ),
          body: ListView.builder(
            itemCount: chProvider.stdList.value.data.length,
            itemBuilder: (context, index) {
              // print('llllll');
              final item = chProvider.stdList.value.data[index];
              print(index.toString());
              if (chProvider.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => QuizScreen(),));
                    },
                    child : CustomItem(
                  logoIndex: item.chapterno.toString(),
                  chName: item.content,
                  teacherName: item.teacher,
                  questionNo: item.que,
                  min: item.minute,
                ));
              }
            },
          ),
        ));
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
    double screenHeight = getScreenHeight(context);
    double screenWidth = getScreenWidth(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: Colors.white,
        // color: Colors.white,
        elevation: 10,
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage:
                const AssetImage('assets/images/normal_number_bg.png'),
            child: Text(
              logoIndex,
              style: const TextStyle(color: Colors.white),
            ),
            maxRadius: screenWidth * 0.0750,
          ),
          title: Text(
            chName,
            style: TextStyle(
                color: Colors.black,
                overflow: TextOverflow.ellipsis,
                fontSize: screenHeight * 0.025),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: screenHeight * 0.02,
                    backgroundImage: const AssetImage(
                      'assets/images/logo.png',
                    ),
                    // maxRadius: screenHeight * 0.01,
                  ),
                  SizedBox(
                    width: screenWidth * 0.01,
                  ),
                  Text(
                    teacherName,
                    style: TextStyle(fontSize: screenHeight * 0.023),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: screenHeight * 0.02,
                      width: screenHeight * 0.02,
                      child: Image.asset('assets/images/question_icon.png')),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Question No: $questionNo',
                    style: TextStyle(
                        fontSize: screenHeight * 0.02,
                        overflow: TextOverflow.ellipsis),
                    textAlign: TextAlign.center,
                  ),
                  // SizedBox(
                  //   height: screenHeight * 0.009,
                  // ),
                  SizedBox(
                    width: screenWidth * 0.01,
                  ),
                  Container(
                      height: screenHeight * 0.02,
                      width: screenHeight * 0.02,
                      child: Image.asset('assets/images/time_icon.png')),
                  const SizedBox(
                    width: 5,
                  ),
                  Text(
                    min,
                    style: TextStyle(fontSize: screenHeight * 0.02),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
