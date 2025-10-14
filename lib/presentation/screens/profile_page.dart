import 'package:flutter/material.dart';
import 'package:grimorio/core/services/auth_service.dart';
import 'package:grimorio/core/services/database_service.dart';
import 'package:grimorio/core/logic/game_logic.dart';
import 'package:grimorio/presentation/theme/app_colors.dart';
import 'package:grimorio/core/models/user_profile.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthService _authService = AuthService();
  final DatabaseService _databaseService = DatabaseService();
  Future<UserProfile?>? _userProfileFuture;

  @override
  void initState() {
    super.initState();
    final user = _authService.getCurrentUser();
    if (user != null) {
      _userProfileFuture = _databaseService.getUserProfile(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meu Grimório')),
      body: FutureBuilder<UserProfile?>(
        future: _userProfileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
            return const Center(
                child: Text('Não foi possível carregar o perfil.'));
          }
          final userProfile = snapshot.data!;
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildGuardianSeal(userProfile),
                  const SizedBox(height: 16),
                  Center(
                      child: Text(userProfile.name,
                          style: const TextStyle(
                              fontSize: 26, fontWeight: FontWeight.bold))),
                  const SizedBox(height: 16),
                  _buildMasteryInsignia(userProfile),
                  const SizedBox(height: 32),
                  _buildProgressSection(userProfile),
                  const SizedBox(height: 24),
                  if (userProfile.lastQuizScore != null)
                    _buildLastScoreCard(userProfile),
                  const SizedBox(height: 40),
                  _buildLogoutButton(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildGuardianSeal(UserProfile profile) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: _getBorderColorForLevel(profile.level),
            width: 3,
          ),
        ),
        child: const Icon(Icons.account_circle, size: 100),
      ),
    );
  }

  Color _getBorderColorForLevel(int level) {
    if (level >= 9) {
      return Colors.amber.shade600;
    }
    if (level >= 6) {
      return Colors.blueGrey.shade200;
    }
    return Colors.brown.shade300;
  }

  Widget _buildMasteryInsignia(UserProfile profile) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppColors.azulRoyal, AppColors.azulIntermediario],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppColors.azulClaro, width: 1),
        ),
        child: Text(
          'Nível ${profile.level} - ${profile.title}',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildProgressSection(UserProfile profile) {
    return Column(
      children: [
        Text(
          _getProgressCopy(profile),
          style: TextStyle(fontSize: 16, color: Colors.white.withAlpha(204)),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              if (profile.levelProgressPercent > 0.8)
                BoxShadow(
                  color: AppColors.azulClaro.withAlpha(127),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
            ],
          ),
          child: LinearProgressIndicator(
            value: profile.levelProgressPercent,
            minHeight: 12,
            borderRadius: BorderRadius.circular(6),
            backgroundColor: AppColors.azulEscuro,
            color: AppColors.azulClaro,
          ),
        ),
      ],
    );
  }

  String _getProgressCopy(UserProfile profile) {
    if (profile.level >= 10) {
      return 'Você alcançou o conhecimento supremo!';
    }
    if (profile.levelProgressPercent > 0.8) {
      final nextTitle = GameLogic.getTitleForLevel(profile.level + 1);
      return 'A maestria de um $nextTitle está ao seu alcance!';
    }
    return 'A sabedoria se acumula a cada página.';
  }

  Widget _buildLastScoreCard(UserProfile profile) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.azulRoyal.withAlpha(150),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.history_edu, color: AppColors.azulClaro),
          const SizedBox(width: 12),
          Text(
            'Último Desempenho: ${profile.lastQuizScore}/${profile.lastQuizTotalQuestions}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogoutButton() {
    return Center(
      child: TextButton(
        onPressed: () async {
          await _authService.signOut();
        },
        child: Text(
          'Sair da Conta',
          style: TextStyle(color: Colors.white.withAlpha(178)),
        ),
      ),
    );
  }
}