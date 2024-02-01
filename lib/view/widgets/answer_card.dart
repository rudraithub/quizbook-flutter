import 'package:flutter/material.dart';
import 'package:rudra_it_hub/utils/constants.dart';

class AnswerCard extends StatelessWidget {
  const AnswerCard({
    super.key,
    required this.question,
    required this.isSelected,
    required this.currentIndex,
    required this.correctAnswerIndex,
    required this.selectedAnswerIndex,
  });

  final String question;
  final bool isSelected;
  final int? correctAnswerIndex;
  final int? selectedAnswerIndex;
  final int currentIndex;


  @override
  Widget build(BuildContext context) {
    double screenHeight = getScreenHeight(context);
    bool isCorrectAnswer = (currentIndex == correctAnswerIndex);
    bool isWrongAnswer = !isCorrectAnswer && isSelected;
    return selectedAnswerIndex != null ? Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0), // Set border radius
        side: BorderSide(
            color: isCorrectAnswer ? Colors.green : isWrongAnswer ? Colors.red : Colors.white,
            width: 1.0), // Set border color and width
      ),
      color: isCorrectAnswer ? Colors.green[100] : isWrongAnswer ? Colors.red[100] : Colors.white,
      child: ListTile(
        title: Text(
          question,
          style:  TextStyle(fontSize: screenHeight * 0.025),
        ),
      ),
    )

    // If no option is selected
        : Card(
      color: Colors.white,
      child: ListTile(
        title: Text(
          question,
          style:  TextStyle(fontSize: screenHeight * 0.025),
        ),
        // onTap: (){
        //   print('tap');
        // },
      ),
    );
  }
}



