import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grimorio/core/services/auth_service.dart';
import 'package:grimorio/core/services/database_service.dart';
import 'package:grimorio/presentation/theme/app_colors.dart';

class AuthController with ChangeNotifier {
  final AuthService _authService = AuthService();
  final DatabaseService _databaseService = DatabaseService();

  bool _isLogin = true;
  bool _isPasswordVisible = false;
  bool _isLoading = false;
  bool _termsAccepted = false;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();

  bool get isLogin => _isLogin;
  bool get isPasswordVisible => _isPasswordVisible;
  bool get isLoading => _isLoading;
  bool get termsAccepted => _termsAccepted;

  void toggleAuthMode() {
    _isLogin = !_isLogin;
    _termsAccepted = false;
    _clearControllers();
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void toggleTermsAccepted(bool? value) {
    _termsAccepted = value ?? false;
    notifyListeners();
  }

  Future<void> submit(BuildContext context) async {
    final isValid = formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }

    if (!_isLogin && !_termsAccepted) {
      _showFeedbackDialog(context, 'Termos e Condições',
          'Você precisa aceitar os Termos e Condições e a Política de Privacidade para criar uma conta.');
      return;
    }


    _setLoading(true);

    try {
      if (_isLogin) {
        await _authService.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
      } else {
        final userCredential =
        await _authService.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
          name: nameController.text.trim(),
        );

        if (userCredential.user != null) {
          await _databaseService.createUserProfile(
            userCredential.user!,
            nameController.text.trim(),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
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
      if (context.mounted) {
        _showFeedbackDialog(context, 'Erro de Autenticação', errorMessage);
      }
    } finally {
      _setLoading(false);
    }
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

    _setLoading(true);
    try {
      await _authService.sendPasswordResetEmail(email: email);
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
    } finally {
      _setLoading(false);
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
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        actions: <Widget>[
          TextButton(
            child:
            const Text('Ok', style: TextStyle(color: AppColors.azulClaro)),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _clearControllers() {
    formKey.currentState?.reset();
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