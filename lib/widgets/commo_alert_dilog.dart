
import 'package:flutter/material.dart';

class CommonAlertDialog extends StatelessWidget {
  final String message;

  const CommonAlertDialog({super.key, required this.message});

  void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return this;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Alert'),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the alert dialog
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}