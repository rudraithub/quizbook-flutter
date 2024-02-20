import 'package:flutter/material.dart';
import 'package:rudra_it_hub/splash_screen.dart';
import 'package:rudra_it_hub/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
class CommonAppBarScreen extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final bool centerTitle;
  final bool isBackArrow;
  final bool automaticallyImplyLeading;
  final bool isProfile ;

  const CommonAppBarScreen({super.key,
    required this.title,
    required this.backgroundColor,
    this.centerTitle = true,
    this.isBackArrow = true,
    this.automaticallyImplyLeading = false,
    this.isProfile = false,
  });

  @override
  Widget build(BuildContext context) {
    Future<void> clearSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print('Logout Call ');
  await prefs.clear(); // Clear all SharedPreferences data
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SplashScreen(),), (route) => false);
}
    return AppBar(
      leading: isBackArrow ?const BackButton(color: blackColor) :const SizedBox(),
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor: backgroundColor,
      title: Text(
        title,
        style:const TextStyle(
          color: blackColor, 
        ),
      ),
      centerTitle: centerTitle,
      actions: [
        PopupMenuButton(
          color: Colors.white,
          itemBuilder: (context) {
            if (isProfile) {
              return <PopupMenuEntry<String>>[
                  PopupMenuItem(
                textStyle: TextStyle(color: Colors.tealAccent),
                child: InkWell(onTap: ()async{
await clearSharedPreferences();
                },child: Text('Log Out',style: TextStyle(color: blackColor),)),
              ),
            
            ];
            }
            return [];
          },
        )
      ],
    );
  }
}
