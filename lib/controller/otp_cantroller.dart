
// ignore_for_file: unused_local_variable, body_might_complete_normally_catch_error

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:rudra_it_hub/appUrl/all_url.dart';
import 'package:rudra_it_hub/http_methods/http_all_method.dart';
import 'package:rudra_it_hub/splash_screen.dart';
import 'package:rudra_it_hub/utils/preference_helper.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/login_model_alpesh.dart';
import '../utils/prefrences.dart';
import '../view/screens/dashboard_view.dart';
import '../widgets/commo_alert_dilog.dart';
import '../widgets/common_snack_bar.dart';

class OTPController extends GetxController {
  Future<void> verifyOTP(
      String verificationId,
      TextEditingController otpController,
      String moNumber,
      BuildContext context) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: otpController.text.toString());

    try {
      FirebaseAuth.instance
          .signInWithCredential(credential)
          .catchError((onError) async {
        // commonSnackBar(context: context, msg: 'Please enter correct otp');
        DialogUtils.showCustomDialog(context, "Wrong OTP", 'Please enter correct otp');

      }).then((value) async {
        LogInModel users = LogInModel();

        final Map<String, dynamic> requestBody = {
          "mobileNumber": moNumber,
        };
        final Map<String, String> headers = {
          'Content-Type': 'application/json'
        };
        // const uri = 'http://192.168.1.22:3000/users/login';
        const uri = '$baseUrl$loginUrl';
        var response = await postMethod(uri, requestBody, headers, context);

        try {
          if (response.statusCode == 200) {
            // print("Prashant" + response.body);
            LogInModel users = logInModelFromJson(response.body);
            userBearerToken = users.token!;
            userData = users;
            var sharedPreferences = await SharedPreferences.getInstance();
            SharedPreferencesHelper sharedPreferencesHelper =
                SharedPreferencesHelper(sharedPreferences);
            sharedPreferencesHelper.putBool(Preferences.userLogin, true);
            sharedPreferencesHelper.putString(Preferences.token, users.token!);
            await sharedPreferencesHelper.putString(
                Preferences.userFullDetails, jsonEncode(users));

            if (context.mounted) {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AppbarBottomBarScreen(
                      logInModel: users,
                    ),
                  ),
                  (route) => false);
            }
          } else {
            // print('Here 3');

            if (context.mounted) {
              // commonSnackBar(context: context, msg: "catch ${response.body}");
              Map<String, dynamic> error = json.decode(response.body);
              DialogUtils.showCustomDialog(context, "Ops!!!", error['message']);


            }
          }
        } catch (e) {
          if (context.mounted) {
            // commonSnackBar(context: context, msg: "catch ${e.toString()}");
            DialogUtils.showCustomDialog(context, "Ops!!!", e.toString());

          }
        }
      });
    } catch (e) {
      if (context.mounted) {
        // commonSnackBar(context: context, msg:"SOmnething Went Wrong");
        DialogUtils.showCustomDialog(context, "Ops!!!", 'Something Went Wrong');



      }
    }
  }
}
