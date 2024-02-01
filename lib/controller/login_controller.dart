// ignore_for_file: unused_local_variable

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rudra_it_hub/appurl/all_url.dart';

import '../view/screens/otp_view.dart';
import '../view/widgets/common_snackbar.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  void ChangeLoading(bool loadingStatus) {
    isLoading.value = loadingStatus;
  }

  Future<void> LogInUser(
      BuildContext context, TextEditingController _mobileController) async {
    const uri = '$baseUrl$userVerifyUrl';
    try {
      var headers = <String, String>{};
      headers['Content-Type'] = 'application/json';

      var body = <String, dynamic>{
        "mobileNumber": _mobileController.text.toString()
      };

      var encodedBody = jsonEncode(body);

      var response =
          await http.post(Uri.parse(uri), headers: headers, body: encodedBody);

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
                        moNumber: _mobileController.text.toString(),
                      ),
                    ));
              },
              codeAutoRetrievalTimeout: (String verificationId) {},
              phoneNumber: '+91${_mobileController.text.toString()}');
        } catch (e) {
          ChangeLoading(false);
          print("This is Exeption $e");
        }
      } else {
        Map<String, dynamic> error = json.decode(response.body);
        print(error['message'] + ' ssss');
        ChangeLoading(false);

        commonSnackBar(context: context, msg: error['message']);
      }
    } catch (e) {
      commonSnackBar(context: context, msg: e.toString());
      ChangeLoading(false);
      print('Prashant ' + e.toString());
    }
  }
}
