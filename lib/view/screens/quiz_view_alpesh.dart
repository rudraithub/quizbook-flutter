import 'package:flutter/material.dart';
import 'package:rudra_it_hub/controller/quiz_controller.dart';
import 'package:rudra_it_hub/widgets/answer_card.dart';
import 'package:rudra_it_hub/widgets/common_button.dart';
import 'package:rudra_it_hub/widgets/common_snack_bar.dart';
import '../../model/question_api_data.dart';
import '../../utils/constants.dart';

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
  QuestionApiData? apiQuestion;
  bool? isLastQuestion;
  int score = 0;
  List<Map<String, dynamic>> resultData = [];
  QuestionController questionController = QuestionController();

  Future<void> fetchData() async {
    // Simulate an asynchronous operation (e.g., API call)
    // RemoteServices.getQuestionList(widget.stdId, widget.subId, widget.chapterId, context);
    // QuestionApiData tm = await RemoteServices.getQuestionList(4, 1, 1, context);
    QuestionApiData tm = await questionController.getQuestionList(
        stdId: widget.stdId,
        subId: widget.subId,
        chapterId: widget.chapterId,
        context: context);
    setState(() {
      apiQuestion = tm;
      // print("fetchData is ${apiQuestion!.data![0].option}");
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
    // print("result data is ${resultData}");

    selectedAnswerIndex = value;

    // final question = _questionController.questions[questionIndex];
    if (selectedAnswerIndex == answerIndex) {
      score++;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    isLastQuestion = (questionIndex + 1) == apiQuestion?.data?.length;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
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
                    Text(
                      widget.titleName,
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: ((screenWidth * 5) / 100),
                    ),
                    Text(apiQuestion?.data?[questionIndex].question ?? '',
                        style: const TextStyle(color: Colors.white),
                        textAlign: TextAlign.center),
                  ],
                ),
              ),
              apiQuestion == null
                  ? const CircularProgressIndicator()
                  : ListView.builder(
                      shrinkWrap: true,
                      // itemCount: _questionController.questions[questionIndex].options.length,
                      itemCount:
                          apiQuestion?.data?[questionIndex].option?.length ?? 0,
                      itemBuilder: (context, index) {
                        // print(
                        //     "index data $index >> ${apiQuestion?.data?[questionIndex].option?[index]}");
                        return Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: InkWell(
                              onTap: selectedAnswerIndex == null
                                  ? () => pickAnswer(index, selectedAnswerIndex,
                                      apiQuestion!.data![questionIndex].queid!)
                                  : null,
                              child: AnswerCard(
                                currentIndex: index,
                                question: apiQuestion
                                        ?.data?[questionIndex].option?[index] ??
                                    '',
                                isSelected: selectedAnswerIndex == index,
                                selectedAnswerIndex: selectedAnswerIndex,
                                correctAnswerIndex:
                                    apiQuestion?.data?[questionIndex].rightAns,
                              )),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: isLastQuestion ?? false
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
                  commonSnackBar(
                      context: context, msg: "Please select question");
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
                  commonSnackBar(
                      context: context, msg: "Please select question");
                }
                setState(() {});
              },
              title: 'Next',
            ),
    );
  }
}
