import 'package:flutter/material.dart';
import 'package:grimorio/core/logic/achievement_logic.dart';
import 'package:grimorio/core/models/achievement.dart';
import 'package:grimorio/presentation/theme/app_colors.dart';

class AchievementsPage extends StatelessWidget {
  final List<String> unlockedIds;

  const AchievementsPage({super.key, required this.unlockedIds});

  @override
  Widget build(BuildContext context) {
    final allAchievements = AchievementLogic.allAchievements;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Conquistas'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: allAchievements.length,
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final achievement = allAchievements[index];
          final bool isUnlocked = unlockedIds.contains(achievement.id);
          final Color iconColor =
          isUnlocked ? Colors.amber.shade300 : Colors.grey.shade600;
          final Color textColor = isUnlocked ? Colors.white : Colors.grey.shade500;

          return ListTile(
            leading: Icon(
              IconData(int.parse(achievement.iconCodePoint),
                  fontFamily: 'MaterialIcons'),
              color: iconColor,
              size: 40,
            ),
            title: Text(
              achievement.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            subtitle: Text(
              achievement.description,
              style: TextStyle(color: textColor.withAlpha(200)),
            ),
            trailing: isUnlocked
                ? Icon(Icons.check_circle, color: Colors.green.shade400)
                : const Icon(Icons.lock, color: Colors.grey),
          );
        },
      ),
    );
  }
}