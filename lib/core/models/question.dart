class Question {
  final String text;
  final List<QuestionOptions> options;

  Question({
    required this.text,
    required this.options,
  });
}

class QuestionOptions {
  final String id;
  final bool isCorrect;
  final String text;
  final String? explanation;

  QuestionOptions({
    required this.id,
    required this.isCorrect,
    required this.text,
    this.explanation,
  });
}