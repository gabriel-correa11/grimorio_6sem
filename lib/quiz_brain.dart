import 'book.dart';

class QuizBrain {
  int _questionNumber = 0;
  int _currentBookIndex = 0;

  final List<Book> _bookData = [
    Book(
      title: 'O Pequeno Príncipe',
      author: 'Antoine de Saint-Exupéry',
      imagePath: 'assets/images/pequeno_principe.jpg',
      questions: [
        Question(questionText: 'O principezinho vivia num planeta com três vulcões.', questionAnswer: true),
        Question(questionText: 'O primeiro desenho do autor foi o de uma jiboia a digerir um elefante.', questionAnswer: true),
        Question(questionText: 'A rosa era humilde e não era vaidosa.', questionAnswer: false),
      ],
    ),
    Book(
      title: 'Harry Potter e a Pedra Filosofal',
      author: 'J.K. Rowling',
      imagePath: 'assets/images/harry_potter_pedra_filosofal.jpg',
      questions: [
        Question(questionText: 'O nome do tio de Harry era Dumbledore.', questionAnswer: false),
        Question(questionText: 'Harry recebeu a sua primeira carta de Hogwarts no seu 11º aniversário.', questionAnswer: true),
        Question(questionText: 'O cão de três cabeças chamava-se Fofinho.', questionAnswer: true),
        Question(questionText: 'A Pedra Filosofal foi criada por Nicolau Flamel.', questionAnswer: true),
      ],
    ),
  ];

  String getCurrentBookTitle() {
    return _bookData[_currentBookIndex].title;
  }

  int getBookCount() {
    return _bookData.length;
  }

  Book getBook(int index) {
    return _bookData[index];
  }

  void selectBook(int index) {
    _currentBookIndex = index;
    reset();
  }

  void nextQuestion() {
    if (_questionNumber < _bookData[_currentBookIndex].questions.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestionText() {
    return _bookData[_currentBookIndex].questions[_questionNumber].questionText;
  }

  bool getCorrectAnswer() {
    return _bookData[_currentBookIndex].questions[_questionNumber].questionAnswer;
  }

  int getTotalQuestions() {
    return _bookData[_currentBookIndex].questions.length;
  }

  bool isFinished() {
    return _questionNumber >= _bookData[_currentBookIndex].questions.length - 1;
  }

  void reset() {
    _questionNumber = 0;
  }
}