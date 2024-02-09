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

  RxString selectedValue = ''.obs; // Observable string for the selected value

  RxBool isValid = false.obs; // Observable boolean for validation state

  void onItemSelected(String value) {
    selectedValue.value = value; // Update the selected value
    isValid.value = value.isNotEmpty; // Update the validation state
  }


  Future<bool> updateUser(
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
          id: userData!.data!.id,
          firstName: firstName,
          lastName: lastName,
          email: userData!.data!.email,
          gender: userData!.data!.gender,
          dob: userData!.data!.dob,
          mobileNumber: userData!.data!.mobileNumber,
          profession: userData!.data!.profession,
          userId: userData!.data!.userId,
        ),
        token: userData!.token);

    var sharedPreferences = await SharedPreferences.getInstance();
    SharedPreferencesHelper sharedPreferencesHelper =
        SharedPreferencesHelper(sharedPreferences);
    // ignore: use_build_context_synchronously
    final response = await postMethod(
        '$baseUrl$userProfileUpdateUrl', requestBody, headers, context);
    try {
      if (response.statusCode == 200) {
        print('here');

        await sharedPreferencesHelper.putString(
            Preferences.userFullDetails, jsonEncode(users));
        if (context.mounted) {
          commonSnackBar(context: context, msg: "Data Updated");
        }
        return true;
      } else {
        Map<String, dynamic> error = json.decode(response.body);
        print(error['message']);

        if (context.mounted) {
          commonSnackBar(context: context, msg: error['message']);
        }
        return false;
      }
    } catch (e) {
      print(e.toString());
      throw '';
    }
  }

  void signUp(
      String firstName,
      String lastName,
      String email,
      int gender,
      DateTime dob,
      String mobileNo,
      int professionId,
      BuildContext context) async {
    print(dob.toString());

    String formattedDate =
        "${dob.day.toString().padLeft(2, '0')}/${dob.month.toString().padLeft(2, '0')}/${dob.year.toString()}";
    print(formattedDate);
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

//----------------------------------
}
