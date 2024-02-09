import 'package:flutter/material.dart';

class DialogUtils {
  // static DialogUtils _instance = new DialogUtils.internal();

  DialogUtils.internal();

  // factory DialogUtils() => _instance;

  static void showCustomDialog(BuildContext context,String msg,
      {required String title, 
      String okBtnText = "Ok",
      String cancelBtnText = "Cancel",
      required Function okBtnFunction}) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text('Opps!!!'),
            content: Text(msg),/* Here add your custom widget  */
            actions: <Widget>[
              // FlatButton(
              //   child: Text(okBtnText),
              //   onPressed: okBtnFunction,
              // ),
              Center(
                child: TextButton(
                    child: Text("Ok"),
                    onPressed: () => Navigator.pop(context)),
              )
            ],
          );
        });
  }
 }