import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rudra_it_hub/view/screens/dashboard_view.dart';
import 'package:rudra_it_hub/view/screens/std_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/constans.dart';
import '../../utils/prefrences.dart';
import '../widgets/common_appbar.dart';
import '../widgets/common_button.dart';
import '../widgets/common_textfiled.dart';

class OTPScreen extends StatelessWidget {
  // ignore: unused_field

  final _key = GlobalKey<FormState>();

  final TextEditingController _otpController = TextEditingController();

  final String verificationId;

  OTPScreen({super.key, required this.verificationId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: CommonAppBarScreen(
          title: 'OTP Verification',
          backgroundColor: whiteColor, // Customize the color here
          centerTitle: true,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Please Enter the 6-digit OTP sent to your phone.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              // ignore: sized_box_for_whitespace
              Container(
                width: 200,
                child: Form(
                  key: _key,
                  child: CommonTextFormField(
                    controller: _otpController, // Store text ,_ : private
                    errorMessage: 'Enter Valid OTP',
                    inputType: TextInputType.number,
                    label: 'Enter OTP',
                    formatter: [otpFormatter, mobileNumberFormater],
                    onTap: () {},
                    isOTPField: true,
                    autoFocus: true,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CommonButton(
                  onPress: () async {
                    try {
                      PhoneAuthCredential credential =
                          await PhoneAuthProvider.credential(
                              verificationId: verificationId,
                              smsCode: _otpController.text.toString());
                      FirebaseAuth.instance
                          .signInWithCredential(credential)
                          .then((value) async {
                        print('Success full');

                        var prefrence = await SharedPreferences.getInstance();
                        await prefrence.setBool(Preferences.userLogin, true);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AppbarBottomBarScreen(),
                            ),
                            (route) => false);
                      });
                    } catch (e) {
                      print(e.toString());
                    }
                  },
                  title: "Verify OTP")
            ],
          ),
        ),
      ),
    );
  }
}
