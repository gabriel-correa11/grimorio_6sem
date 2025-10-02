import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../quiz_brain.dart';
import '../theme/app_colors.dart';
import '../widgets/answer_button.dart';
import '../widgets/question_display.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grimorio/screens/auth_gate.dart';

class QuizPage extends StatefulWidget {
  final int bookIndex;

  const QuizPage({super.key, required this.bookIndex});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final QuizBrain quizBrain = QuizBrain();
  List<Widget> scoreKeeper = [];
  int correctAnswers = 0;

  @override
  void initState() {
    super.initState();
    quizBrain.selectBook(widget.bookIndex);
  }

  void checkAnswer(bool userAnswer) {
    bool correctAnswer = quizBrain.getCorrectAnswer();
    int totalQuestions = quizBrain.getTotalQuestions();

    setState(() {
      if (quizBrain.isFinished() == true) {
        Alert(
          context: context,
          style: AlertStyle(
            backgroundColor: AppColors.azulRoyal,
            titleStyle: const TextStyle(color: Colors.white),
            descStyle: TextStyle(color: Colors.grey[300]),
          ),
          title: "Fim de Jogo!",
          desc: "Você acertou $correctAnswers de $totalQuestions perguntas.",
          buttons: [
            DialogButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              color: AppColors.azulForte,
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
          scoreKeeper.add(const Icon(Icons.check, color: AppColors.azulClaro));
        } else {
          scoreKeeper.add(Icon(Icons.close, color: Colors.white.withOpacity(0.5)));
        }
        quizBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(quizBrain.getCurrentBookTitle()),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              if (mounted) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const AuthGate()),
                        (Route<dynamic> route) => false);
              }
            },
          )
        ],
      ),
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
              buttonColor: AppColors.azulForte,
              onPressed: () {
                checkAnswer(true);
              },
            ),
            AnswerButton(
              buttonText: 'Falso',
              buttonColor: AppColors.azulRoyal,
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