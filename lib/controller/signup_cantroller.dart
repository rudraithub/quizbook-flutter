// ignore_for_file: avoid_print, unused_local_variable, unused_element, non_constant_identifier_names, file_names

import 'dart:convert';
import 'package:get/get.dart';


class SignUpController extends GetxController {
  final RxString selectedGender = 'Select Gender'.obs;
  final RxString selectedBirthDate = 'Select Date'.obs;
  final RxString selectedDesignation = 'Select Designation'.obs;
  RxList<String> genders = ["Select Gender", "Male", "Female", "Other"].obs;

  RxList<String> designations =
      ["Select Designation", "Teacher", "Engineer", "Principal"].obs;

  void chnageGender(String gender) {
    if (gender != 'Select Gender') {
      selectedGender.value = gender;
      genders.remove('Select Gender');
    }
    // funavtion to chnage value of gender
  }

  void chnageBirthDate(String Date) {
    selectedBirthDate.value = Date;
  }

  void chnageDesignation(String Designation) {
    if (Designation != 'Select Designation') {
      selectedDesignation.value = Designation;
      designations.remove('Select Designation');
    }

    void verifyOtp() {}
  }

//----------------------------------


}
