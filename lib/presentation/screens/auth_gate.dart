import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:grimorio/presentation/screens/auth_page.dart';
import 'package:grimorio/presentation/screens/book_selection_page.dart';
import 'package:grimorio/presentation/screens/verify_email_page.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const AuthPage();
        }

        final user = snapshot.data!;

        if (!user.emailVerified) {
          return const VerifyEmailPage();
        }

        return const BookSelectionPage();
      },
    );
  }
}