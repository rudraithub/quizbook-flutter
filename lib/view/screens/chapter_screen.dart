import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:rudra_it_hub/controller/chapter_controller.dart';
import 'package:rudra_it_hub/utils/constants.dart';
import 'package:rudra_it_hub/view/screens/quiz_view_alpesh.dart';

ChapterController chProvider = ChapterController();

class ChapterScreen extends StatefulWidget {
  const ChapterScreen(
      {super.key,
      required this.subId,
      required this.stdId,
      required this.subject,
      required this.std});

  final String subject;
  final int subId;
  final int stdId;
  final String std;
  @override
  State<ChapterScreen> createState() {
    return _ChapterScreenState();
  }
}

class _ChapterScreenState extends State<ChapterScreen> {
  @override
  void initState() {
    // print("sub stdId ${widget.stdId} :subId: ${widget.subId} :std: ${widget.std}");
    chProvider.fetchChapter(widget.stdId, widget.subId ,context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            title: Text(
              "${widget.std} : ${widget.subject.toUpperCase()}",
              style: TextStyle(fontSize: getScreenHeight(context) * 0.035),
            ),
          ),
          body: ListView.builder(
            itemCount: chProvider.stdList.value.data.length,
            itemBuilder: (context, index) {
              final item = chProvider.stdList.value.data[index];
              if (chProvider.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              else {
                return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => QuizScreen(
                              stdId: widget.stdId,
                              subId: widget.subId,
                              chapterId: item.chapterid, titleName: item.content,
                            ),
                          ));
                    },
                    child: CustomItem(
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
      padding: const EdgeInsets.all(2.0),
      child: Card(
        color: Colors.white,
        // color: Colors.white,
        // elevation: 10,
        child: ListTile(
          leading :
          // leading: Container(
          //   height: 100,
          //   width: 50,
          //   child:CircleAvatar(
          //     // radius: screenHeight * 0.075,
          //     backgroundImage:
          //     const AssetImage('assets/images/normal_number_bg.png'),
          //     maxRadius: screenHeight * 0.035,
          //     child: Text(
          //       logoIndex,
          //       style: const TextStyle(color: Colors.white ,fontSize: 20),
          //     ),
          //   ) ,
          // ),
          Container(
            width: 65.0,
            height: 85.0,
            decoration:const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue, // You can set the background color of the circle
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClipOval(
                  child: Image.asset(
                    'assets/images/normal_number_bg.png', // Replace with your image URL
                    width: 65.0,
                    height: 85.0,
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  logoIndex,
                  style:const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),


          title: Text(
            "Cha No $logoIndex : $chName",
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
                    radius: screenHeight * 0.015,
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
                  SizedBox(
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
                  SizedBox(
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
