import 'package:flutter/material.dart';
import 'package:quizme/quiz.dart';
import 'package:quizme/quizzes/quizzes_screen.dart';

class CreatePage extends StatefulWidget {
  CreatePage({Key key}) : super(key: key);

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  // final _formKey = GlobalKey<FormState>();

  // bool editModeIsEnabled = true;

  String name = '';
  String question = '';
  String field1Text = '';
  String field2Text = '';
  String field3Text = '';
  String field4Text = '';

  bool field1 = true;
  bool field2 = false;
  bool field3 = false;
  bool field4 = false;

  int numberOfPages = 1;

  List<Questions> questions = [];
  Map<String, bool> options;

  @override
  Widget build(BuildContext context) {
    final PageController controller = PageController(initialPage: 0);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextFormField(
          // enabled: editModeIsEnabled,
          onChanged: (val) {
            setState(() {
              name = val;
            });
          },
          maxLines: 1,
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            // fontSize: 36,
          ),
          decoration: InputDecoration.collapsed(
            hintText: 'Enter Your Quiz Name',
          ),
        ),
        // iconTheme: IconTheme(),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          /*IconButton(
            icon: Icon(
              editModeIsEnabled ? Icons.edit_rounded : Icons.edit_outlined,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                // editModeIsEnabled
                //     ? editModeIsEnabled = false
                //     : editModeIsEnabled = true;
              });
            },
          ),*/
        ],
      ),
      body: PageView(
        controller: controller,
        scrollDirection: Axis.horizontal,
        children: List.generate(numberOfPages, (index) {
          return Form(
            // key: _formKey,
            child: SafeArea(
              child: Center(
                child: Container(
                  child: Column(
                    children: [
                      Spacer(),
                      TextFormField(
                        // enabled: editModeIsEnabled,
                        maxLines: null,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 36,
                        ),
                        onChanged: (val) {
                          setState(() {
                            question = val;
                          });
                        },
                        decoration: new InputDecoration.collapsed(
                          hintText: 'Insert your question',
                        ),
                      ),
                      Spacer(),
                      AnsewrsCheckBox(
                          onChanged: (val) {
                            setState(() {
                              field1Text = val;
                            });
                          },
                          fieldIsChecked: field1,
                          isChecked: (val) {
                            setState(() {
                              field1 = true;
                              field2 = false;
                              field3 = false;
                              field4 = false;
                            });
                          }),
                      AnsewrsCheckBox(
                          onChanged: (val) {
                            setState(() {
                              field2Text = val;
                            });
                          },
                          fieldIsChecked: field2,
                          isChecked: (val) {
                            setState(() {
                              field1 = false;
                              field2 = true;
                              field3 = false;
                              field4 = false;
                            });
                          }),
                      AnsewrsCheckBox(
                          onChanged: (val) {
                            setState(() {
                              field3Text = val;
                            });
                          },
                          fieldIsChecked: field3,
                          isChecked: (val) {
                            setState(() {
                              field1 = false;
                              field2 = false;
                              field3 = true;
                              field4 = false;
                            });
                          }),
                      AnsewrsCheckBox(
                          onChanged: (val) {
                            setState(() {
                              field4Text = val;
                            });
                          },
                          fieldIsChecked: field4,
                          isChecked: (val) {
                            setState(() {
                              field1 = false;
                              field2 = false;
                              field3 = false;
                              field4 = true;
                            });
                          }),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: GestureDetector(
                          onTap: () {
                            // if (_formKey.currentState.validate()) {
                            setState(() {
                              numberOfPages += 1;
                              questions.add(
                                Questions(
                                  question: question,
                                  options: {
                                    field1Text: field1,
                                    field2Text: field2,
                                    field3Text: field3,
                                    field4Text: field4,
                                  },
                                ),
                              );
                            });
                            controller.nextPage(
                                duration: Duration(seconds: 1),
                                curve: Curves.fastOutSlowIn);
                            // }
                          },
                          child: Container(
                            height: 50,
                            // width: 200,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Create New Question!",
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
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            // if (_formKey.currentState.validate()) {
                            // setState(() {
                            //   numberOfPages += 1;
                            // });
                            quizzes.add(
                              Quiz(
                                  name: name,
                                  questions: questions,
                                  id: quizzes.length + 1),
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => QuizzesPage()),
                            ).then((value) => setState(() {}));

                            // }
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                          ),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
        // child:
      ),
    );
  }
}

class AnsewrsCheckBox extends StatelessWidget {
  const AnsewrsCheckBox({
    Key key,
    this.fieldIsChecked,
    this.isChecked,
    this.controller,
    this.onChanged,
  }) : super(key: key);

  // final bool editModeIsEnabled;
  final TextEditingController controller;
  final bool fieldIsChecked;
  final Function(bool) isChecked;
  final Function(String) onChanged;
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      activeColor: Colors.pink[300],
      dense: true,
      //font change
      title: TextField(
        onChanged: (val) {
          onChanged(val);
        },
        // enabled: editModeIsEnabled,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: new InputDecoration.collapsed(
            hintText: 'Insert an answer',
            hintStyle: TextStyle(color: Colors.black.withOpacity(0.8))),
        // validator: (value) {
        //   if (value == null || value.isEmpty) {
        //     return 'Please enter some text';
        //   } else {}
        //   return null;
        // },
      ),
      value: fieldIsChecked,
      onChanged: (bool val) {
        isChecked(val);
        // itemChange(val, index);
      },
    );
  }
}
