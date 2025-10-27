import 'package:flutter/material.dart';
import 'package:grimorio/presentation/theme/app_colors.dart';

class AuthActionButtons extends StatelessWidget {
  final bool isLogin;
  final bool isLoading;
  final VoidCallback onSubmit;
  final VoidCallback onResetPassword;
  final VoidCallback onToggleAuthMode;

  const AuthActionButtons({
    super.key,
    required this.isLogin,
    required this.isLoading,
    required this.onSubmit,
    required this.onResetPassword,
    required this.onToggleAuthMode,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (isLogin)
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: isLoading ? null : onResetPassword,
              style: TextButton.styleFrom(
                foregroundColor: Colors.white70, // Mudança aqui
              ),
              child: const Text('Esqueceu a senha?'),
            ),
          ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: isLoading ? null : onSubmit,
          child: isLoading
              ? const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.white,
            ),
          )
              : Text(isLogin ? 'Login' : 'Cadastrar'),
        ),
        const SizedBox(height: 12),
        OutlinedButton(
          onPressed: isLoading ? null : onToggleAuthMode,
          child: Text(
            isLogin
                ? 'Não tem uma conta? Cadastre-se'
                : 'Já tem uma conta? Faça o login',
          ),
        ),
      ],
    );
  }
}