// ignore_for_file: avoid_print, unused_local_variable, unused_element, non_constant_identifier_names, file_names

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rudra_it_hub/appUrl/all_url.dart';
import 'package:rudra_it_hub/http_methods/http_all_method.dart';
import 'package:rudra_it_hub/view/screens/login_view.dart';
import 'package:rudra_it_hub/widgets/common_snack_bar.dart';

class SignUpController extends GetxController {
  final RxString selectedGender = 'Select Gender'.obs;
  final RxString selectedBirthDate = 'Select Date'.obs;
  final RxString selectedDesignation = 'Select Designation'.obs;
  RxList<String> genders = ["Select Gender", "Male", "Female", "Other"].obs;

  RxList<String> designations =
      ["Select Designation", "Teacher", "Engineer", "Principal"].obs;

  void signUp(
      String firstName,
      String lastName,
      String email,
      int gender,
      DateTime dob,
      String mobileNo,
      int professionId,
      BuildContext context) async {
    String formattedDate =
        "${dob.day.toString().padLeft(2, '0')}/${dob.month.toString().padLeft(2, '0')}/${dob.year.toString()}";
    final Map<String, dynamic> requestBody = {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "password": 'Password Is here',
      "genderID": gender,
      "DOB": formattedDate,
      "mobileNumber": mobileNo,
      "professionId": professionId,
    };
    final Map<String, String> headers = {'Content-Type': 'application/json'};
    // const uri = 'http://192.168.1.22:3000/users/signup';
    const url = '$baseUrl$signupUrl';
    var response = await postMethod(url, requestBody, headers);
    if (response.statusCode == 200) {
      print('response success');
      if (context.mounted) {
        commonSnackBar(
            context: context, msg: jsonDecode(response.body)['message']);
      }

      Get.offAll(LoginScreen());
    } else {
      Map<String, dynamic> error = json.decode(response.body);
      print(error['message']);

      if (context.mounted) {
        commonSnackBar(context: context, msg: error['message']);
      }

      // print('${response.body.toString()}');
    }
  }

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
