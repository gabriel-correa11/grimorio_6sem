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
              child: const Text('Esqueceu a senha?', style: TextStyle(color: Colors.white)),
            ),
          ),
        const SizedBox(height: 20.0),
        ElevatedButton(
          onPressed: onSubmit,
          child: Text(isLogin ? 'Login' : 'Criar Conta'),
        ),
        const SizedBox(height: 20.0),
        OutlinedButton(
          style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.white)),
          onPressed: onToggleAuthMode,
          child: Text(
            isLogin ? 'Não tem uma conta? Cadastre-se' : 'Já tem uma conta? Faça o login',
            style: const TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}
