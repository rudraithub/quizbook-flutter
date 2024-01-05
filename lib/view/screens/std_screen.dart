import 'package:flutter/material.dart';
import 'package:rudra_it_hub/model/study_model.dart';
import 'package:rudra_it_hub/view/widgets/study_item.dart';

class StudyScreen extends StatefulWidget {
  const StudyScreen({super.key , required this.dataList});
  final List<StudyModel> dataList;

  @override
  State<StudyScreen> createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen> {
  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
      itemCount: widget.dataList.length,
      itemBuilder: (context, index) {
      return StudyItem(model: widget.dataList[index]);
    },);
  }
}