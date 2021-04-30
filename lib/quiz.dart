class Quiz {
  final String name;
  final List<Questions> questions;
  final List<Results> userResults;
  final int id;

  Quiz({this.id, this.userResults, this.name, this.questions});
}

class Questions {
  final String question;
  final Map<String, bool> options;

  Questions({this.question, this.options});
}

class Results {
  final String totalTime;
  final int numberOfCorrectAnswers;
  final List<Answer> answers;

  Results({this.totalTime, this.numberOfCorrectAnswers, this.answers});
}

class Answer {
  final String time;
  final bool correct;
  final String answer;

  Answer({this.time, this.correct, this.answer});
}

List<Questions> _questions = [
  Questions(
    question: 'Chose The Best team name: ',
    options: {
      '404': true,
      'not 404': false,
      'Elite': false,
      'نحبه نحبه نحبه': false
    },
  ),
  Questions(
    question: 'Who is gonna win the hackathon? ',
    options: {
      '404': true,
      'not 404': false,
      'Elite': false,
      'نحبه نحبه نحبه': false
    },
  )
];

List<Results> testQuizResults = [
  Results(
    answers: [
      Answer(answer: '404', correct: true, time: '1:40'),
      Answer(answer: 'not 404', correct: false, time: '1:00'),
    ],
  ),
];

List<Quiz> quizzes = [
  Quiz(name: 'Test 1', questions: _questions, userResults: testQuizResults, id: 1)
];
