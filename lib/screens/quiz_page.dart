import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../quiz_brain.dart';
import '../widgets/answer_button.dart';
import '../widgets/question_display.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final QuizBrain quizBrain = QuizBrain();
  List<Widget> scoreKeeper = [];
  int correctAnswers = 0;
  bool isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!isInitialized) {
      final int bookIndex = ModalRoute.of(context)!.settings.arguments as int;
      quizBrain.selectBook(bookIndex);
      isInitialized = true;
    }
  }

  void checkAnswer(bool userAnswer) {
    bool correctAnswer = quizBrain.getCorrectAnswer();
    int totalQuestions = quizBrain.getTotalQuestions();

    setState(() {
      if (quizBrain.isFinished() == true) {
        Alert(
          context: context,
          title: "Fim de Jogo!",
          desc: "Você acertou $correctAnswers de $totalQuestions perguntas.",
          buttons: [
            DialogButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: const Text(
                "Voltar",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            )
          ],
        ).show();
      } else {
        if (userAnswer == correctAnswer) {
          correctAnswers++;
          scoreKeeper.add(const Icon(Icons.check, color: Colors.green));
        } else {
          scoreKeeper.add(const Icon(Icons.close, color: Colors.red));
        }
        quizBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            QuestionDisplay(
              questionText: quizBrain.getQuestionText(),
            ),
            AnswerButton(
              buttonText: 'Verdadeiro',
              buttonColor: const Color(0xFFBC9440),
              onPressed: () {
                checkAnswer(true);
              },
            ),
            AnswerButton(
              buttonText: 'Falso',
              buttonColor: const Color(0xFF800020),
              onPressed: () {
                checkAnswer(false);
              },
            ),
            SizedBox(
              height: 30.0,
              child: Row(
                children: scoreKeeper,
              ),
            )
          ],
        ),
      ),
    );
  }
}