// ignore_for_file: prefer_const_literals_to_create_immutables, avoid_print, file_names, must_be_immutable, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:rudra_it_hub/controller/signup_controller.dart';
import 'package:rudra_it_hub/controller/upload_image_controller.dart';
import 'package:rudra_it_hub/splash_screen.dart';
import 'package:rudra_it_hub/utils/utility.dart';
import 'package:rudra_it_hub/widgets/commo_alert_dilog.dart';
import 'package:rudra_it_hub/widgets/common_appbar.dart';
import 'package:rudra_it_hub/utils/constants.dart';
import 'package:rudra_it_hub/widgets/common_button.dart';
import 'package:rudra_it_hub/widgets/common_text_field.dart';

class SignUpScreen extends StatefulWidget {
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

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final InputBorder focusBorder = const UnderlineInputBorder(
      borderSide: BorderSide(color: purpleColor, width: 1));

  final SignUpController signUpCantroller = Get.put(SignUpController());

  final TextEditingController _firstNameController = TextEditingController();

  final TextEditingController _lastNameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _mobileController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  final PhotoController photoController = Get.put(PhotoController());

  final RxString selectedGender = ''.obs;

  final RxString selectedDesignation = ''.obs;

  RxString selectedValue = ''.obs;

  RxBool isValid = false.obs;

  final RxString genderErrorMessage = RxString('');

  // final RxString desErrorMsg = RxString('');
  String? dateErro;
  String? desErrorMsg;
  String? genErrorMsg;
  final FocusNode _focusNode = FocusNode();

  String btnText = 'Next';

  @override
  void dispose() {
    print("dispose call");
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    signUpCantroller.selectedGender.value = 'Select Gender';
    signUpCantroller.selectedBirthDate.value = 'Select Date';
    signUpCantroller.selectedDesignation.value = 'Select Designation';
    genErrorMsg = null;
    desErrorMsg = null;
    photoController.clear();
    signUpCantroller.clear();
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    if (!_focusNode.hasFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  @override
  void initState() {
    print("initcall");
    if (widget.isProfile) {
      // Here  gg
      btnText = "Update";
      _firstNameController.text =
          widget.firstName.isEmpty ? '' : widget.firstName;
      _lastNameController.text = widget.lastName.isEmpty ? '' : widget.lastName;
      // signUpCantroller.lastNameobx.value == ''
      //     ? signUpCantroller.lastNameobx.value = widget.lastName
      //     : null;
      // signUpCantroller.firstNameobx.value == ''
      //     ? signUpCantroller.firstNameobx.value = widget.firstName
      //     : null;
      // signUpCantroller.emailobx.value == ''
      //     ? signUpCantroller.emailobx.value = widget.email
      //     : null;
      signUpCantroller.selectedBirthDate.value == 'Select Date'
          ? signUpCantroller.selectedBirthDate.value = widget.date
          : null;

      _emailController.text = widget.email.isEmpty ? '' : widget.email;
      _mobileController.text = widget.mobileNo.isEmpty ? '' : widget.mobileNo;

      signUpCantroller.selectedDesignation.value == 'Select Designation'
          ? signUpCantroller.selectedDesignation.value = widget.desi
          : null;
      signUpCantroller.selectedGender.value == 'Select Gender'
          ? signUpCantroller.selectedGender.value = widget.gender
          : null;

      signUpCantroller.selectedGender.value == 'Select Gender'
          ? widget.gender
          : null;
      selectedGender.value =
          signUpCantroller.selectedGender.value == 'Select Gender'
              ? widget.gender
              : signUpCantroller.selectedGender.value;

      selectedDesignation.value =
          signUpCantroller.selectedDesignation.value == 'Select Designation'
              ? widget.desi
              : signUpCantroller.selectedDesignation.value;

      signUpCantroller.isValid.value = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isProfile) {
      
    }


    print("Building Screen");

    return Obx(() {
      var profile = photoController.selectedImage.value;
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: CommonAppBarScreen(
            title: widget.isProfile ? 'Update Profile' : "Sign Up",
            backgroundColor: whiteColor,
            centerTitle: true,
            isBackArrow: widget.isBackArrow,
            isProfile: widget.isProfile,
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Form(
              key: SignUpScreen._key,
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
                        child: (photoController.selectedImage.value == null)
                            ? (widget.isProfile
                                ? CircleAvatar(
                                    radius: 50,
                                    // backgroundImage: NetworkImage(
                                    //     userData!.data.userProfile),
                                    child: ClipOval(
                                      child: Image.network(
                                        userData!.data.userProfile,
                                        height: 100,
                                        width: 100,
                                        fit: BoxFit.cover,
                                        loadingBuilder: (BuildContext context,
                                            Widget child,
                                            ImageChunkEvent? loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          } else {
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                        },
                                        errorBuilder: (BuildContext context,
                                            Object exception,
                                            StackTrace? stackTrace) {
                                          return Image.asset(
                                            imgLogo,
                                            height: 100,
                                            width: 100,
                                            fit: BoxFit.cover,
                                          );
                                        },
                                      ),
                                    ),
                                  )
                                : CircleAvatar(
                                    radius: 50,
                                    backgroundColor: Colors.grey,
                                    child: Image.asset(changeProfile),
                                  ))
                            : CircleAvatar(
                                radius: 50,
                                backgroundImage: FileImage(
                                    photoController.selectedImage.value!),
                              )),
                   

                       CommonTextFormField(
                        controller: _firstNameController,
                        label: 'First Name',
                        errorMessage: 'Enter Your First Name',
                        inputType: TextInputType.text,
                        formatter: [],
                        length: 60,
                        onTap: () {},
                      ),
                    
                    // Obx(() {
                    //   signUpCantroller.lastNameobx.value.isEmpty
                    //       ? null
                    //       : _lastNameController.text =
                    //           signUpCantroller.lastNameobx.value;

                    //   return 
                      CommonTextFormField(
                        controller: _lastNameController,
                        label: 'Last Name',
                        errorMessage: 'Enter Your Last Name',
                        inputType: TextInputType.text,
                        formatter: [],
                        length: 60,
                        onTap: () {},
                      ),
                    // }),
                  
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
                      isReadOnly: widget.isProfile,
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
                                decoration: InputDecoration(
                                    labelText: 'Gender',
                                    errorText: genErrorMsg,
                                    focusedBorder: focusBorder,
                                    labelStyle: const TextStyle(
                                        color: greyColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500)),
                                hint: const Text(
                                  "Select Gender",
                                  style:
                                      TextStyle(fontSize: 14, color: greyColor),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    selectedGender(value);
                                    setState(() {
                                      genErrorMsg = null;
                                    });
                                    signUpCantroller.selectedGender.value =
                                        value!;
                                  });
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
                                          style: const TextStyle(
                                              fontSize: 15, color: blackColor),
                                        ),
                                      ),
                                    )
                                    .toList(),
                              ),
                            ),
                          ),
                        ),
                        // Obx(() {
                        //   if (genderErrorMessage.value.isNotEmpty) {
                        //     return Padding(
                        //       padding: const EdgeInsets.only(top: 0),
                        //       child: Text(
                        //         genderErrorMessage.value,
                        //         style: const TextStyle(
                        //             color: redColor, fontSize: 13),
                        //       ),
                        //     );
                        //   } else {
                        //     return const SizedBox.shrink();
                        //   }
                        // }),
                        const SizedBox(
                          width: 5,
                        ),
                        Flexible(
                          child: Center(
                            child: SizedBox(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.00475),
                                child: InkWell(
                                  onTap: () {
                                    // if (widget.isProfile) {
                                    //   return;
                                    // }
                                    Utility.showDatePickerDialog()
                                        .then((pickedDate) {
                                      if (pickedDate != null) {
                                        signUpCantroller.changeBirthDate(
                                            "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year.toString()}");
                                        selectedDate = pickedDate;
                                        setState(() {
                                          dateErro = null;
                                        });
                                      }
                                    });
                                  },
                                  child: Obx(
                                    () => InputDecorator(
                                      decoration: InputDecoration(
                                          labelText: 'BirthDate',
                                          errorText: dateErro,
                                          labelStyle: TextStyle(
                                              color: greyColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500)),
                                      child: signUpCantroller
                                                  .selectedBirthDate.value ==
                                              "Select Date"
                                          ? Text(
                                              signUpCantroller
                                                  .selectedBirthDate.value,
                                              maxLines: 1,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: greyColor,
                                                  fontWeight: FontWeight.w500,
                                                  overflow: TextOverflow.clip),
                                            )
                                          : Text(
                                              signUpCantroller
                                                  .selectedBirthDate.value,
                                              maxLines: 1,
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: blackColor,
                                                  fontWeight: FontWeight.w500,
                                                  overflow: TextOverflow.clip),
                                            ),
                                    ),
                                  ),
                                ),
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
                          decoration: InputDecoration(
                              labelText: 'Select Designation',
                              errorText: desErrorMsg,
                              focusedBorder: focusBorder,
                              labelStyle: const TextStyle(
                                  color: greyColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500)),
                          onChanged: (value) {
                            setState(() {
                              desErrorMsg = null;
                              selectedDesignation(value);

                              signUpCantroller.selectedDesignation.value =
                                  value!;
                              selectedDesignation(value);
                              print("this is set State");
                            });
                          },
                          // validator: (value) {
                          //   if (value == null || value.isEmpty && desErrorMsg != null) {
                          //     return "Please Select ";
                          //   }
                          //   return null;
                          // },
                          items: ["Student", "Teacher", "Admin"]
                              .map<DropdownMenuItem<String>>(
                                (String value) => DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: const TextStyle(
                                        fontSize: 15, color: blackColor),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                    // SizedBox(
                    //   child: desErrorMsg != null
                    //       ? Padding(
                    //           padding: const EdgeInsets.only(top: 8.0),
                    //           child: Text(
                    //             desErrorMsg!,
                    //             style: const TextStyle(
                    //                 color: redColor, fontSize: 13),
                    //           ),
                    //         )
                    //       : const SizedBox.shrink(),
                    // if (desErrorMsg != null) {
                    //   return Padding(
                    //     padding: const EdgeInsets.only(top: 8.0),
                    //     child: Text(
                    //       desErrorMsg!,
                    //       style:
                    //           const TextStyle(color: redColor, fontSize: 13),
                    //     ),
                    //   );
                    // } else {
                    //   return const SizedBox.shrink();
                    // }
                    // ),
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: CommonButton(
            onPress: () async {
              int professionId = 1;
              if (selectedDesignation.value == 'Student') {
                professionId = 1;
              } else if (selectedDesignation.value == 'Teacher') {
                professionId = 2;
              } else {
                professionId = 3;
              }
              int genderId = 1;
              if (selectedGender.value == 'Male') {
                genderId = 1;
              } else if (selectedGender.value == 'Female') {
                genderId = 2;
              } else {
                genderId = 3;
              }
              if (signUpCantroller.selectedBirthDate.value == 'Select Date') {
                setState(() {
                  dateErro = "Please Select Date";
                });
              }
              if (signUpCantroller.selectedDesignation.value ==
                  'Select Designation') {
                setState(() {
                  desErrorMsg = "Please Select Desi";
                });
              }
              if (signUpCantroller.selectedGender.value == 'Select Gender') {
                setState(() {
                  genErrorMsg = "Please Select Gender";
                });
              }

              if (SignUpScreen._key.currentState!.validate() &&
                  signUpCantroller.selectedDesignation.value !=
                      'Select Designation' &&
                  signUpCantroller.selectedBirthDate.value != 'Select Date' &&
                  signUpCantroller.selectedGender.value != 'Select Gender') {
                print('else calll');
                if (widget.isProfile) {
                  FocusScope.of(context).unfocus();
                  FocusManager.instance.primaryFocus?.unfocus();
                  signUpCantroller.updateUser(
                      _firstNameController.text,
                      _lastNameController.text,
                      _emailController.text,
                      genderId,
                      professionId,
                      selectedDate,
                      photoController.selectedImage.value,
                      context);
                } else {
                  if (photoController.selectedImage.value == null) {
                    DialogUtils.showCustomDialog(
                        context, "Empty Filed", "Please Select Profile Photo");
                  }

                  signUpCantroller.signUp(
                      _firstNameController.text,
                      _lastNameController.text,
                      _emailController.text,
                      genderId,
                      selectedDate,
                      _mobileController.text,
                      professionId,
                      photoController.selectedImage.value!,
                      context);
                }
              }
            },
            title: btnText),
      );
    });
  }
}
