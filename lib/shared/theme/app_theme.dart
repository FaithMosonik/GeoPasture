import 'package:flutter/material.dart';

class AppTheme {
  // GeoPasture brand colours from the design document
  static const Color primaryGreen     = Color(0xFF1A4D2E);
  static const Color lightGreen       = Color(0xFFD4EDDA);
  static const Color accentGreen      = Color(0xFF4CAF50);
  static const Color alertRed         = Color(0xFFD32F2F);
  static const Color warningOrange    = Color(0xFFF57C00);
  static const Color backgroundWhite  = Color(0xFFFAFAFA);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryGreen,
        primary: primaryGreen,
        secondary: accentGreen,
        background: backgroundWhite,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: primaryGreen,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
