// ignore_for_file: avoid_print, unused_local_variable, unused_element, non_constant_identifier_names, file_names

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:rudra_it_hub/appUrl/all_url.dart';
import 'package:rudra_it_hub/controller/upload_image_controller.dart';
import 'package:rudra_it_hub/http_methods/http_all_method.dart';
import 'package:rudra_it_hub/model/login_model_alpesh.dart';
import 'package:rudra_it_hub/splash_screen.dart';
import 'package:rudra_it_hub/utils/preference_helper.dart';
import 'package:rudra_it_hub/utils/prefrences.dart';
import 'package:rudra_it_hub/view/screens/login_view.dart';
import 'package:rudra_it_hub/widgets/commo_alert_dilog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class SignUpController extends GetxController {
  final RxString selectedGender = 'Select Gender'.obs;
  final RxString selectedBirthDate = 'Select Date'.obs;
  final RxString selectedDesignation = 'Select Designation'.obs;
  RxList<String> genders = ["Select Gender", "Male", "Female", "Other"].obs;
  Rx<String> firstNameobx = ''.obs;
  Rx<String> lastNameobx = ''.obs;

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
    PhotoController photoController = PhotoController();
    final users = LoginModel(
      status: userData!.status,
      token: userBearerToken!,
      message: userData!.message,
      data: Data(
        id: userData!.data.id,
        firstName: firstName,
        lastName: lastName,
        email: userData!.data.email,
        gender: userData!.data.gender,
        dob: userData!.data.dob,
        mobileNumber: userData!.data.mobileNumber,
        profession: userData!.data.profession,
        userProfile: userData!.data.userProfile,
      ),
    );

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
        firstNameobx.value = firstName;
        lastNameobx.value = lastName;

        if (context.mounted) {
          DialogUtils.showCustomDialog(context, "Success", "User Data Updated");
        }
        return true;
      } else {
        Map<String, dynamic> error = json.decode(response.body);
        print(error['message']);

        if (context.mounted) {
          Map<String, dynamic> error = json.decode(response.body);
          DialogUtils.showCustomDialog(context, "Ops!!!", error['message']);
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
      File file,
      BuildContext context) async {
    print(dob.toString());

    String formattedDate =
        "${dob.day.toString().padLeft(2, '0')}/${dob.month.toString().padLeft(2, '0')}/${dob.year.toString()}";
    print(formattedDate);

    final Map<String, String> requestBody = {
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "genderID": '$gender',
      "DOB": formattedDate,
      "mobileNumber": mobileNo,
      "professionId": '$professionId',
    };

    final Map<String, String> headers = {'Content-Type': 'multipart/form-data'};

    try {
      List<int> imageBytes = await file.readAsBytes();

      String fileName = file.path.split('/').last;

      var imagePart = await http.MultipartFile.fromPath(
        'userProfile',
        file.path,
      );

      final request =
          http.MultipartRequest('POST', Uri.parse('$baseUrl$signupUrl'));
      request.files.add(imagePart);

      request.fields.addAll(requestBody);

      final response = await request.send();
      const url = '$baseUrl$signupUrl';

      var response2 = await http.Response.fromStream(response);
      final result = jsonDecode(response2.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        if (context.mounted) {
          DialogUtils.showCustomDialog(
              context, "Success", 'Registration Successfull');
        }

        Get.offAll(LoginScreen());
      } else {
        if (context.mounted) {
          Map<String, dynamic> error = json.decode(response2.body);
          DialogUtils.showCustomDialog(context, "Ops!!!", error['message']);
        }
      }
    } catch (e) {
      print("Catch$e");
    } finally {
      print("Finally");
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
