import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../auth_service.dart';

class VerifyEmailPage extends StatefulWidget {
  const VerifyEmailPage({super.key});

  @override
  State<VerifyEmailPage> createState() => _VerifyEmailPageState();
}

class _VerifyEmailPageState extends State<VerifyEmailPage> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(
      const Duration(seconds: 3),
          (_) => _checkEmailVerified(),
    );
  }

  Future<void> _checkEmailVerified() async {
    User? user = AuthService().getCurrentUser();
    if (user != null) {
      await user.reload();
      if (user.emailVerified) {
        _timer?.cancel();
      }
    }
  }

  Future<void> _resendVerificationEmail() async {
    User? user = AuthService().getCurrentUser();
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text('Um novo e-mail de verificação foi enviado!'),
        ),
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verificação de E-mail'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.email_outlined, size: 100, color: Colors.white),
              const SizedBox(height: 30),
              const Text(
                'Verifique seu E-mail',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Text(
                'Enviamos um link de confirmação para ${AuthService().getCurrentUser()?.email}. Por favor, clique no link para ativar sua conta.',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _resendVerificationEmail,
                child: const Text('Reenviar E-mail'),
              ),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: () async {
                  await AuthService().signOut();
                },
                child: const Text('Cancelar e Voltar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}