class Quiz {
  final String name;
  final List<Questions> questions;

  Quiz({this.name, this.questions});

}

class Questions {
  final String question;
  final Map<String, bool> options;

  Questions({this.question, this.options});
}

List<Questions> questions = [];

List<Quiz> quizzes = [];
