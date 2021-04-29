import 'package:flutter/material.dart';

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
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.add_circle_rounded, color: Colors.black,),
              onPressed: () {},
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Container(
          child: Text('Hello, World'),
        ),
      ),
    );
  }
}
