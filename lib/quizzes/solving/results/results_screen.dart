import 'package:flutter/material.dart';
import 'package:quizme/quiz.dart';

import 'circle.dart';

class ResultPage extends StatefulWidget {
  ResultPage({Key key, @required this.results}) : super(key: key);
  final Results results;
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
      body: Center(
        child: Column(
          children: [
            CustomPaint(
              foregroundPainter: CircleProgress(animation.value),
              child: Container(
                width: 200,
                height: 200,
                child: Center(
                  child: Text(
                    "${percent.round()}%",
                    style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
