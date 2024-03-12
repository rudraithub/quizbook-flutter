import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:rudra_it_hub/splash_screen.dart';
import 'package:rudra_it_hub/utils/constants.dart';
import 'package:rudra_it_hub/view/screens/login_view.dart';
import 'package:rudra_it_hub/widgets/commo_alert_dilog.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> logOut(BuildContext context, String? message) async {
  void myOptionalFunction()async {
    Get.offAll(LoginScreen());
    await clearSharedPreferences();
  }

  DialogUtils.showCustomDialog(context, "Log Out",
      message == null ? "Your account login in another divice" : message,
      optionalFunction: myOptionalFunction);
  print("LogOut Call");
  
}

Future<void> clearSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print('Logout Call ');
  await prefs.clear();
}

class CommonAppBarScreen extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final bool centerTitle;
  final bool isBackArrow;
  final bool automaticallyImplyLeading;
  final bool isProfile;
  final bool needPopUpButton;

  const CommonAppBarScreen({
    super.key,
    required this.title,
    this.needPopUpButton =true,
    required this.backgroundColor,
    this.centerTitle = true,
    this.isBackArrow = true,
    this.automaticallyImplyLeading = false,
    this.isProfile = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading:
          isBackArrow ? const BackButton(color: blackColor) : const SizedBox(),
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor: backgroundColor,
      title: Text(
        title,
        style: const TextStyle(
          color: blackColor,
        ),
      ),
      centerTitle: centerTitle,
      actions: [
      needPopUpButton ? InkWell(
          onTap: () {
            print("hi");
          },
          child: PopupMenuButton(
            color: Colors.white,
            itemBuilder: (context) {
              if (isProfile) {
                return <PopupMenuEntry<String>>[
                  PopupMenuItem(
                    textStyle: TextStyle(color: Colors.tealAccent),
                    child: GestureDetector(
                      onTap: () async {
                        logOut(context, "You want to logout ? ");
                      },
                      child: Container(
                        
                        padding: EdgeInsets.all(12),
                        child: Text(
                          'Log Out',
                          style: TextStyle(color: blackColor,fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ];
              }
              return [];
            },
            onSelected: (value) => print("Prashat"),
          ),
        ) : SizedBox.shrink()
      ] ,
    );
  }
}
