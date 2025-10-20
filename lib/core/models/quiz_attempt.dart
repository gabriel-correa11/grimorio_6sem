import 'package:cloud_firestore/cloud_firestore.dart';

class QuizAttempt {
  final String bookId;
  final int score;
  final int totalQuestions;
  final Timestamp completedAt;
  final bool firstCompletion;

  QuizAttempt({
    required this.bookId,
    required this.score,
    required this.totalQuestions,
    required this.completedAt,
    required this.firstCompletion,
  });

  Map<String, dynamic> toMap() {
    return {
      'bookId': bookId,
      'score': score,
      'totalQuestions': totalQuestions,
      'completedAt': completedAt,
      'firstCompletion': firstCompletion,
    };
  }

  factory QuizAttempt.fromMap(Map<String, dynamic> map) {
    return QuizAttempt(
      bookId: map['bookId'] ?? '',
      score: map['score'] ?? 0,
      totalQuestions: map['totalQuestions'] ?? 0,
      completedAt: map['completedAt'] ?? Timestamp.now(),
      firstCompletion: map['firstCompletion'] ?? false,
    );
  }
}