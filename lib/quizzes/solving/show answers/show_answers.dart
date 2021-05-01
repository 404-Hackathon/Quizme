import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

import '../../../quiz.dart';

class ShowAnswers extends StatefulWidget {
  ShowAnswers({Key key, this.quiz, this.results}) : super(key: key);
  final Quiz quiz;
  final Results results;
  @override
  _ShowAnswersState createState() => _ShowAnswersState();
}

class _ShowAnswersState extends State<ShowAnswers> {
  @override
  Widget build(BuildContext context) {
    Quiz quiz = widget.quiz;
    Results result = widget.results;
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
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
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Container(
          child: ListView.builder(
            itemCount: quiz.questions.length,
            itemBuilder: (context, qIndex) {
              Questions question = quiz.questions[qIndex];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text(
                          question.question,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                          ),
                        ),
                        Column(
                          children:
                              List.generate(question.options.length, (index) {
                            List option = question.options.keys.toList();
                            return Row(
                              children: [
                                Icon(
                                  result.answers[qIndex].correct == question.options[option[index]]
                                      ? Icons.check_rounded
                                      : Icons.clear_rounded,
                                  size: 36,
                                  color: result.answers[qIndex].correct == question.options[option[index]]
                                      ? Colors.green[400]
                                      : Colors.redAccent,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: result.answers[qIndex].answer == option[index] ? Colors.orangeAccent : Colors.transparent,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      option[index],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            );
                          }),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
