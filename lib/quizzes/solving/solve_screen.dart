import 'package:flutter/material.dart';
import 'package:quizme/quiz.dart';
import 'package:group_button/group_button.dart';
import 'package:quizme/quizzes/solving/results/results_screen.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class QuizPage extends StatefulWidget {
  QuizPage({Key key, @required this.quiz}) : super(key: key);

  final Quiz quiz;

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  bool field1 = true;
  bool field2 = false;
  bool field3 = false;
  bool field4 = false;

  List<Answer> answers = [];

  @override
  Widget build(BuildContext context) {
    Quiz quiz = widget.quiz;
    final PageController controller = PageController(initialPage: 0);
    quiz.questions.shuffle();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          quiz.name,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            // fontSize: 36,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        scrollDirection: Axis.horizontal,
        children: List.generate(quiz.questions.length, (qIndex) {
          List options = quiz.questions[qIndex].options.keys.toList();
          options.shuffle();
          return SafeArea(
            child: Container(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          '1:00',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 36,
                          ),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                          '${qIndex + 1}/${quiz.questions.length}',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 36,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Text(
                      quiz.questions[qIndex].question,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 36,
                      ),
                    ),
                  ),
                  Spacer(),
                  Column(
                    /*children: List.generate(
                        quiz.questions[qIndex].options.length, (index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 100),
                        child: GestureDetector(
                          onTap: () {
                            
                          },
                          child: Container(
                            height: 50,
                            // width: 200,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  options[index],
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24),
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                        ),
                      );
                    }),*/
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GroupButton(
                        isRadio: true,
                        spacing: 10,
                        direction: Axis.vertical,
                        buttonHeight: 50,
                        // buttonWidth: 200,
                        onSelected: (index, isSelected) {
                          bool isTrue =
                              quiz.questions[qIndex].options[options[index]];
                          print('$index button is selected');
                          answers.add(Answer(
                              answer: options[index],
                              correct: isTrue,
                              time: '1:80'));
                          if (qIndex != quiz.questions.length - 1) {
                            controller.nextPage(
                                duration: Duration(seconds: 1),
                                curve: Curves.fastOutSlowIn);
                          } else {
                            int counter = 0;
                            for (var i in answers) {
                              if (i.correct) {
                                counter += 1;
                              }
                            }
                            setState(() {
                              quizzes[quiz.id - 1].userResults.add(Results(
                                  answers: answers,
                                  numberOfCorrectAnswers: counter,
                                  totalTime: '5:30'));
                            });

                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ResultPage(
                                results: Results(
                                    answers: answers,
                                    numberOfCorrectAnswers: counter,
                                    totalTime: '5:30'),
                              );
                            }));
                          }

                          // print(options[index]);
                          // print(isTrue);
                        },
                        buttons: options,
                        selectedTextStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                        unselectedTextStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 24,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ],
                  ),
                  Spacer(
                    flex: 3,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
