import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:rudra_it_hub/model/user.dart';
import 'package:rudra_it_hub/services/remote_services.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../utils/prefrences.dart';
import '../view/screens/dashboard_view.dart';

class OTPController extends GetxController{
  Future<void> verifyOTP(String verificationId , TextEditingController _otpController , String  moNumber, BuildContext context)async{
    PhoneAuthCredential credential =
    await PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: _otpController.text.toString());

    try {
      FirebaseAuth.instance
          .signInWithCredential(credential)
          .catchError((onError) async {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Please enter currect otp",
                style: TextStyle(fontSize: 15)),
            duration: Duration(seconds: 2),
          ),
        );
      }).then((value) async {
        var prefrence = await SharedPreferences.getInstance();
        await prefrence.setBool(Preferences.userLogin, true);

        User2 users =await RemoteServices.fatchUserDetails(moNumber);

        prefrence.setString(Preferences.id, users.data.id);
        prefrence.setInt(Preferences.userID, users.data.userId);

        print(users.data.id); print(users.data.userId.toString());

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => AppbarBottomBarScreen(),
            ),
                (route) => false);
      });
    } catch (e) {
      print('error');
    }
  }
}