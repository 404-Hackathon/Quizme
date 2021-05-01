import 'package:flutter/material.dart';
import 'package:quizme/quiz.dart';

class QuizAnswers extends StatefulWidget {
  QuizAnswers({Key key, this.quiz}) : super(key: key);

  final Quiz quiz;
  @override
  _QuizAnswersState createState() => _QuizAnswersState();
}

class _QuizAnswersState extends State<QuizAnswers> {
  @override
  Widget build(BuildContext context) {
    Quiz quiz = widget.quiz;
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
            itemBuilder: (context, index) {
              Questions question = quiz.questions[index];
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
                                  question.options[option[index]] ?  Icons.check_rounded : Icons.clear_rounded,
                                  size: 36,
                                  color: question.options[option[index]] ? Colors.green[400] : Colors.redAccent,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    // color: Colors.blue,
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
