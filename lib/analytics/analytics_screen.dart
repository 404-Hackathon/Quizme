import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:quizme/quiz.dart';

class AnalyticsPage extends StatefulWidget {
  AnalyticsPage({Key key}) : super(key: key);

  @override
  _AnalyticsStatePage createState() => _AnalyticsStatePage();
}

class _AnalyticsStatePage extends State<AnalyticsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Analytics',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: List.generate(quizzes.length, (index) {
              Quiz quiz = quizzes[index];
              List<int> scores = [];
              for (var i in quiz.userResults) {
                scores.add(i.numberOfCorrectAnswers);
              }
              double RawScoreAvrage = ((scores
                      .reduce((value, element) => value + element)
                      .toDouble()) /
                  scores.length);

              String convertToString = RawScoreAvrage.toStringAsFixed(2);
              double scoreAvrage = double.parse(convertToString);

              return ExpandablePanel(
                header: Container(
                  // height: 100,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Test 1',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                ),
                collapsed: Text(
                  '',
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                expanded: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'Number of Attempts: ',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: '${quiz.userResults.length}',
                              style: TextStyle(fontWeight: FontWeight.bold),
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
                              text: '$scoreAvrage',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
