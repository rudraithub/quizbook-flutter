// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:rudra_it_hub/utils/constans.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    int noOfCurrectAnswer = 0;
    int noOfTotalQuestion = 7;
    double percent = noOfCurrectAnswer / noOfTotalQuestion;
    double screenHeight = getScreenHeight(context);
    double screenWidth = getScreenWidth(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "My Activity",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 11, top: 5),
              child: Text('Clear All'),
            )
          ],
          centerTitle: true,
          backgroundColor: Colors.white,
          elevation: 2,
          shadowColor: Colors.grey,
        ),
        body: ListView.builder(
          itemCount: 8,
          itemBuilder: (context, index) {
            return Padding(
                padding: EdgeInsets.only(
                    left: 10, right: 10, top: screenHeight * 0.025),
                child: Container(
                    height: screenHeight * 0.18,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(4)),
                        border: Border.all(color: Colors.black12),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade300,
                              spreadRadius: 2,
                              blurRadius: 3,
                              offset: const Offset(0, 3))
                        ]),
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'STD : ${index + 1}',
                                style: TextStyle(
                                  fontSize: screenHeight * 0.022,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: screenHeight * 0.009,
                              ),
                              Text(
                                'Math - Chapter ${index + 1}. Basic Methamatics',
                                style: TextStyle(
                                  fontSize: screenHeight * 0.02,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                height: screenHeight * 0.009,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                      height: screenHeight * 0.02,
                                      width: screenHeight * 0.02,
                                      child: Image.asset(
                                          'assets/images/time_icon.png')),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Center(
                                    child: Text(
                                      '3 minutes ago',
                                      style: TextStyle(
                                        fontSize: screenHeight * 0.017,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: screenHeight * 0.01,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: purpleColor.withOpacity(0.2),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 7, right: 7, top: 2, bottom: 3),
                                  child: Text(
                                    'Done',
                                    style: TextStyle(
                                        fontSize: screenHeight * 0.017,
                                        fontWeight: FontWeight.bold,
                                        color: purpleColor),
                                  ),
                                ),
                              ),
                            ],
                          )),
                          CircularPercentIndicator(
                            radius: screenHeight * 0.045,
                            lineWidth: 5.0,
                            percent: index / 7,
                            center: Text(
                              "${((index / 7) * 100).toStringAsFixed(0)}%",
                              style: TextStyle(
                                fontSize: screenHeight * 0.02,
                              ),
                            ),
                            progressColor: purpleColor,
                          )
                        ],
                      ),
                    )));
          },
        ));
  }
}
