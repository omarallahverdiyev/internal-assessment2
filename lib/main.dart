import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:internal_assessment_app/auth/presentation/auth_screen.dart';
import 'package:internal_assessment_app/firebase_options.dart';

var kColorScheme =
    ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 191, 32, 32));

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    theme: ThemeData().copyWith(
      colorScheme: kColorScheme,
      appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer),
      cardTheme: const CardTheme().copyWith(
        color: kColorScheme.secondaryContainer,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kColorScheme.primaryContainer,
        ),
      ),
      textTheme: ThemeData().textTheme.copyWith(
        titleLarge: TextStyle(
          fontWeight: FontWeight.bold,
          color: kColorScheme.onSecondaryContainer,
          fontSize: 14
        ),
      ),
    ),
    home: const AuthScreen(),
  ));
}
