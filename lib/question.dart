class Question {
  final String text;
  final List<String> options;
  final int correctOptionIndex;
  final String? explanation;

  Question({
    required this.text,
    required this.options,
    required this.correctOptionIndex,
    this.explanation,
  });
}