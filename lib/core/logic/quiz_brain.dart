import 'package:grimorio/core/models/book.dart';
import 'package:grimorio/core/models/chapter.dart';
import 'package:grimorio/core/models/question.dart';

class QuizBrain {
  final List<Book> _booksData = [
    Book(
      id: '0',
      title: 'Harry Potter e a Pedra Filosofal',
      author: 'J.K. Rowling',
      imagePath: 'assets/images/harry_potter_pedra_filosofal.jpg',
      chapters: [
        Chapter(id: 'hp_cap1', title: 'O Menino Que Sobreviveu'),
        Chapter(id: 'hp_cap2', title: 'O Vidro Que Sumiu'),
        Chapter(id: 'hp_cap3', title: 'As Cartas de Ninguém'),
      ],
    ),
    Book(
      id: '1',
      title: 'O Pequeno Príncipe',
      author: 'Antoine de Saint-Exupéry',
      imagePath: 'assets/images/pequeno_principe.jpg',
      chapters: [
        Chapter(id: 'pp_cap1', title: 'O Desenho da Jiboia'),
        Chapter(id: 'pp_cap2', title: 'O Astrônomo Turco'),
        Chapter(id: 'pp_cap3', title: 'A Flor Vaidosa'),
      ],
    ),
  ];

  final Map<String, List<Question>> _quizzesData = {
    'hp_cap1': [
      Question(
        text: 'Qual o nome da rua onde os Dursley moravam?',
        options: [
          'Rua dos Alfeneiros',
          'Beco Diagonal',
          'Godric\'s Hollow',
          'Hogsmeade'
        ],
        correctOptionIndex: 0,
      ),
      Question(
        text:
        'Qual evento estranho NÃO aconteceu no dia em que Voldemort desapareceu?',
        options: [
          'Gatos lendo mapas',
          'Chuvas de estrelas cadentes',
          'Pessoas vestindo capas',
          'Corujas voando durante o dia'
        ],
        correctOptionIndex: 1,
      ),
    ],
    'hp_cap2': [
      Question(
        text: 'Para onde os Dursley levaram Duda no seu aniversário?',
        options: [
          'Parque de diversões',
          'Zoológico',
          'Cinema',
          'Restaurante chique'
        ],
        correctOptionIndex: 1,
      ),
    ],
    'hp_cap3': [
      Question(
          text: 'Pergunta Exemplo HP Cap 3?',
          options: ['A', 'B', 'C', 'D'],
          correctOptionIndex: 0),
    ],
    'pp_cap1': [
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
    ],
    'pp_cap2': [
      Question(
        text: 'De qual planeta o Pequeno Príncipe veio?',
        options: ['Marte', 'Asteroide B-612', 'Terra', 'Júpiter'],
        correctOptionIndex: 1,
      ),
    ],
    'pp_cap3': [
      Question(
          text: 'Pergunta Exemplo PP Cap 3?',
          options: ['A', 'B', 'C', 'D'],
          correctOptionIndex: 0),
    ],
  };

  List<Book> getBooks() {
    return _booksData;
  }

  List<Question> getQuestionsForChapter(String chapterId) {
    return _quizzesData[chapterId] ?? [];
  }
}