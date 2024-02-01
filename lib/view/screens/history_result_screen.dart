// quiz_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rudra_it_hub/view/widgets/common_card.dart';
import '../../controller/history_controller.dart';

class HistoryDetail extends StatelessWidget {
  final QuizController controller = Get.put(QuizController());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Results'),
      ),
      body: ListView.builder(
        itemCount: controller.totalQuestions + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildPurpleCard(context, screenWidth, screenHeight);
          } else {
            return Padding(
              padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.015,
              ),
              child:
                  _buildQuestionCard(context, index, screenWidth, screenHeight),
            );
          }
        },
      ),
    );
  }

  Widget _buildPurpleCard(
      BuildContext context, double screenWidth, double screenHeight) {
    return Card(
      margin: EdgeInsets.all(screenWidth * 0.01),
      child: Container(
        padding: EdgeInsets.all(
            screenHeight * 0.02), // Adjusted based on screenHeight
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildResultCard('Total Questions',
                  '${controller.totalQuestions}', screenWidth, screenHeight),
              _buildResultCard('Right Answer', '${controller.rightAnswers}',
                  screenWidth, screenHeight),
              _buildResultCard('Wrong Answer', '${controller.wrongAnswers}',
                  screenWidth, screenHeight)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultCard(
      String title, String value, double screenWidth, double screenHeight) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.02),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: screenHeight * 0.03,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              value,
              style:
                  TextStyle(fontSize: screenHeight * 0.03, color: Colors.black),
            ),
            SizedBox(height: screenHeight * 0.02),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionCard(BuildContext context, int index, double screenWidth,
      double screenHeight) {
    String question = controller.getQuestion(index);
    List<String> options = controller.getOptions(index);
    String correctAnswer = controller.getCorrectAnswer(index);

    return Card(
      elevation: 5,
      margin: EdgeInsets.all(screenWidth * 0.02),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(screenWidth * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  '$index: $question',
                  style: TextStyle(
                    fontSize:
                        screenHeight * 0.04, // Adjusted based on screenHeight
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.start,
                ),
                SizedBox(height: screenHeight * 0.02),
                for (String option in options) HsAnswerCard(option: option),
              ],
            ),
          ),
          SizedBox(),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '$correctAnswer',
                style: TextStyle(
                  color: Colors.red,
                  fontSize: screenHeight * 0.030,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
