import 'package:grimorio/core/logic/game_logic.dart';

class UserProfile {
  final String uid;
  final String name;
  final String email;
  final int xp;
  final int level;
  final int? lastQuizScore;
  final int? lastQuizTotalQuestions;
  final int completedBooksCount;
  final int chaptersAttemptedCount;
  final List<String> unlockedAchievementIds;

  UserProfile({
    required this.uid,
    required this.name,
    required this.email,
    required this.xp,
    required this.level,
    this.lastQuizScore,
    this.lastQuizTotalQuestions,
    required this.completedBooksCount,
    required this.chaptersAttemptedCount,
    required this.unlockedAchievementIds,
  });

  String get title => GameLogic.getTitleForLevel(level);

  int get xpForCurrentLevel {
    if (level <= 1) {
      return 0;
    }
    return GameLogic.xpPerLevel[level - 1]!;
  }

  int get xpForNextLevel {
    return GameLogic.xpPerLevel[level] ?? xp;
  }

  double get levelProgressPercent {
    if (level >= 10) return 1.0;
    final currentLevelTotalXp = xpForNextLevel - xpForCurrentLevel;
    if (currentLevelTotalXp <= 0) return 0.0;
    final xpInCurrentLevel = xp - xpForCurrentLevel;
    return (xpInCurrentLevel / currentLevelTotalXp).clamp(0.0, 1.0);
  }

  factory UserProfile.fromMap(
      Map<String, dynamic> data,
      String documentId,
      int completedBooks,
      int chaptersAttempted,
      List<String> unlockedAchievements) {
    return UserProfile(
      uid: documentId,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      xp: data['xp'] ?? 0,
      level: data['level'] ?? 1,
      lastQuizScore: data['lastQuizScore'],
      lastQuizTotalQuestions: data['lastQuizTotalQuestions'],
      completedBooksCount: completedBooks,
      chaptersAttemptedCount: chaptersAttempted,
      unlockedAchievementIds: unlockedAchievements,
    );
  }
}