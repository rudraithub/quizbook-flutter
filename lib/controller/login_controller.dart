// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rudra_it_hub/appurl/all_url.dart';
import 'package:rudra_it_hub/appurl/http_all_method.dart';

import '../view/screens/otp_view.dart';
import '../view/widgets/common_snackbar.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  void ChangeLoading(bool loadingStatus) {
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
        print('Response is success');

        try {
          await FirebaseAuth.instance.verifyPhoneNumber(
              verificationCompleted: (PhoneAuthCredential credential) {},
              verificationFailed: (FirebaseAuthException ex) {
                ChangeLoading(false);
                commonSnackBar(context: context, msg: ex.toString());
              },
              codeSent: (String verificationId, int? resendtToken) {
                ChangeLoading(false);
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
          ChangeLoading(false);
          print("This is Exeption $e");
        }
      } else {
        Map<String, dynamic> error = json.decode(response.body);
        // print(error['message'] + ' ssss');
        ChangeLoading(false);
        if (context.mounted) {
          commonSnackBar(context: context, msg: error['message']);
        }
      }
    } catch (e) {
      if (context.mounted) {
        commonSnackBar(context: context, msg: e.toString());
      }
      ChangeLoading(false);
      // print('Prashant ' + e.toString());
    }
  }
}
