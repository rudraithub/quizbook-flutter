// ignore_for_file: avoid_print, unused_local_variable, unused_element, non_constant_identifier_names, file_names

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rudra_it_hub/appUrl/all_url.dart';
import 'package:rudra_it_hub/http_methods/http_all_method.dart';
import 'package:rudra_it_hub/model/login_model_alpesh.dart';
import 'package:rudra_it_hub/view/screens/login_view.dart';
import 'package:rudra_it_hub/widgets/common_snack_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../splash_screen.dart';
import '../utils/preference_helper.dart';
import '../utils/prefrences.dart';

class SignUpController extends GetxController {
  final RxString selectedGender = 'Select Gender'.obs;
  final RxString selectedBirthDate = 'Select Date'.obs;
  final RxString selectedDesignation = 'Select Designation'.obs;
  RxList<String> genders = ["Select Gender", "Male", "Female", "Other"].obs;

  RxList<String> designations =
      ["Select Designation", "Teacher", "Engineer", "Principal"].obs;

  void updateUser(
      String firstName, String lastName, BuildContext context) async {
    final Map<String, dynamic> requestBody = {
      "firstName": firstName,
      "lastName": lastName,
    };
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': userBearerToken!,
    };
    final users = LogInModel(
        status: userData!.status,
        message: userData!.message,
        data: Data(
             id :userData!.data!.id,
             firstName:firstName,
             lastName:lastName,
             email:userData!.data!.email,
         gender:userData!.data!.gender,
         dob:userData!.data!.dob,
        mobileNumber:userData!.data!.mobileNumber,
         profession:userData!.data!.profession,
         userId:userData!.data!.userId,
        ),
        token: userData!.token);

    var sharedPreferences = await SharedPreferences.getInstance();
    SharedPreferencesHelper sharedPreferencesHelper =
    SharedPreferencesHelper(sharedPreferences);
    final response = await postMethod(
        '$baseUrl$userProfileUpdateUrl', requestBody, headers, context);

    if (response.statusCode == 200) {
      print('here');
      await sharedPreferencesHelper.putString(
          Preferences.userFullDetails, jsonEncode(users));
      if (context.mounted) {
        commonSnackBar(context: context, msg: "Data Updated");
      }
    }
  }

    var response = await postMethod(url, requestBody, headers, context);
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

}
