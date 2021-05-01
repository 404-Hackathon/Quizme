import 'package:flutter/material.dart';
import 'package:quizme/quiz.dart';
import 'package:quizme/quizzes/quizzes_screen.dart';
import 'package:quizme/quizzes/solving/show%20answers/show_answers.dart';
import 'circle.dart';

class ResultPage extends StatefulWidget {
  ResultPage({Key key, @required this.results, this.quiz}) : super(key: key);
  final Results results;
  final Quiz quiz;
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage>
    with SingleTickerProviderStateMixin {
  AnimationController progressController;
  Animation<double> animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    double percent = (widget.results.numberOfCorrectAnswers /
            widget.results.answers.length) *
        100;

    progressController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    animation =
        Tween<double>(begin: 0, end: percent).animate(progressController)
          ..addListener(() {
            setState(() {});
          });
    if (animation.value == percent) {
      progressController.reverse();
    } else {
      progressController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    double percent = (widget.results.numberOfCorrectAnswers /
            widget.results.answers.length) *
        100;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Spacer(),
              CustomPaint(
                foregroundPainter: CircleProgress(animation.value),
                child: Container(
                  width: 200,
                  height: 200,
                  child: Center(
                    child: Text(
                      "${percent.round()}%",
                      style:
                          TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Column(
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Total Correct: ',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  '${widget.results.numberOfCorrectAnswers} / ${widget.results.answers.length}',
                              style: new TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Total Time: ',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text:
                                  '${((widget.results.totalTime / 60).truncate() % 60).toString().padLeft(2, '0')}:${widget.results.totalTime}',
                              style: new TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Avrage Time: ',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              // text: widget.results.avrageTime().toString(),
                              text:
                                  '${((widget.results.avrageTime() / 60).truncate() % 60).toString().padLeft(2, '0')}:${widget.results.avrageTime()}',
                              style: new TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Avrage Correct Answers: ',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              // text: widget.results.avrageTime().toString(),
                              text:
                                  (widget.results.numberOfCorrectAnswers / widget.results.answers.length).round() == 1 ? '100%' : '${(widget.results.numberOfCorrectAnswers / widget.results.answers.length).round()}',
                              style: new TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ShowAnswers(results: widget.results, quiz: widget.quiz,)));
                  },
                  child: Container(
                    height: 50,
                    // width: 200,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Your Answers!",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => QuizzesPage()));
                  },
                  child: Container(
                    width: 100,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Done!",
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                        // color: Colors.blueAccent,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                  ),
                ),
              ),
              Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
