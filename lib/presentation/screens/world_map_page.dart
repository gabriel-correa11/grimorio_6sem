import 'package:flutter/material.dart';
import 'package:grimorio/core/models/book.dart';
import 'package:grimorio/core/models/chapter.dart';
import 'package:grimorio/core/models/quiz_attempt.dart';
import 'package:grimorio/core/services/auth_service.dart';
import 'package:grimorio/core/services/database_service.dart';
import 'package:grimorio/presentation/screens/quiz_page.dart';
import 'package:grimorio/presentation/theme/app_colors.dart';
import 'package:grimorio/core/logic/quiz_brain.dart';

class WorldMapPage extends StatefulWidget {
  final Book book;

  const WorldMapPage({super.key, required this.book});

  @override
  State<WorldMapPage> createState() => _WorldMapPageState();
}

class _WorldMapPageState extends State<WorldMapPage> {
  final AuthService _authService = AuthService();
  final DatabaseService _databaseService = DatabaseService();
  final QuizBrain _quizBrain = QuizBrain();
  Map<String, QuizAttempt> _userProgress = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserProgress();
  }

  Future<void> _loadUserProgress() async {
    setState(() => _isLoading = true);
    final user = _authService.getCurrentUser();
    if (user != null) {
      _userProgress = await _databaseService.getQuizAttempts(user.uid);
    }
    _updateChapterStatus();
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  void _updateChapterStatus() {
    bool previousChapterCompleted = true;
    for (var chapter in widget.book.chapters) {
      final attempt = _userProgress[chapter.id];
      if (attempt != null) {
        chapter.status = ChapterStatus.completed;
        previousChapterCompleted = true;
      } else if (previousChapterCompleted) {
        chapter.status = ChapterStatus.available;
        previousChapterCompleted = false;
      } else {
        chapter.status = ChapterStatus.locked;
        previousChapterCompleted = false;
      }
    }
  }

  IconData _getIconForStatus(ChapterStatus status) {
    switch (status) {
      case ChapterStatus.locked:
        return Icons.lock;
      case ChapterStatus.available:
        return Icons.play_arrow_rounded;
      case ChapterStatus.completed:
        return Icons.check_circle;
    }
  }

  Color _getColorForStatus(ChapterStatus status) {
    switch (status) {
      case ChapterStatus.locked:
        return Colors.grey.shade600;
      case ChapterStatus.available:
        return AppColors.azulClaro;
      case ChapterStatus.completed:
        return Colors.green.shade400;
    }
  }

  void _navigateToQuiz(Chapter chapter) {
    final questions = _quizBrain.getQuestionsForChapter(chapter.id);
    if (questions.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QuizPage(
            questions: questions,
            bookId: chapter.id,
          ),
        ),
      ).then((_) => _loadUserProgress());
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Quiz para este capítulo ainda não disponível.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.book.title)),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
        onRefresh: _loadUserProgress,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 32.0),
          child: Column(
            children: List.generate(widget.book.chapters.length, (index) {
              final chapter = widget.book.chapters[index];
              final bool isLast = index == widget.book.chapters.length - 1;
              final bool alignLeft = index % 2 != 0;
              return _buildMapNode(chapter, alignLeft: alignLeft, isLast: isLast);
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildMapNode(Chapter chapter, {required bool alignLeft, required bool isLast}) {
    final status = chapter.status;
    final color = _getColorForStatus(status);
    final icon = _getIconForStatus(status);
    final bool isLocked = status == ChapterStatus.locked;
    const double nodeSize = 60.0;
    const double connectorHeight = 60.0;
    const double connectorWidth = 4.0;
    const double horizontalPadding = 40.0;

    Widget nodeWidget = GestureDetector(
      onTap: isLocked ? null : () => _navigateToQuiz(chapter),
      child: Container(
        width: nodeSize,
        height: nodeSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isLocked ? AppColors.azulEscuro.withAlpha(200) : AppColors.azulRoyal,
          border: Border.all(color: color, width: 3),
          boxShadow: isLocked ? null : [
            BoxShadow(
              color: color.withAlpha(100),
              blurRadius: 10,
              spreadRadius: 3,
            )
          ],
        ),
        child: Icon(icon, color: color, size: 30),
      ),
    );

    Widget titleWidget = Text(
      chapter.title,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: isLocked ? Colors.grey.shade500 : Colors.white,
      ),
      textAlign: alignLeft ? TextAlign.right : TextAlign.left,
    );

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (alignLeft) Expanded(child: titleWidget),
                if (alignLeft) const SizedBox(width: 16),

                SizedBox(
                  width: nodeSize,
                  child: Center(child: nodeWidget),
                ),

                if (!alignLeft) const SizedBox(width: 16),
                if (!alignLeft) Expanded(child: titleWidget),
              ],
            ),
          ),
        ),
        if (!isLast)
          Container(
            height: connectorHeight,
            width: connectorWidth,
            color: Colors.grey.shade700,
          ),
      ],
    );
  }
}