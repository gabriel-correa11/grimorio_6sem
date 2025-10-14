import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:grimorio/firebase_options.dart';
import 'package:grimorio/presentation/screens/auth_gate.dart';
import 'package:grimorio/presentation/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grimorio',
      theme: appTheme,
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
    );
  }
}