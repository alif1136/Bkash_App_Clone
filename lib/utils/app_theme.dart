import 'package:flutter/material.dart';

class AppTheme {
  static const Color bkashPink = Color(0xFFE2136E);
  static const Color bkashPinkLight = Color(0xFFF5A7C7);
  static const Color bkashPinkDark = Color(0xFFB00055);
  static const Color white = Colors.white;
  static const Color greyText = Color(0xFF666666);
  static const Color lightGrey = Color(0xFFF5F5F5);

  static ThemeData get theme => ThemeData(
    primaryColor: bkashPink,
    colorScheme: ColorScheme.fromSeed(
      seedColor: bkashPink,
      primary: bkashPink,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: bkashPink,
      foregroundColor: white,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: white,
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    ),
    scaffoldBackgroundColor: white,
    useMaterial3: true,
  );
}