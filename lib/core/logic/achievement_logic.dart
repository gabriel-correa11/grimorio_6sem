//import 'package:flutter/material.dart';
import 'package:grimorio/core/models/achievement.dart';
import 'package:grimorio/core/models/user_profile.dart';

class AchievementLogic {
  static const List<Achievement> allAchievements = [
    Achievement(
      id: 'first_quiz',
      name: 'Primeiro Capítulo Decifrado',
      description: 'Complete seu primeiro quiz.',
      iconCodePoint: '0xe3a8',
    ),
    Achievement(
      id: 'level_2',
      name: 'Escrivão Iniciante',
      description: 'Alcance o Nível 2.',
      iconCodePoint: '0xe1c0',
    ),
    Achievement(
      id: 'perfect_quiz',
      name: 'Mente Afiada',
      description: 'Complete um quiz com 100% de acerto.',
      iconCodePoint: '0xf05a1',
    ),
  ];

  static List<String> checkAchievements(
      UserProfile userProfile,
      int currentScore,
      int totalQuestions,
      List<String> currentlyUnlockedIds) {
    List<String> newlyUnlockedIds = [];

    if (!currentlyUnlockedIds.contains('first_quiz') &&
        userProfile.completedBooksCount >= 1) {
      newlyUnlockedIds.add('first_quiz');
    }

    if (!currentlyUnlockedIds.contains('level_2') && userProfile.level >= 2) {
      newlyUnlockedIds.add('level_2');
    }

    if (!currentlyUnlockedIds.contains('perfect_quiz') &&
        currentScore == totalQuestions) {
      newlyUnlockedIds.add('perfect_quiz');
    }

    return newlyUnlockedIds;
  }

  static Achievement? getAchievementById(String id) {
    try {
      return allAchievements.firstWhere((ach) => ach.id == id);
    } catch (e) {
      return null;
    }
  }
}