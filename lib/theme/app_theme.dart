import 'package:flutter/material.dart';
import 'package:grimorio/theme/app_colors.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: AppColors.azulForte,
  scaffoldBackgroundColor: AppColors.azulIntermediario,
  brightness: Brightness.dark,
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: Colors.white),
    titleLarge: TextStyle(color: Colors.white),
    labelLarge: TextStyle(color: Colors.white),
    headlineSmall: TextStyle(color: Colors.white),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.azulRoyal,
    centerTitle: true,
    titleTextStyle:
    TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.azulForte,
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      side: const BorderSide(color: AppColors.azulForte),
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: Colors.white,
      textStyle: const TextStyle(fontSize: 16),
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    labelStyle: TextStyle(color: Colors.white),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white54),
    ),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
    ),
    iconColor: Colors.white,
  ),
);