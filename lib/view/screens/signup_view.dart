// ignore_for_file: prefer_const_literals_to_create_immutables, avoid_print, file_names, must_be_immutable

// import 'dart:convert';
// import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rudra_it_hub/controller/signup_controller.dart';
import 'package:rudra_it_hub/controller/upload_image_controller.dart';
import 'package:rudra_it_hub/utils/utility.dart';
import 'package:rudra_it_hub/widgets/common_appbar.dart';
import 'package:rudra_it_hub/utils/constants.dart';
import 'package:rudra_it_hub/widgets/common_button.dart';
import 'package:rudra_it_hub/widgets/common_snack_bar.dart';
import 'package:rudra_it_hub/widgets/common_text_field.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({
    super.key,
    this.isBackArrow = false,
    this.date = '',
    this.desi = '',
    this.gender = '',
    this.mobileNo = "",
    this.isProfile = false,
    this.firstName = '',
    this.lastName = '',
    this.email = '',
  });

  // final _key = GlobalKey<FormState>();
  static final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final bool isBackArrow;
  final bool isProfile;
  final String firstName;
  final String lastName;
  final String email;
  final String mobileNo;
  final String gender;
  final String date;
  final String desi;
  // final DateTime dateTime;

  // final String /;

  final SignUpController signUpCantroller = Get.put(SignUpController());

  final TextEditingController _firstNameController = TextEditingController();

  final TextEditingController _lastNameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _mobileController = TextEditingController();
  // final TextEditingController _pickDAte = TextEditingController();
  DateTime selectedDate = DateTime.now();
  final PhotoController photoController = Get.put(PhotoController());

  final RxString selectedGender = ''.obs;

  final RxString selectedDesignation = ''.obs;

  RxString selectedValue = ''.obs; // Observable string for the selected value
  RxBool isValid = false.obs;

  final RxString genderErrorMessage = RxString('');

  final RxString desErrorMsg = RxString('');
  String btnText = 'Next';

  @override
  Widget build(BuildContext context) {
    if (isProfile) {
      // Here
      btnText = "Update";
      _firstNameController.text = firstName.isEmpty ? '' : firstName;
      _lastNameController.text = lastName.isEmpty ? '' : lastName;
      _emailController.text = email.isEmpty ? '' : email;
      _mobileController.text = mobileNo.isEmpty ? '' : mobileNo;

      selectedGender.value = gender.isEmpty ? '' : gender;
      selectedDesignation.value = desi.isEmpty ? '' : desi;
      signUpCantroller.changeBirthDate(date);
      signUpCantroller.isValid.value = true;
      
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: CommonAppBarScreen(
          title: 'Update Profile',
          backgroundColor: whiteColor, // Customize the color here
          centerTitle: true,
          isBackArrow: isBackArrow,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Form(
              key: _key,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 18,
                    ),
                    GestureDetector(
                      onTap: () {
                        photoController.pickImage(context);
                      },
                      child: Obx(() {
                        return (photoController.selectedImage.value == null)
                            ? CircleAvatar(
                                radius: 50,
                                backgroundColor: Colors.grey,
                                child: Image.asset(changeProfile),
                              )
                            : CircleAvatar(
                                radius: 50,
                                backgroundImage: FileImage(
                                    photoController.selectedImage.value!),
                              );
                      }),
                    ),
                    CommonTextFormField(
                      controller: _firstNameController,
                      label: 'First Name',
                      errorMessage: 'Enter Your First Name',
                      inputType: TextInputType.text,
                      formatter: [],
                      length: 60,
                      onTap: () {},
                    ),
                    CommonTextFormField(
                      controller: _lastNameController,
                      label: 'Last Name',
                      errorMessage: 'Enter Your Last Name',
                      inputType: TextInputType.text,
                      formatter: [],
                      length: 60,
                      onTap: () {},
                    ),
                    CommonTextFormField(
                      controller: _emailController,
                      label: 'Email ID',
                      errorMessage: 'Please enter valid Email Id',
                      inputType: TextInputType.text,
                      formatter: [],
                      length: 60,
                      onTap: () {},
                      isEmailField: true,
                    ),
                    CommonTextFormField(
                      controller: _mobileController,
                      label: 'Mobile Number',
                      errorMessage: 'Please enter valid Number',
                      inputType: TextInputType.number,
                      formatter: [mobileLengthFormatter, mobileNumberFormat],
                      length: 10,
                      onTap: () {},
                      isMobileNumber: true,
                      isReadOnly: isProfile,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: SizedBox(
                            width: (MediaQuery.of(context).size.width / 2 - 10),
                            child: Obx(
                              () => DropdownButtonFormField<String>(
                                value: selectedGender.value.isEmpty
                                    ? null
                                    : selectedGender.value,
                                decoration: const InputDecoration(
                                    labelText: 'Gender',
                                    labelStyle: TextStyle(
                                        color: greyColor, fontSize: 14)
                                    // Add other styling properties here if needed
                                    ),
                                hint: const Text(
                                  "Select gender",
                                  style: TextStyle(fontSize: 14),
                                ),
                                onChanged: (value) {
                                  selectedGender(value);
                                  genderErrorMessage('');
                                  signUpCantroller.selectedGender.value = value!;
                                  signUpCantroller.onItemSelected(value!);
                                  signUpCantroller.isValid.value == true;
                                },
                                // Call the method from the controller
                                validator: (value) {
                                  return signUpCantroller.isValid.value
                                      ? null
                                      : 'Please select Gender';
                                },
                                // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return "Please select a gender";
                                //   }
                                //   return null;
                                // },
                                items: ['Male', 'Female', 'Others']
                                    .map<DropdownMenuItem<String>>(
                                      (String value) =>
                                          DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: const TextStyle(fontSize: 15),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),
                        ),
                        Obx(() {
                          if (genderErrorMessage.value.isNotEmpty) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: Text(
                                genderErrorMessage.value,
                                style: const TextStyle(
                                    color: redColor, fontSize: 13),
                              ),
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        }),
                        const SizedBox(
                          width: 5,
                        ),
                        Flexible(
                          child: SizedBox(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child:
                                  //  CommonTextFormField(
                                  //   controller: _pickDAte,
                                  //   errorMessage: "Please Select The Date ",
                                  //   onTap: Utility.showDatePickerDialog(),
                                  // )
                                  InkWell(
                                onTap: () {
                                  Utility.showDatePickerDialog()
                                      .then((pickedDate) {
                                    if (pickedDate != null) {
                                      signUpCantroller.changeBirthDate(
                                          "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year.toString()}");
                                      selectedDate = pickedDate;
                                    }
                                  });
                                },
                                child: InputDecorator(
                                    decoration: const InputDecoration(
                                        labelText: 'BirthDate',
                                        labelStyle: TextStyle(
                                            color: greyColor, fontSize: 14)),
                                    child: Obx(() => Text(
                                          signUpCantroller
                                              .selectedBirthDate.value,
                                          maxLines: 1,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500,
                                              overflow: TextOverflow.clip),
                                        ))),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1,
                      child: Obx(
                        () => DropdownButtonFormField<String>(
                          padding: EdgeInsets.zero,
                          value: selectedDesignation.value.isEmpty
                              ? null
                              : selectedDesignation.value,
                          decoration: const InputDecoration(
                              labelText: 'Select Designation',
                              labelStyle:
                                  TextStyle(color: greyColor, fontSize: 14)
                              // Add other styling properties here if needed
                              ),
                          onChanged: (value) {
                            selectedDesignation(value);
                            desErrorMsg('');
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Select ";
                            }
                            return null;
                          },
                          items: ["student", "teacher", "admin"]
                              .map<DropdownMenuItem<String>>(
                                (String value) => DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                    Obx(() {
                      if (desErrorMsg.value.isNotEmpty) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            desErrorMsg.value,
                            style:
                                const TextStyle(color: redColor, fontSize: 13),
                          ),
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: CommonButton(
          onPress: () async {
            int professionId = 1;
            if (selectedDesignation.value == 'student') {
              professionId = 1;
            } else if (selectedDesignation.value == 'teacher') {
              professionId == 2;
            } else {
              professionId = 3;
            }
            int genderId = 1;
            if (selectedDesignation.value == 'male') {
              genderId = 1;
            } else if (selectedDesignation.value == 'female') {
              genderId == 2;
            } else {
              genderId = 3;
            }
            if (_key.currentState!.validate()) {
              //  _controller.verifyOtp();
              if (signUpCantroller.selectedBirthDate.value == 'Select Date') {
                commonSnackBar(context: context, msg: "Please select date");
              } else {
                // print('else calll');
                if (isProfile) {
                  signUpCantroller.updateUser(_firstNameController.text,
                      _lastNameController.text, context);
                } else {
                  signUpCantroller.signUp(
                      _firstNameController.text,
                      _lastNameController.text,
                      _emailController.text,
                      genderId,
                      selectedDate,
                      _mobileController.text,
                      professionId,
                      context);
                }
              }
            }
          },
          title: btnText),
    );
  }
}
