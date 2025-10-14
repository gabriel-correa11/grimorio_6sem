import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grimorio/core/logic/game_logic.dart';
import 'package:grimorio/core/models/user_profile.dart';

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
      'completedBooks': [],
    });
  }

  Future<UserProfile?> getUserProfile(User user) async {
    final userDoc = await _db.collection('users').doc(user.uid).get();
    if (userDoc.exists) {
      return UserProfile.fromMap(userDoc.data()!, userDoc.id);
    }
    return null;
  }

  Future<bool> updateUserProgressAfterQuiz(
      String userId, int score, int totalQuestions) async {
    final userRef = _db.collection('users').doc(userId);
    final xpGained = score * 10;
    bool didLevelUp = false;

    try {
      final userDoc = await userRef.get();
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
        await userRef.update(dataToUpdate);
      }
    } catch (e) {
      return false;
    }
    return didLevelUp;
  }
}