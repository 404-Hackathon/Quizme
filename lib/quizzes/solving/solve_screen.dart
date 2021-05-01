import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:quizme/quiz.dart';
import 'package:group_button/group_button.dart';
import 'package:quizme/quizzes/quizzes_screen.dart';
import 'package:quizme/quizzes/solving/results/results_screen.dart';
import 'package:audioplayers/audio_cache.dart';
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
  AudioCache player = AudioCache();
  List<Answer> answers = [];
  Future<AudioPlayer> playLocalAsset() async {
    AudioCache cache = new AudioCache();
    return await cache.play("sound.mp3");
  }

  final _isHours = true;

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp,
    // onChange: (value) => print('onChange $value'),
    // onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
    // onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
  );
  final StopWatchTimer questionStopWatch = StopWatchTimer(
    mode: StopWatchMode.countUp,
  );

  @override
  void initState() {
    super.initState();
    // _stopWatchTimer.rawTime.listen((value) =>
    //     print('rawTime $value ${StopWatchTimer.getDisplayTime(value)}'));
    // _stopWatchTimer.minuteTime.listen((value) => print('minuteTime $value'));
    // _stopWatchTimer.secondTime.listen((value) => print('secondTime $value'));
    // _stopWatchTimer.records.listen((value) => print('records ${value}'));
    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
    questionStopWatch.onExecute.add(StopWatchExecute.start);

    /// Can be set preset time. This case is "00:01.23".
    // _stopWatchTimer.setPresetTime(mSec: 1234);
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
    await questionStopWatch.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Quiz quiz = widget.quiz;
    final PageController controller = PageController(initialPage: 0);
    quiz.questions.shuffle();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Hero(
          tag: 'Title',
          child: Material(
            color: Colors.transparent,
            child: Text(
              quiz.name,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                // fontSize: 36,
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: StreamBuilder<int>(
                stream: _stopWatchTimer.rawTime,
                initialData: _stopWatchTimer.rawTime.valueWrapper?.value,
                builder: (context, snap) {
                  final value = snap.data;
                  final displayTime = StopWatchTimer.getDisplayTime(value,
                      hours: false, milliSecond: false);
                  return Text(
                    displayTime,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      // fontSize: 36,
                    ),
                  );
                }),
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => QuizzesPage()));
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
              child: Stack(
                children: [
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: StreamBuilder<int>(
                                stream: questionStopWatch.rawTime,
                                initialData: questionStopWatch
                                    .rawTime.valueWrapper.value,
                                builder: (context, snap) {
                                  final value = snap.data;
                                  final displayTime =
                                      StopWatchTimer.getDisplayTime(value,
                                          hours: false, milliSecond: false);
                                  return Text(
                                    displayTime,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 36,
                                    ),
                                  );
                                }),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          StreamBuilder<int>(
                              stream: questionStopWatch.rawTime,
                              initialData:
                                  questionStopWatch.rawTime.valueWrapper?.value,
                              builder: (context, snap) {
                                final value = snap.data;
                                final seconds =
                                    StopWatchTimer.getRawSecond(value);
                                // print(seconds);
                                return GroupButton(
                                  isRadio: true,
                                  spacing: 10,
                                  direction: Axis.vertical,
                                  buttonHeight: 50,
                                  // buttonWidth: 200,
                                  onSelected: (index, isSelected) {
                                    questionStopWatch.onExecute
                                        .add(StopWatchExecute.reset);
                                    bool isTrue = quiz.questions[qIndex]
                                        .options[options[index]];
                                    // print('$index button is selected');
                                    answers.add(
                                      Answer(
                                        answer: options[index],
                                        correct: isTrue,
                                        time: seconds,
                                      ),
                                    );
                                    playLocalAsset();
                                    questionStopWatch.onExecute
                                        .add(StopWatchExecute.start);
                                    if (qIndex != quiz.questions.length - 1) {
                                      controller.nextPage(
                                          duration: Duration(seconds: 1),
                                          curve: Curves.fastOutSlowIn);
                                    } else {}
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
                                );
                              }),
                        ],
                      ),
                      Spacer(
                        flex: 3,
                      ),
                    ],
                  ),
                  qIndex == quiz.questions.length - 1
                      ? StreamBuilder<int>(
                          stream: _stopWatchTimer.rawTime,
                initialData: _stopWatchTimer.rawTime.valueWrapper?.value,
                builder: (context, snap) {
                  final value = snap.data;
                  final seconds = StopWatchTimer.getRawSecond(value);
                            return Positioned(
                              bottom: 20,
                              right: 20,
                              child: TextButton(
                                child: Text('Submit!'),
                                onPressed: () {
                                  int counter = 0;

                                  for (var i in answers) {
                                    if (i.correct) {
                                      counter += 1;
                                    }
                                  }
                                  setState(() {
                                    quizzes[quiz.id - 1].userResults.add(
                                        Results(
                                            answers: answers,
                                            numberOfCorrectAnswers: counter,
                                            totalTime: seconds));
                                  });
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(builder: (context) {
                                    return ResultPage(
                                      results: Results(
                                          answers: answers,
                                          numberOfCorrectAnswers: counter,
                                          totalTime: seconds,),
                                          quiz: widget.quiz,
                                    );
                                  }));
                                },
                              ),
                            );
                          })
                      : Container(),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
