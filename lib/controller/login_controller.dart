// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rudra_it_hub/appUrl/all_url.dart';
import 'package:rudra_it_hub/appUrl/http_all_method.dart';

import '../view/screens/otp_view.dart';
import '../view/widgets/common_snack_bar.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  void changeLoading(bool loadingStatus) {
    isLoading.value = loadingStatus;
  }

  Future<void> logInUser(
      BuildContext context, TextEditingController mobileController) async {
    const uri = '$baseUrl$userVerifyUrl';
    try {
      var body = <String, dynamic>{
        "mobileNumber": mobileController.text.toString()
      };
      var header = <String, String>{};
      header['Content-Type'] = 'application/json';

      final response = await postMethod('$baseUrl$userVerifyUrl', body, header);

      if (response.statusCode == 200) {
        final responseString = response;
        // print('Response is success');

        try {
          await FirebaseAuth.instance.verifyPhoneNumber(
              verificationCompleted: (PhoneAuthCredential credential) {},
              verificationFailed: (FirebaseAuthException ex) {
                changeLoading(false);
                commonSnackBar(context: context, msg: ex.toString());
              },
              codeSent: (String verificationId, int? resendToken) {
                changeLoading(false);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OTPScreen(
                        verificationId: verificationId,
                        moNumber: mobileController.text.toString(),
                      ),
                    ));
              },
              codeAutoRetrievalTimeout: (String verificationId) {},
              phoneNumber: '+91${mobileController.text.toString()}');
        } catch (e) {
          changeLoading(false);
          // print("This is Exception $e");
        }
      } else {
        Map<String, dynamic> error = json.decode(response.body);
        // print(error['message'] + ' ssss');
        changeLoading(false);
        if (context.mounted) {
          commonSnackBar(context: context, msg: error['message']);
        }
      }
    } catch (e) {
      if (context.mounted) {
        commonSnackBar(context: context, msg: e.toString());
      }
      changeLoading(false);
      // print('Prashant ' + e.toString());
    }
  }
}
