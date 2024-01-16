import 'package:flutter/material.dart';
import 'package:rudra_it_hub/utils/constans.dart';
class CommonAppBarScreen extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final bool centerTitle;
  final bool isBackArrow;
  final bool automaticallyImplyLeading;

  const CommonAppBarScreen({super.key,
    required this.title,
    required this.backgroundColor,
    this.centerTitle = true,
    this.isBackArrow = true,
    this.automaticallyImplyLeading = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: isBackArrow ?const BackButton(color: blackColor) :const SizedBox(),
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor: backgroundColor,
      title: Text(
        title,
        style:const TextStyle(
          color: blackColor, // Customize the text color if needed
        ),
      ),
      centerTitle: centerTitle,
      actions: [
        PopupMenuButton(
          color: Colors.black,
          itemBuilder: (context) {
            return <PopupMenuEntry<String>>[
              const    PopupMenuItem(
                textStyle: TextStyle(color: Colors.tealAccent),
                child: Text('Item 1'),
              ),
              const  PopupMenuItem(
                textStyle: TextStyle(backgroundColor: Colors.amber),
                child: Text('Item 2'),
              ),
            ];
          },
        )
      ],
    );
  }
}
