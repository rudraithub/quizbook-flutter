import 'package:flutter/material.dart';
import 'package:rudra_it_hub/model/study_model.dart';
import 'package:rudra_it_hub/utils/constans.dart';
import 'package:rudra_it_hub/view/screens/chapter_screen.dart';

class StudyItem extends StatelessWidget {
  const StudyItem({super.key, required this.model});
  final StudyModel model;

  @override
  Widget build(BuildContext context) {
    double screenHeight = getScreenHeight(context);
    double screenWidth = getScreenWidth(context);

    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 20),
      child: Container(
        height: screenHeight / 3.85,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            border: Border.all(color: Colors.black12),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade300,
                  spreadRadius: 2,
                  blurRadius: 3,
                  offset: const Offset(0, 3))
            ]),
        child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ધોરણ : ${model.std}",
                      style: TextStyle(
                          fontSize: screenHeight * 0.022,
                          fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Container(
                      decoration: const BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.all(Radius.circular(2))),
                      child: Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: Text(
                            'New',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: screenHeight * 0.02,
                                color: Colors.white),
                          )),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.009,
                ),
                Divider(
                  thickness: 1,
                  height: screenHeight * 0.009,
                  color: Colors.grey,
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: model.sub.length,
                    itemBuilder: (context, index) {

                      return Padding(
                        padding: const EdgeInsets.only(top: 0, left: 2),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                // print(
                                //     "${model.sub[index].subName} Std ${model.std}");
                                print("this is std id  " + model.stdId.toString() );
                                print("this is sub id  "+ model.sub[index].subId.toString() );

                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => ChapterScreen(
                                      stdId: model.stdId,
                                      subId: model.sub[index].subId,
                                      std: model.std,
                                      subject: model.sub[index].subName,)));
                              },
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),

                                  // borderRadius: BorderRadius.circular(90),
                                  child: Image.network(
                                    // Add dummy Url because the api url not working

                                    model.sub[index].imageUrl,

                                    height: screenHeight * 0.12,
                                    width: screenHeight * 0.12,
                                    fit: BoxFit.fitWidth,
                                  )),
                            ),
                            SizedBox(
                              height: screenHeight * 0.009,
                            ),
                            SizedBox(
                                // width: screenWidth / 5,
                                child: Text(
                                  model.sub[index].subName,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: screenHeight * 0.02,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ))
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            )),
      ),
    );
  }
}
