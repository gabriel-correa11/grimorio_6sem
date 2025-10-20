import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grimorio/core/logic/game_logic.dart';
import 'package:grimorio/core/models/user_profile.dart';
import 'package:grimorio/core/models/quiz_attempt.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> createUserProfile(User user, String name) async {
    final userRef = _db.collection('users').doc(user.uid);
    await userRef.set({
      'uid': user.uid,
      'name': name,
      'email': user.email,
      'xp': 0,
      'level': 1,
      'createdAt': FieldValue.serverTimestamp(),
      'unlockedAchievements': [],
    });
  }

  Future<UserProfile?> getUserProfile(User user) async {
    final userDoc = await _db.collection('users').doc(user.uid).get();
    if (userDoc.exists) {
      final int completedBooks = await getCompletedBooksCount(user.uid);
      final int chaptersAttempted = completedBooks;
      final List<String> unlockedAchievements =
      List<String>.from(userDoc.data()?['unlockedAchievements'] ?? []);

      return UserProfile.fromMap(userDoc.data()!, userDoc.id, completedBooks,
          chaptersAttempted, unlockedAchievements);
    }
    return null;
  }

  Future<bool> saveQuizCompletion(
      String userId, String chapterId, int score, int totalQuestions) async {
    final attemptRef = _db
        .collection('users')
        .doc(userId)
        .collection('quizAttempts')
        .doc(chapterId);

    final now = Timestamp.now();
    bool isFirstCompletion = false;

    final docSnapshot = await attemptRef.get();

    if (!docSnapshot.exists) {
      isFirstCompletion = true;
      final newAttempt = QuizAttempt(
        bookId: chapterId,
        score: score,
        totalQuestions: totalQuestions,
        completedAt: now,
        firstCompletion: true,
      );
      await attemptRef.set(newAttempt.toMap());
    } else {
      final existingAttempt =
      QuizAttempt.fromMap(docSnapshot.data() as Map<String, dynamic>);
      isFirstCompletion = existingAttempt.firstCompletion;
      await attemptRef.update({'completedAt': now, 'score': score});
    }
    return isFirstCompletion;
  }

  Future<bool> updateUserProgressAfterQuiz(
      String userId, int score, int totalQuestions, bool isFirstCompletion) async {
    final userRef = _db.collection('users').doc(userId);
    final xpGained = isFirstCompletion ? score * 10 : (score * 10 / 2).round();
    bool didLevelUp = false;

    try {
      await _db.runTransaction((transaction) async {
        final userDoc = await transaction.get(userRef);
        if (userDoc.exists) {
          final currentXp = userDoc.data()!['xp'] as int;
          final currentLevel = userDoc.data()!['level'] as int;
          final newXp = currentXp + xpGained;
          final newLevel = GameLogic.getLevelForXp(newXp);

          Map<String, dynamic> dataToUpdate = {
            'xp': newXp,
            'lastQuizScore': score,
            'lastQuizTotalQuestions': totalQuestions,
          };

          if (newLevel > currentLevel) {
            dataToUpdate['level'] = newLevel;
            didLevelUp = true;
          }
          transaction.update(userRef, dataToUpdate);
        }
      });
    } catch (e) {
      return false;
    }
    return didLevelUp;
  }


  Future<int> getCompletedBooksCount(String userId) async {
    try {
      final snapshot = await _db
          .collection('users')
          .doc(userId)
          .collection('quizAttempts')
          .count()
          .get();
      return snapshot.count ?? 0;
    } catch (e) {
      return 0;
    }
  }

  Future<Map<String, QuizAttempt>> getQuizAttempts(String userId) async {
    Map<String, QuizAttempt> attempts = {};
    try {
      final snapshot = await _db
          .collection('users')
          .doc(userId)
          .collection('quizAttempts')
          .get();

      for (var doc in snapshot.docs) {
        if (doc.exists && doc.data().isNotEmpty) {
          try {
            attempts[doc.id] = QuizAttempt.fromMap(doc.data());
          } catch(e) {
            // Ignorar
          }
        }
      }
    } catch (e) {
      // Ignorar
    }
    return attempts;
  }

  Future<List<String>> getUnlockedAchievementIds(String userId) async {
    try {
      final userDoc = await _db.collection('users').doc(userId).get();
      if (userDoc.exists && userDoc.data()!.containsKey('unlockedAchievements')) {
        return List<String>.from(userDoc.data()!['unlockedAchievements']);
      }
    } catch(e) {
      // Ignorar
    }
    return [];
  }

  Future<void> unlockAchievements(String userId, List<String> achievementIds) async {
    if (achievementIds.isEmpty) return;
    final userRef = _db.collection('users').doc(userId);
    try {
      await userRef.update({
        'unlockedAchievements': FieldValue.arrayUnion(achievementIds)
      });
    } catch(e) {
      // Ignorar
    }
  }
}