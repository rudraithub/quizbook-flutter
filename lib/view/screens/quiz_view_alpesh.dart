import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rudra_it_hub/controller/quiz_controller.dart';
import 'package:rudra_it_hub/widgets/answer_card.dart';
import 'package:rudra_it_hub/widgets/common_button.dart';
import '../../utils/constants.dart';
import '../../widgets/commo_alert_dilog.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({
    super.key,
    required this.stdId,
    required this.subId,
    required this.chapterId,
    required this.titleName,
  });
  final int stdId;
  final int subId;
  final int chapterId;
  final String titleName;
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int? selectedAnswerIndex;
  int questionIndex = 0;
  // QuestionApiData? apiQuestion;
  bool? isLastQuestion;
  int score = 0;
  List<Map<String, dynamic>> resultData = [];
  QuestionController questionController = QuestionController();

  Future<void> fetchData() async {
     questionController.getQuestionList(
        stdId: widget.stdId,
        subId: widget.subId,
        chapterId: widget.chapterId,
        context: context);
    setState(() {
    });
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void pickAnswer(int value, answerIndex, int queId) {
    Map<String, int> value1 = {"queid": queId, "user_answer": value};
    resultData.add(value1);

    selectedAnswerIndex = value;

    if (selectedAnswerIndex == answerIndex) {
      score++;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
        var screenHeight  = getScreenHeight(context);

    isLastQuestion = (questionIndex + 1) == questionController.apiQuestion.value.data?.length;
    return 
    Obx(() =>
       Scaffold(
        
        body: SafeArea( 
          child:  questionController.isLoading.value ? const Center(child:CircularProgressIndicator(),) : questionController.apiQuestion.value.data!.isEmpty  ? const Center(child: Text("No Data"),) :
          
           SingleChildScrollView(
            child:
           Column(
              children: [
                Container(
                  width: screenWidth,
                  padding: EdgeInsets.fromLTRB(((screenWidth * 5) / 100), 0,
                      ((screenWidth * 5) / 100), ((screenWidth * 5) / 100)),
                  decoration: BoxDecoration(
                      color:
                          purpleColor, // Set the background color of the Container
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular((screenWidth * 5) / 100),
                          bottomRight: Radius.circular((screenWidth * 5) / 100))),
                  child: Column(
                    children: [
                      SizedBox(
                        height:(screenHeight * 0.003),
                      ),
                      Text(
                        widget.titleName,
                        style:  TextStyle(color: Colors.white,fontSize:  (screenHeight * 0.028)),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: (screenHeight * 0.004),
                      ),
                      Text(questionController.apiQuestion.value.data?[questionIndex].question ?? '',
                          style:  TextStyle(color: Colors.white,fontSize: (screenHeight * 0.025)),
                          textAlign: TextAlign.center),
                    ],
                  ),
                ),
                ListView.builder(
                        shrinkWrap: true,
                
                        itemCount:
                            questionController.apiQuestion.value.data?[questionIndex].option?.length ?? 0,
                        itemBuilder: (context, index) {
                         
                          return Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: InkWell(
                                onTap: selectedAnswerIndex == null
                                    ? () => pickAnswer(index, selectedAnswerIndex,
                                        questionController.apiQuestion.value.data![questionIndex].queid!)
                                    : null,
                                child: AnswerCard(
                                  currentIndex: index,
                                  question: questionController.apiQuestion.value
                                          .data?[questionIndex].option?[index] ??
                                      '',
                                  isSelected: selectedAnswerIndex == index,
                                  selectedAnswerIndex: selectedAnswerIndex,
                                  correctAnswerIndex:
                                      questionController.apiQuestion.value.data?[questionIndex].rightAns,
                                )),
                          );
                        },
                      ),
              ],
            ), 
          ),
        ),
        bottomNavigationBar: questionController.apiQuestion.value.data!.isEmpty ?null: isLastQuestion ?? false
            ? CommonButton(
                onPress: () async {
                  if (selectedAnswerIndex != null) {
                    questionController.resultDataSend(
                        context: context,
                        stdid: widget.stdId,
                        subid: widget.subId,
                        chapterid: widget.chapterId,
                        questions: resultData);
                  } else {
                    DialogUtils.showCustomDialog(context, "Empty Answer", "Please Select Question");
      
                    // commonSnackBar(
                    //     context: context, msg: "Please select question");
                  }
                },
                title: 'Finish',
              )
            : CommonButton(
                onPress: () {
                  if (selectedAnswerIndex != null) {
                    questionIndex = questionIndex + 1;
                    selectedAnswerIndex = null;
                  } else {
                    
                    DialogUtils.showCustomDialog(context, "Empty Answer", "Please Select Question");
                  }
                  setState(() {});
                },
                title: 'Next',
              ),
      ),
    );
  }
}
