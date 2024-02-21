import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rudra_it_hub/view/screens/signup_view.dart';

import '../utils/constants.dart';

class DialogUtils {

  DialogUtils.internal();


  static void showCustomDialog(BuildContext context,String title ,  String msg,) {

    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(title,style:const TextStyle(fontSize: 25)),
            content: Text(msg , style:const TextStyle(fontSize: 18),),/* Here add your custom widget  */
            actions: <Widget>[

              Center(
                child:  InkWell(
              onTap: (){

                Navigator.pop(context);
                // Get.to(SignUpScreen());
                // Navigator.pop(context);

              },

                  child: Container(
                    decoration: BoxDecoration(
                        color:
                        purpleColor.withOpacity(0.2),
                        borderRadius:
                        const BorderRadius.all(
                            Radius.circular(15))),
                    child:const Padding(
                      padding:  EdgeInsets.only(
                          left: 7,
                          right: 7,
                          top: 2,
                          bottom: 3),
                      child: Text(
                        'OK',
                        style: TextStyle(
                            fontSize:
                            12,
                            fontWeight: FontWeight.bold,
                            color: purpleColor),
                      ),
                    ),
                  ),
                ),
              )
            ],
          );
        });
  }
 }