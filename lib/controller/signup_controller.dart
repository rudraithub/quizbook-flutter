// ignore_for_file: avoid_print, unused_local_variable, unused_element, non_constant_identifier_names, file_names

import 'package:get/get.dart';

class SignUpController extends GetxController {
  final RxString selectedGender = 'Select Gender'.obs;
  final RxString selectedBirthDate = 'Select Date'.obs;
  final RxString selectedDesignation = 'Select Designation'.obs;
  RxList<String> genders = ["Select Gender", "Male", "Female", "Other"].obs;

  RxList<String> designations =
      ["Select Designation", "Teacher", "Engineer", "Principal"].obs;

  void changeGender(String gender) {
    if (gender != 'Select Gender') {
      selectedGender.value = gender;
      genders.remove('Select Gender');
    }
  }

  void changeBirthDate(String Date) {
    selectedBirthDate.value = Date;
  }

  void changeDesignation(String Designation) {
    if (Designation != 'Select Designation') {
      selectedDesignation.value = Designation;
      designations.remove('Select Designation');
    }

    void verifyOtp() {}
  }

//----------------------------------
}
