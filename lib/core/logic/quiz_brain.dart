import 'package:grimorio/core/models/book.dart';
import 'package:grimorio/core/models/question.dart';

class QuizBrain {
  final List<List<Question>> _booksQuizzes = [
    [
      Question(
        text: 'Qual o nome do diretor de Hogwarts no primeiro livro?',
        options: [
          'Severo Snape',
          'Minerva McGonagall',
          'Alvo Dumbledore',
          'Rúbeo Hagrid'
        ],
        correctOptionIndex: 2,
      ),
      Question(
        text: 'O que o Chapéu Seletor gritou ao colocar Harry em sua casa?',
        options: ['CORVINAL!', 'LUFA-LUFA!', 'SONSERINA!', 'GRIFINÓRIA!'],
        correctOptionIndex: 3,
      ),
    ],
    [
      Question(
        text: 'Qual foi o primeiro desenho que o narrador fez quando criança?',
        options: [
          'Um chapéu',
          'Uma jiboia digerindo um elefante',
          'Uma ovelha',
          'Uma caixa'
        ],
        correctOptionIndex: 1,
      ),
      Question(
        text: 'De qual planeta o Pequeno Príncipe veio?',
        options: ['Marte', 'Asteroide B-612', 'Terra', 'Júpiter'],
        correctOptionIndex: 1,
      ),
    ],
  ];

  List<Book> getBooks() {
    return [
      Book(
        title: 'Harry Potter e a Pedra Filosofal',
        author: 'J.K. Rowling',
        imagePath: 'assets/images/harry_potter_pedra_filosofal.jpg',
      ),
      Book(
        title: 'O Pequeno Príncipe',
        author: 'Antoine de Saint-Exupéry',
        imagePath: 'assets/images/pequeno_principe.jpg',
      ),
    ];
  }

  List<Question> getQuestionsForBook(int bookIndex) {
    return _booksQuizzes[bookIndex];
  }
}