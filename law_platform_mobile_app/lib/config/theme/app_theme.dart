import 'package:flutter/material.dart';

class AppTheme {
  final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.indigo.shade600,
      brightness: Brightness.light,
      secondary: Colors.amberAccent.shade700,
      surface: Colors.indigo.shade50,
      inversePrimary: Colors.white,
    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        color: Colors.indigo.shade600,
        fontFamily: 'ReemKufi',
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        color: Colors.indigo.shade600,
        fontFamily: 'Lateef',
        fontSize: 20,
      ),
      //title of list tile
      titleLarge: const TextStyle(
        color: Colors.black,
        fontFamily: 'Lateef',
        fontSize: 24,
      ),
      bodyLarge: const TextStyle(
        color: Colors.black,
        fontFamily: 'Lateef',
        fontSize: 18,
      ),
      //like - dislike
      bodyMedium: const TextStyle(
        color: Colors.black,
        fontFamily: 'Lateef',
        fontSize: 16,
      ),
      // in textField label
      labelLarge: const TextStyle(
        color: Colors.grey,
        fontFamily: 'Lateef',
        fontSize: 20,
      ),
    ),
    // iconTheme: const IconThemeData(
    //   color: Colors.grey,
    // ),
  );
}
