import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:rudra_it_hub/getx/data_provider.dart';

import 'package:rudra_it_hub/view/screens/std_screen.dart';

class StudyModelController extends StatefulWidget {
  const StudyModelController({super.key});

  @override
  State<StudyModelController> createState() => _StudyModelControllerState();
}

class _StudyModelControllerState extends State<StudyModelController> {
  final DataProvider provider = Get.put(DataProvider());
  @override
  Widget build(BuildContext context) {
    return StudyScreen(dataList: provider.data);
  }
}
