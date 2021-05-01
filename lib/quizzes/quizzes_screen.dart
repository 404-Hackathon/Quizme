import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:quizme/quiz.dart';
import 'package:quizme/quizzes/create/create_scrren.dart';
import 'package:quizme/quizzes/quiz_answers.dart';
import 'package:quizme/quizzes/solving/solve_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuizzesPage extends StatefulWidget {
  QuizzesPage({Key key}) : super(key: key);

  @override
  _QuizzesPageState createState() => _QuizzesPageState();
}

class _QuizzesPageState extends State<QuizzesPage> {
  // int attempts = 0;
  // double avrage = 0;

  // Future<void> setAvrageAndAttempts() async {
  //   attempts = await _readAttempts();
  //   avrage = await _readAvrage();
  //   setState(() {});
  // }

  @override
  void initState() {
    super.initState();

    // setState(() {});
    // });
    // _readAttempts();
    // _readAvrage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE5E5E5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'My Quizzes',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: TextButton(
          child: Text('Save'),
          onPressed: () {
            // _save();
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(
                Icons.add_circle_rounded,
                color: Colors.black,
              ),
              onPressed: () {
                // Navigator.pushNamed(context, '/create');
                //
                pushNewScreen(
                  context,
                  screen: CreatePage(),
                  withNavBar: false, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Container(
            child: quizzes.length == null || quizzes.length == 0
                ? TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CreatePage()));
                    },
                    child: Text(
                      'Click to Create Quiz!',
                      style: TextStyle(fontSize: 36),
                    ),
                  )
                : ListView.builder(
                    itemCount: quizzes.length == null || quizzes.length == 0
                        ? 1
                        : quizzes.length,
                    itemBuilder: (context, index) {
                      int correctAnswers = 0;
                                  // int totalNumberOfAsnwers = 0;
                                  for (var i in quizzes[index].userResults) {
                                    correctAnswers += i.numberOfCorrectAnswers;
                                    // totalNumberOfAsnwers += i.answers.length;
                                  }
                                  double avrage =
                                      correctAnswers / quizzes[index].questions.length;
                      // List<int> scores = [];
                      // for (var i in quizzes[index].userResults) {
                      //   if (quizzes[index].userResults.length != 0) {
                      //     scores.add(i.numberOfCorrectAnswers);
                      //   }
                      // }
                      // double scoreAvrage = ((scores
                      //         .reduce((value, element) => value + element)
                      //         .toDouble()) /
                      //     scores.length);
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuizPage(
                                quiz: quizzes[index],
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Center(
                            child: Container(
                              // height: 100,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          quizzes[index].name,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 24),
                                        ),
                                        Spacer(),
                                        IconButton(
                                            icon: Icon(
                                              Icons.question_answer_rounded,
                                              color: Colors.black,
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          QuizAnswers(
                                                            quiz:
                                                                quizzes[index],
                                                          )));
                                            })
                                      ],
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: 'Number of Attempts: ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text:
                                                // '${quizzes[index].userResults.length}',
                                                '${quizzes[index].userResults.length}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: 'Score Avrage: ',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text: '$avrage',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15))),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }

  Future<int> _readAttempts() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'number_of_attempts:';
    final value = prefs.getInt(key) ?? 0;
    print('read: $value');
    return value;
  }

  Future<double> _readAvrage() async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'number_of_correctAnswers:';
    final value = prefs.getDouble(key) ?? 0;
    print('read: $value');
    return value;
  }

  _save({int number_of_attempts, double number_of_correctAnswers}) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'number_of_attempts';
    final value = number_of_attempts;
    final key2 = 'number_of_correctAnswers';
    final value2 = number_of_correctAnswers;
    prefs.setInt(key, value);
    prefs.setDouble(key2, value2);
    print('saved $value');
  }
  // _read() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final key = 'my_int_key';
  //   final value = prefs.getInt(key) ?? 0;
  //   print('read: $value');
  // }

  // _save() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final key = 'statics';
  //   final value = ['${.userResults.length}', 'cow', 'sheep'];
  //   prefs.setStringList(key, value);
  //   print('saved $value');
  // }
}
