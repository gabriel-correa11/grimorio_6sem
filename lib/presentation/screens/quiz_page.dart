import 'package:flutter/material.dart';
import 'package:grimorio/core/services/auth_service.dart';
import 'package:grimorio/core/services/database_service.dart';
import 'package:grimorio/core/models/question.dart';
import 'package:grimorio/presentation/theme/app_colors.dart';
import 'package:grimorio/core/models/user_profile.dart';

class QuizPage extends StatefulWidget {
  final List<Question> questions;
  const QuizPage({super.key, required this.questions});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final AuthService _authService = AuthService();
  final DatabaseService _databaseService = DatabaseService();

  int _currentQuestionIndex = 0;
  int _score = 0;
  int? selectedAnswerIndex;
  bool isAnswered = false;

  void _checkAnswer(int index) {
    if (isAnswered) {
      return;
    }
    if (index == widget.questions[_currentQuestionIndex].correctOptionIndex) {
      _score++;
    }
    setState(() {
      selectedAnswerIndex = index;
      isAnswered = true;
    });
    Future.delayed(const Duration(seconds: 1), () {
      if (_currentQuestionIndex >= widget.questions.length - 1) {
        _handleQuizCompletion();
      } else {
        setState(() {
          _currentQuestionIndex++;
          selectedAnswerIndex = null;
          isAnswered = false;
        });
      }
    });
  }

  Future<void> _handleQuizCompletion() async {
    final user = _authService.getCurrentUser();
    if (user == null) {
      _showResultDialog();
      return;
    }

    final didLevelUp = await _databaseService.updateUserProgressAfterQuiz(
      user.uid,
      _score,
      widget.questions.length,
    );

    if (!mounted) {
      return;
    }
    _showResultDialog();

    if (didLevelUp) {
      final updatedProfile = await _databaseService.getUserProfile(user);
      if (updatedProfile != null) {
        _showLevelUpDialog(updatedProfile);
      }
    }
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.azulRoyal,
        title: const Text('Fim do Quiz!',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: Text(
            'Você acertou $_score de ${widget.questions.length} perguntas e ganhou ${_score * 10} XP!',
            style: const TextStyle(color: Colors.white, fontSize: 16)),
        actions: [
          TextButton(
              child: const Text('Voltar',
                  style: TextStyle(color: AppColors.azulClaro, fontSize: 18)),
              onPressed: () {
                Navigator.of(ctx).pop();
                if (Navigator.canPop(context)) {
                  Navigator.of(context).pop();
                }
              })
        ],
      ),
    );
  }

  void _showLevelUpDialog(UserProfile userProfile) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.azulRoyal,
        title: const Text('🌟 Evolução Mágica! 🌟',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold)),
        content: Text('Você ascendeu ao nível de\n${userProfile.title}!',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 20)),
        actions: [
          Center(
            child: TextButton(
              child: const Text('Continuar a Jornada',
                  style: TextStyle(color: AppColors.azulClaro, fontSize: 18)),
              onPressed: () => Navigator.of(ctx).pop(),
            ),
          )
        ],
      ),
    );
  }

  Color _getButtonColor(int index) {
    if (!isAnswered) {
      return AppColors.azulForte;
    }
    if (index == widget.questions[_currentQuestionIndex].correctOptionIndex) {
      return Colors.green;
    }
    if (index == selectedAnswerIndex) {
      return Colors.red;
    }
    return AppColors.azulForte.withAlpha(127);
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = widget.questions[_currentQuestionIndex];
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz Rápido')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                flex: 2,
                child: Center(
                    child: Text(currentQuestion.text,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold))),
              ),
              Expanded(
                flex: 3,
                child: ListView.separated(
                  itemCount: currentQuestion.options.length,
                  separatorBuilder: (context, index) =>
                  const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    return ElevatedButton(
                        onPressed: () => _checkAnswer(index),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: _getButtonColor(index),
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 16)),
                        child: Text(currentQuestion.options[index],
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 18)));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}