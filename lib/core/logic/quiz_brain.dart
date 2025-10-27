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
          QuestionOptions(id: 'a', isCorrect: true, text: 'Rua dos Alfeneiros'),
          QuestionOptions(id: 'b', isCorrect: false, text: 'Beco Diagonal'),
          QuestionOptions(id: 'c', isCorrect: false, text: 'Godric\'s Hollow'),
          QuestionOptions(id: 'd', isCorrect: false, text: 'Hogsmeade'),
        ],
      ),
      Question(
        text:
        'Qual evento estranho NÃO aconteceu no dia em que Voldemort desapareceu?',
        options: [
          QuestionOptions(id: 'a', isCorrect: false, text: 'Gatos lendo mapas'),
          QuestionOptions(id: 'b', isCorrect: true, text: 'Chuvas de estrelas cadentes'),
          QuestionOptions(id: 'c', isCorrect: false, text: 'Pessoas vestindo capas'),
          QuestionOptions(id: 'd', isCorrect: false, text: 'Corujas voando durante o dia'),
        ],
      ),
      Question(
        text: 'Qual o nome do gato da Sra. Figg?',
        options: [
          QuestionOptions(id: 'a', isCorrect: false, text: 'Bichento'),
          QuestionOptions(id: 'b', isCorrect: false, text: 'Perebas'),
          QuestionOptions(id: 'c', isCorrect: true, text: 'Sr. Patinhas'),
          QuestionOptions(id: 'd', isCorrect: false, text: 'Norberto'),
        ],
      ),
      Question(
        text: 'Quem entregou Harry aos Dursley quando ele era bebê?',
        options: [
          QuestionOptions(id: 'a', isCorrect: false, text: 'Dumbledore'),
          QuestionOptions(id: 'b', isCorrect: true, text: 'Hagrid'),
          QuestionOptions(id: 'c', isCorrect: false, text: 'McGonagall'),
          QuestionOptions(id: 'd', isCorrect: false, text: 'Snape'),
        ],
      ),
      Question(
        text: 'Qual era a profissão de Válter Dursley?',
        options: [
          QuestionOptions(id: 'a', isCorrect: true, text: 'Diretor de uma firma de perfurações'),
          QuestionOptions(id: 'b', isCorrect: false, text: 'Vendedor de carros'),
          QuestionOptions(id: 'c', isCorrect: false, text: 'Professor'),
          QuestionOptions(id: 'd', isCorrect: false, text: 'Funcionário do banco'),
        ],
      ),
    ],
    'hp_cap2': [
      Question(
        text: 'Para onde os Dursley levaram Duda no seu aniversário?',
        options: [
          QuestionOptions(id: 'a', isCorrect: false, text: 'Parque de diversões'),
          QuestionOptions(id: 'b', isCorrect: true, text: 'Zoológico'),
          QuestionOptions(id: 'c', isCorrect: false, text: 'Cinema'),
          QuestionOptions(id: 'd', isCorrect: false, text: 'Restaurante chique'),
        ],
      ),
      Question(
        text: 'Qual animal Harry libertou acidentalmente no zoológico?',
        options: [
          QuestionOptions(id: 'a', isCorrect: false, text: 'Gorila'),
          QuestionOptions(id: 'b', isCorrect: false, text: 'Tigre'),
          QuestionOptions(id: 'c', isCorrect: true, text: 'Jiboia brasileira'),
          QuestionOptions(id: 'd', isCorrect: false, text: 'Leão'),
        ],
      ),
    ],
    'hp_cap3': [
      Question(
          text: 'Quantas cartas de Hogwarts Harry recebeu inicialmente?',
          options: [
            QuestionOptions(id: 'a', isCorrect: false, text: 'Uma'),
            QuestionOptions(id: 'b', isCorrect: true, text: 'Muitas, até invadirem a casa'),
            QuestionOptions(id: 'c', isCorrect: false, text: 'Três'),
            QuestionOptions(id: 'd', isCorrect: false, text: 'Nenhuma diretamente'),
          ]
      ),
      Question(
          text: 'Para onde os Dursley fugiram para escapar das cartas?',
          options: [
            QuestionOptions(id: 'a', isCorrect: false, text: 'Para a França'),
            QuestionOptions(id: 'b', isCorrect: false, text: 'Para a casa da Tia Guida'),
            QuestionOptions(id: 'c', isCorrect: true, text: 'Uma cabana numa ilha rochosa'),
            QuestionOptions(id: 'd', isCorrect: false, text: 'Para o Beco Diagonal'),
          ]
      ),
    ],
    'pp_cap1': [
      Question(
        text: 'Qual foi o primeiro desenho que o narrador fez quando criança?',
        options: [
          QuestionOptions(id: 'a', isCorrect: false, text: 'Um chapéu'),
          QuestionOptions(id: 'b', isCorrect: true, text: 'Uma jiboia digerindo um elefante'),
          QuestionOptions(id: 'c', isCorrect: false, text: 'Uma ovelha'),
          QuestionOptions(id: 'd', isCorrect: false, text: 'Uma caixa'),
        ],
      ),
      Question(
        text: 'O que os adultos achavam que era o desenho nº 1?',
        options: [
          QuestionOptions(id: 'a', isCorrect: true, text: 'Um chapéu'),
          QuestionOptions(id: 'b', isCorrect: false, text: 'Uma montanha'),
          QuestionOptions(id: 'c', isCorrect: false, text: 'Uma cobra'),
          QuestionOptions(id: 'd', isCorrect: false, text: 'Uma nuvem'),
        ],
      ),
    ],
    'pp_cap2': [
      Question(
        text: 'De qual planeta o Pequeno Príncipe veio?',
        options: [
          QuestionOptions(id: 'a', isCorrect: false, text: 'Marte'),
          QuestionOptions(id: 'b', isCorrect: true, text: 'Asteroide B-612'),
          QuestionOptions(id: 'c', isCorrect: false, text: 'Terra'),
          QuestionOptions(id: 'd', isCorrect: false, text: 'Júpiter'),
        ],
      ),
      Question(
        text: 'Por que o astrônomo turco não foi levado a sério na primeira vez?',
        options: [
          QuestionOptions(id: 'a', isCorrect: false, text: 'Porque ele era muito jovem'),
          QuestionOptions(id: 'b', isCorrect: true, text: 'Por causa de suas roupas'),
          QuestionOptions(id: 'c', isCorrect: false, text: 'Porque ele falava outra língua'),
          QuestionOptions(id: 'd', isCorrect: false, text: 'Porque seu telescópio era antigo'),
        ],
      ),
    ],
    'pp_cap3': [
      Question(
          text: 'O que o Pequeno Príncipe pediu ao narrador para desenhar?',
          options: [
            QuestionOptions(id: 'a', isCorrect: false, text: 'Uma flor'),
            QuestionOptions(id: 'b', isCorrect: true, text: 'Uma ovelha'),
            QuestionOptions(id: 'c', isCorrect: false, text: 'Um avião'),
            QuestionOptions(id: 'd', isCorrect: false, text: 'Um elefante'),
          ]),
      Question(
          text: 'Por que o Pequeno Príncipe rejeitou os primeiros desenhos da ovelha?',
          options: [
            QuestionOptions(id: 'a', isCorrect: false, text: 'Porque era muito grande'),
            QuestionOptions(id: 'b', isCorrect: false, text: 'Porque parecia doente ou velha'),
            QuestionOptions(id: 'c', isCorrect: true, text: 'Ambas as opções B e A (em diferentes desenhos)'),
            QuestionOptions(id: 'd', isCorrect: false, text: 'Porque tinha chifres'),
          ]),
    ],
  };

  List<Book> getBooks() {
    return _booksData;
  }

  List<Question> getQuestionsForChapter(String chapterId) {
    return _quizzesData[chapterId] ?? [];
  }
}