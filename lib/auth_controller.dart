import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grimorio/theme/app_colors.dart';

class AuthController with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool _isLogin = true;
  bool _isPasswordVisible = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool get isLogin => _isLogin;
  bool get isPasswordVisible => _isPasswordVisible;

  void toggleAuthMode() {
    _isLogin = !_isLogin;
    _clearControllers();
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  Future<void> submit(BuildContext context) async {
    // Lógica de submit (login/cadastro) continua aqui
  }

  Future<void> resetPassword(BuildContext context) async {
    final email = emailController.text.trim();
    if (email.isEmpty) {
      _showFeedbackDialog(
        context,
        'Atenção',
        'Por favor, digite seu e-mail no campo correspondente para redefinir a senha.',
      );
      return;
    }

    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);

      if (!context.mounted) return;

      _showFeedbackDialog(
        context,
        'Sucesso',
        'E-mail de redefinição de senha enviado! Verifique sua caixa de entrada.',
      );
    } on FirebaseAuthException catch (_) {
      if (!context.mounted) return;

      _showFeedbackDialog(
        context,
        'Ocorreu um Erro',
        'Não foi possível enviar o e-mail. Verifique se o endereço está correto e tente novamente.',
      );
    }
  }

  void _showFeedbackDialog(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.azulRoyal,
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        content: Text(
          content,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Ok', style: TextStyle(color: AppColors.azulClaro)),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  void _clearControllers() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}