import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rudra_it_hub/services/remote_services.dart';
import '../view/screens/otp_view.dart';
//

class LoginController extends GetxController {
  var isLoading = false.obs;
  void ChangeLoading(bool loadingStatus) {
    isLoading.value = loadingStatus;
  }

  Future<void> LogInUser(
      BuildContext context, TextEditingController _mobileController) async {
    bool ab = await RemoteServices.getUserAvailable(
        _mobileController.text.toString(), context);
    if (ab) {
      try {
        await FirebaseAuth.instance.verifyPhoneNumber(
            verificationCompleted: (PhoneAuthCredential credential) {},
            verificationFailed: (FirebaseAuthException ex) {
              ChangeLoading(false);
            },
            codeSent: (String verificationId, int? resendtToken) {
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
            phoneNumber: '+919484779764');
        // phoneNumber: '+91${_mobileController.text.toString()}');
      } catch (e) {
        ChangeLoading(false);
        print("This is Exeption $e");
      }
    } else {
      print("ab is false");
      ChangeLoading(false);
    }
  }
}

//