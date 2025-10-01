class Question {
  final String questionText;
  final bool questionAnswer;

  Question({required this.questionText, required this.questionAnswer});
}

class Book {
  final String title;
  final String author;
  final String imagePath;
  final List<Question> questions;

  Book({
    required this.title,
    required this.author,
    required this.imagePath,
    required this.questions,
  });
}