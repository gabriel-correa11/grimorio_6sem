import 'package:flutter/material.dart';

class AuthHeader extends StatelessWidget {
  final bool isLogin;

  const AuthHeader({super.key, required this.isLogin});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        const Text(
          'Grimório',
          style: TextStyle(
            fontSize: 48,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 20),
        Image.asset(
          'assets/images/mago_teste.png',
          height: 150,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(Icons.image_not_supported, size: 100, color: Colors.grey);
          },
        ),
        const SizedBox(height: 20),
        Text(
          isLogin ? 'Login' : 'Crie sua Conta',
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white70,
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}