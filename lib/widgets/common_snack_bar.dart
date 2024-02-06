import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> commonSnackBar({
  required BuildContext context,
  required String msg,
  double? fontSize,
  int? durationSeconds,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg, style: TextStyle(fontSize: fontSize ?? 15)),
      duration: Duration(seconds: durationSeconds ?? 2),
    ),
  );
}

//
// showAlertDialog(BuildContext context) {
//
//   // set up the button
//   Widget okButton = TextButton(
//     child: Text("OK"),
//     onPressed: () { },
//   );
//
//   // set up the AlertDialog
//   AlertDialog alert = AlertDialog(
//     title: Text("My title"),
//     content: Text("This is my message."),
//     actions: [
//       okButton,
//     ],
//   );

