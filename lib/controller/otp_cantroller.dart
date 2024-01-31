// ignore_for_file: unused_local_variable, body_might_complete_normally_catch_error

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:rudra_it_hub/appurl/all_url.dart';
import 'package:rudra_it_hub/utils/prefrence_helper.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/login_model_alpesh.dart';
import '../utils/prefrences.dart';
import '../view/screens/dashboard_view.dart';
import '../view/widgets/common_snackbar.dart';

class OTPController extends GetxController {
  Future<void> verifyOTP(

      String verificationId,
      TextEditingController _otpController,
      String moNumber,
      BuildContext context) async {
    PhoneAuthCredential credential = await PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: _otpController.text.toString());

    try {
      FirebaseAuth.instance
          .signInWithCredential(credential)
          .catchError((onError) async {
        commonSnackBar(context: context, msg: 'Please enter currect otp');
      }).then((value) async {
        LogInModel users = LogInModel();

        final Map<String, dynamic> reqebody = {
          "mobileNumber": moNumber,
        };
        final Map<String, String> headers = {
          'Content-Type': 'application/json'
        };
        // const uri = 'http://192.168.1.22:3000/users/login';
        const uri = '$baseUrl$loginUrl';
        var response = await http.post(Uri.parse(uri),
            headers: headers, body: jsonEncode(reqebody));

        try {
          if (response.statusCode == 200) {
            LogInModel users = logInModelFromJson(response.body);
            var sharedPreferences = await SharedPreferences.getInstance();
            SharedPreferencesHelper sharedPreferencesHelper =
                SharedPreferencesHelper(sharedPreferences);
            sharedPreferencesHelper.putBool(Preferences.userLogin, true);
            await sharedPreferencesHelper.putString(
                Preferences.userFullDetails, jsonEncode(users));

            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => AppbarBottomBarScreen(
                    logInModel: users,
                  ),
                ),
                (route) => false);
          } else {
            commonSnackBar(context: context, msg: "catch ${response.body}");
            // LogInModel users =  LogInModel();
          }
        } catch (e) {
          commonSnackBar(context: context, msg: "catch ${e.toString()}");
          // return LogInModel();
        }
      });
    } catch (e) {
      print('error');
    }
  }
}
