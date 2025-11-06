import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryBackground = Color(0xFF000000);
  static const Color cardBackground = Color(0xFF222222);
  static const Color primaryAccent = Color(0xFF1DCD9F);
  static const Color secondaryAccent = Color(0xFF169976);

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: primaryBackground,
      primaryColor: primaryAccent,
      colorScheme: const ColorScheme.dark(
        primary: primaryAccent,
        secondary: secondaryAccent,
        surface: cardBackground,
        background: primaryBackground,
      ),
      cardTheme: CardThemeData(
        color: cardBackground,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryAccent,
          foregroundColor: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: secondaryAccent,
          side: const BorderSide(color: secondaryAccent, width: 2),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: cardBackground,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: primaryAccent, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryBackground,
        elevation: 0,
        centerTitle: true,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: primaryAccent,
      ),
    );
  }
}
