import 'package:flutter/material.dart';
import 'app_colors.dart';

final ThemeData appTheme = ThemeData(
    useMaterial3: true,
    primaryColor: AppColors.primaryAction,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryAction,
      background: AppColors.background,
      surface: AppColors.background,
      onPrimary: Colors.white,
      onBackground: AppColors.primaryText,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(color: AppColors.primaryText, fontSize: 20, fontWeight: FontWeight.bold),
      iconTheme: IconThemeData(color: AppColors.primaryText),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: AppColors.primaryText, fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(color: AppColors.secondaryText),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryAction,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primaryAction,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    )
);
