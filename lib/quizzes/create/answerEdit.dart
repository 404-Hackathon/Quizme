import 'package:flutter/material.dart';

class AnswerEdit extends StatelessWidget {
  const AnswerEdit(
      {Key key,
      this.formKey,
      this.editMode,
      this.textFieldValue,
      this.notEmpty, this.selected})
      : super(key: key);

  final GlobalKey<FormState> formKey;
  final bool editMode;
  final Function(String) textFieldValue;
  final Function notEmpty;
  final bool selected;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: GestureDetector(
        onTap: () {
          if (formKey.currentState.validate()) {
            print(notEmpty);
          }
        },
        child: Container(
          height: 50,
          // width: 200,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                enabled: editMode,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
                decoration: new InputDecoration.collapsed(
                    hintText: 'Insert an answer',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.8))),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  } else {
                    textFieldValue(value);
                  }
                  return null;
                },
              ),
            ),
          ),
          decoration: BoxDecoration(
              color: selected ? Colors.greenAccent : Colors.redAccent,
              borderRadius: BorderRadius.all(Radius.circular(15))),
        ),
      ),
    );
  }
}
