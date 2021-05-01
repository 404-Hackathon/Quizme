
class Quiz {
  final String name;
  final List<Questions> questions;
  List<Results> userResults = [];
  final int id;

  Quiz({this.id, this.name, this.questions});

  // String avrageScore() {
  //   var scores = 0;
  //   for (var i in userResults.length) {
  //     i.correct ? scores++ : null;
  //   }
  //   for (var i in answers) {

  //   }
  // }
  //
  Map toJson() => {
        'name': name,
        'questions': [
          {'question': questions}
        ]
      };
}

class Questions {
  final String question;
  final Map<String, bool> options;

  Questions({this.question, this.options});
}

class Results {
  final int totalTime;
  final int numberOfCorrectAnswers;
  // final int avrageQuestionTime;
  final List<Answer> answers;
  List<Questions> questions = [];

  Results(
      {this.questions,
      // this.avrageQuestionTime,
      this.totalTime,
      this.numberOfCorrectAnswers,
      this.answers});

  int avrageTime() {
    int sum = answers.fold(0, (p, c) => p + c.time);
    return (sum / answers.length).round();
  }
}

/*
int minutes = (time / 60).truncate();
    String minutesStr = (minutes % 60).toString().padLeft(2, '0');*/
class Answer {
  final int time;
  final bool correct;
  final String answer;

  Answer({this.time, this.correct, this.answer});
}

// List<Questions> _questions = [
//   Questions(
//     question: 'Chose The Best team name: ',
//     options: {
//       '404': true,
//       'not 404': false,
//       'Elite': false,
//       'نحبه نحبه نحبه': false
//     },
//   ),
//   Questions(
//     question: 'Who is gonna win the hackathon? ',
//     options: {
//       '404': true,
//       'not 404': false,
//       'Elite': false,
//       'نحبه نحبه نحبه': false
//     },
//   )
// ];

// List<Results> testQuizResults = [
//   Results(
//     answers: [
//       Answer(answer: '404', correct: true, time: 120),
//       Answer(answer: 'not 404', correct: false, time: 60),
//     ],
//   ),
// ];

// List<Quiz> quizzes = [Quiz(name: 'Test 1', questions: _questions, id: 1)];
//
List<Quiz> quizzes = [];
