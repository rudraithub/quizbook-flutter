import 'package:flutter/material.dart';
import 'package:rudra_it_hub/utils/constans.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    double screenHeight = getScreenHeight(context);
    double screenWidth = getScreenWidth(context);
    return   Scaffold(
      body:  Padding(
        padding: const EdgeInsets.only(top: 0, left: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                // print(
                //     "${model.sub[index].subName} Std ${model.std}");
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) => ChapterScreen(
                //       std: model.std,
                //       subject: model.sub[index].subName,
                //     )));
              },
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),

                  // borderRadius: BorderRadius.circular(90),
                  child: Image.network(
                    // Add dummy Url because the api url not working

                    'https://picsum.photos/200/300',
                    height: screenHeight * 0.12,
                    width: screenHeight * 0.12,
                    fit: BoxFit.cover,
                  )),
            ),
            SizedBox(
              height: screenHeight * 0.009,
            ),
            SizedBox(
              // width: screenWidth / 5,
                child: Text(
                  'model.sub[index].subName',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenHeight * 0.02,
                  ),
                  overflow: TextOverflow.ellipsis,
                ))
          ],
        ),
      ),
    );
  }
}

