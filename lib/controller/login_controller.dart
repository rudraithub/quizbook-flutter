

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/screens/otp_view.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  void ChangeLoading(bool loadingStatus) {
    isLoading.value = loadingStatus;
  }

  Future<void> LogInUser(
      BuildContext context, TextEditingController _mobileController) async {

  }
}
