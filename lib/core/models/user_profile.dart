import 'package:grimorio/core/logic/game_logic.dart';

class UserProfile {
  final String uid;
  final String name;
  final String email;
  final int xp;
  final int level;
  final int? lastQuizScore;
  final int? lastQuizTotalQuestions;

  UserProfile({
    required this.uid,
    required this.name,
    required this.email,
    required this.xp,
    required this.level,
    this.lastQuizScore,
    this.lastQuizTotalQuestions,
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
    final xpInCurrentLevel = xp - xpForCurrentLevel;
    return xpInCurrentLevel / currentLevelTotalXp;
  }

  factory UserProfile.fromMap(Map<String, dynamic> data, String documentId) {
    return UserProfile(
      uid: documentId,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      xp: data['xp'] ?? 0,
      level: data['level'] ?? 1,
      lastQuizScore: data['lastQuizScore'],
      lastQuizTotalQuestions: data['lastQuizTotalQuestions'],
    );
  }
}