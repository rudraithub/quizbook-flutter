import 'package:flutter/material.dart';

class HsAnswerCard extends StatelessWidget {
  final String option;

  HsAnswerCard({required this.option});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.01 / 2),
      child: Text(
        option,
        style: TextStyle(fontSize: MediaQuery.of(context).size.width * 0.04),
      ),
    );
  }
}
