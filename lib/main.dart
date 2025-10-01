import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/book_selection_page.dart';
import 'screens/quiz_page.dart';
import 'screens/auth_page.dart';
import 'theme/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const GrimorioApp());
}

class GrimorioApp extends StatelessWidget {
  const GrimorioApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData appTheme = ThemeData(
      primaryColor: AppColors.azulForte,
      scaffoldBackgroundColor: AppColors.azulIntermediario,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.azulRoyal,
        centerTitle: true,
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(color: AppColors.azulEscuro, fontWeight: FontWeight.bold),
        bodyMedium: TextStyle(color: Colors.white),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.azulForte,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          textStyle: const TextStyle(fontSize: 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.azulClaro),
          foregroundColor: AppColors.azulClaro,
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          textStyle: const TextStyle(fontSize: 18),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      initialRoute: '/auth',
      routes: {
        '/auth': (context) => const AuthPage(),
        '/': (context) => const BookSelectionPage(),
        '/quiz': (context) => const QuizPage(),
      },
    );
  }
}