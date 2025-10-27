import 'package:flutter/material.dart';
import 'package:grimorio/core/logic/achievement_logic.dart';
import 'package:grimorio/core/models/achievement.dart';
import 'package:grimorio/presentation/theme/app_colors.dart';

class AchievementsPage extends StatelessWidget {
  final List<String> unlockedIds;

  const AchievementsPage({super.key, required this.unlockedIds});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas Conquistas'),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        itemCount: AchievementLogic.allAchievements.length,
        separatorBuilder: (context, index) =>
            Divider(color: AppColors.azulRoyal.withAlpha(100), height: 1),
        itemBuilder: (context, index) {
          final Achievement achievement = AchievementLogic.allAchievements[index];
          final bool isUnlocked = unlockedIds.contains(achievement.id);

          final Color iconColor =
          isUnlocked ? Colors.amber.shade300 : Colors.blueGrey.shade700;
          final Color titleColor =
          isUnlocked ? Colors.white : Colors.grey.shade500;
          final Color subtitleColor =
          isUnlocked ? Colors.white70 : Colors.grey.shade600;
          final Widget trailingIcon = isUnlocked
              ? Icon(Icons.check_circle, color: Colors.green.shade400)
              : Icon(Icons.lock, color: Colors.grey.shade600);
          final Color tileColor =
          isUnlocked ? AppColors.azulRoyal.withAlpha(50) : Colors.transparent;

          return ListTile(
            tileColor: tileColor,
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
                color: titleColor,
              ),
            ),
            subtitle: Text(
              achievement.description,
              style: TextStyle(color: subtitleColor),
            ),
            trailing: trailingIcon,
          );
        },
      ),
    );
  }
}