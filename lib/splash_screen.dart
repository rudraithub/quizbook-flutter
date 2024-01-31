import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rudra_it_hub/utils/constans.dart';
import 'package:rudra_it_hub/utils/prefrence_helper.dart';
import 'package:rudra_it_hub/utils/prefrences.dart';
import 'package:rudra_it_hub/view/screens/dashboard_view.dart';
import 'package:rudra_it_hub/view/screens/login_view.dart';
import 'package:rudra_it_hub/view/screens/signup_view.dart';
import 'package:rudra_it_hub/view/screens/std_screen.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'model/login_model_alpesh.dart';

String? userBearerToken;
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // SharedPreferences preferences = SharedPreferences.getInstance();
  @override
  void initState() {
    SharedPreferences.getInstance().then((prefs) {
      Future.delayed(const Duration(seconds: 2), () {
        bool loginStatus = SharedPreferencesHelper(prefs).getBool(Preferences.userLogin);


        if (loginStatus == true) {

          LogInModel userData = logInModelFromJson(SharedPreferencesHelper(prefs).getString(Preferences.userFullDetails));
          userBearerToken = userData.token;
          print("userBearerToken $userBearerToken");
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => AppbarBottomBarScreen(logInModel: userData),));
        } else {
          // Get.to(LoginScreen());
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LoginScreen(),));
        }

      });
      // Replace HomeScreen with your main content screen
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(

      body: Center(
        child:Image(image: AssetImage(imgLogo))
      ),
    );
  }
}
