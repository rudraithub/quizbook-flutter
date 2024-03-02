// ignore_for_file: avoid_print, file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:rudra_it_hub/controller/login_controller.dart';
import 'package:rudra_it_hub/utils/constants.dart';
import 'package:rudra_it_hub/view/screens/signup_view.dart';
import 'package:rudra_it_hub/widgets/common_text_field.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController loginController = LoginController();

  final _key = GlobalKey<FormState>();

  // final OTPController _controller = Get.put(OTPController());
  final TextEditingController _mobileController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double mainHight = MediaQuery.of(context).size.height / 2.5;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: mainHight,
            child: Stack(
              children: [
                Positioned(
                    left: 0,
                    right: 0,
                    child: Image.asset(bgImage, fit: BoxFit.fill)),
                Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          imgLogo,
                          height: 80,
                          width: 80,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Image.asset(
                          quizBook,
                          width: 150,
                        )
                      ],
                    )),
              ],
            ),
          ),
          Form(
            key: _key,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CommonTextFormField(
                hint: 'Enter Your Mobile Number',
                controller: _mobileController,
                label: 'Mobile Number',
                errorMessage: 'Please enter valid Number',
                inputType: TextInputType.number,
                formatter: [mobileLengthFormatter, mobileLengthFormatter],
                onTap: () {},
                autoFocus: true,
                isMobileNumber: true,
                // isReadOnly: false,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          InkWell(
            onTap: () {
              // Handle the click event here.
              // print('Text clicked!');
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SignUpScreen(),
              ));
            },
            child: const Text(
              'Create New Account ',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: blackColor,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
          const Spacer(),
          ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.resolveWith((states) {
                  return RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(00),
                      side: const BorderSide(
                        color: Colors.white,
                        width: 1,
                      ));
                }),
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.pressed)) {
                    return purpleColor;
                  }

                  return purpleColor;
                }),
              ),
              onPressed: () async {
                if (_key.currentState!.validate()) {
                  FocusManager.instance.primaryFocus?.unfocus();

                  //  FocusScope.of(context).unfocus();
                  loginController.logInUser(context, _mobileController);
                  loginController.changeLoading(true, context);

                  loginController.isLoading.value
                      ? showDialog(
                          context: context,
                          builder: (context) {
                            return const Center(
                                child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(purpleColor),
                            ));
                          })
                      : null;
                }
              },
              child: const Text(
                'Send OTP',
                style: TextStyle(
                  color: whiteColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              )),
        ],
      ),
      // ),
    );
  }
}
