import 'package:flutter/material.dart';
import 'package:rudra_it_hub/model/study_model.dart';

class StudyItem extends StatelessWidget {
  const StudyItem({super.key, required this.model});
  final StudyModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5, right: 5, top: 20),
      child: Container(
        height: MediaQuery.of(context).size.height / 4.8,
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
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Container(
                      decoration: const BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.all(Radius.circular(2))),
                      child: const Padding(
                          padding: EdgeInsets.only(left: 5, right: 5),
                          child: Text(
                            'New',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                const Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: model.sub.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 8, left: 2),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: (){
                                print("${model.sub[index].subName} Std ${model.std}" );
                                Navigator.of(context).push(MaterialPageRoute(builder: (context) => ChapterScreen(),));
                              },
                              child: ClipRRect(
                                
                                borderRadius: BorderRadius.circular(50),
                                  
                                  // borderRadius: BorderRadius.circular(90),
                                  child: Image.network(
                                    // Add dummy Url because the api url not working
                              
                                    'https://picsum.photos/200/300',
                                    height: MediaQuery.of(context).size.width / 5,
                                  width: MediaQuery.of(context).size.width / 5,
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                                width: MediaQuery.of(context).size.width / 5,
                                child: Text(
                                  model.sub[index].subName,
                                  textAlign: TextAlign.center,
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
