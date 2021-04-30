import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:quizme/quiz.dart';
import 'package:quizme/quizzes/create/create_scrren.dart';
import 'package:quizme/quizzes/solving/solve_screen.dart';

class QuizzesPage extends StatefulWidget {
  QuizzesPage({Key key}) : super(key: key);

  @override
  _QuizzesPageState createState() => _QuizzesPageState();
}

class _QuizzesPageState extends State<QuizzesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'My Quizzes',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
      backgroundColor: Colors.grey[150],
      body: SafeArea(
        child: Center(
          child: Container(
            child: quizzes.length == null || quizzes.length == 0
                ? TextButton(
                    onPressed: () {
                      pushNewScreen(
                        context,
                        screen: CreatePage(),
                        withNavBar: false, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
                      );
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
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuizPage(quiz: quizzes[index],),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Center(
                            child: Container(
                              height: 100,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      quizzes[index].name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24),
                                    ),
                                  ),
                                  Spacer()
                                ],
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
}
