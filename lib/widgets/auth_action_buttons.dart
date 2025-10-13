import 'package:flutter/material.dart';

class AuthActionButtons extends StatelessWidget {
  final bool isLogin;
  final VoidCallback onSubmit;
  final VoidCallback onResetPassword;
  final VoidCallback onToggleAuthMode;

  const AuthActionButtons({
    super.key,
    required this.isLogin,
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
              onPressed: onResetPassword,
              child: const Text('Esqueceu a senha?'),
            ),
          ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: onSubmit,
          child: Text(isLogin ? 'Login' : 'Cadastrar'),
        ),
        const SizedBox(height: 12),
        OutlinedButton(
          onPressed: onToggleAuthMode,
          child: Text(
            isLogin ? 'Não tem uma conta? Cadastre-se' : 'Já tem uma conta? Faça o login',
          ),
        ),
      ],
    );
  }
}