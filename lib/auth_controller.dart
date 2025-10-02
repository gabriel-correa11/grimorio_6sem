import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_service.dart';

class AuthController extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool _isLogin = true;
  bool _isPasswordVisible = false;

  bool get isLogin => _isLogin;
  bool get isPasswordVisible => _isPasswordVisible;

  void toggleAuthMode() {
    _isLogin = !_isLogin;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Ocorreu um Erro'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('Ok'),
            onPressed: () => Navigator.of(ctx).pop(),
          )
        ],
      ),
    );
  }

  Future<void> submit(BuildContext context) async {
    if (_isLogin) {
      await _signIn(context);
    } else {
      await _signUp(context);
    }
  }

  Future<void> _signIn(BuildContext context) async {
    try {
      await _authService.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      _handleAuthError(context, e);
    }
  }

  Future<void> _signUp(BuildContext context) async {
    if (passwordController.text != confirmPasswordController.text) {
      _showErrorDialog(context, 'As senhas não correspondem.');
      return;
    }
    try {
      await _authService.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
        name: nameController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      _handleAuthError(context, e);
    }
  }

  Future<void> resetPassword(BuildContext context) async {
    if (emailController.text.trim().isEmpty) {
      _showErrorDialog(context, 'Por favor, digite seu e-mail para redefinir a senha.');
      return;
    }
    try {
      await _authService.sendPasswordResetEmail(email: emailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('E-mail de redefinição de senha enviado!')),
      );
    } on FirebaseAuthException catch (e) {
      _handleAuthError(context, e);
    }
  }

  void _handleAuthError(BuildContext context, FirebaseAuthException e) {
    String errorMessage = 'Ocorreu um erro desconhecido.';
    if (e.code == 'weak-password') {
      errorMessage = 'A senha fornecida é muito fraca.';
    } else if (e.code == 'email-already-in-use') {
      errorMessage = 'Este e-mail já está em uso.';
    } else if (e.code == 'invalid-email') {
      errorMessage = 'O endereço de e-mail não é válido.';
    } else if (e.code == 'invalid-credential') {
      errorMessage = 'Credenciais inválidas. Verifique seu e-mail e senha.';
    }
    _showErrorDialog(context, errorMessage);
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

