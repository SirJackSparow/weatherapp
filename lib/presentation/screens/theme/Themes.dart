import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes {
  static var kColorScheme =
  ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 96, 59, 181));

  static var kColorDarkScheme = ColorScheme.fromSeed(
      brightness: Brightness.dark,
      seedColor: const Color.fromARGB(255, 5, 99, 125));

  static final theme = ThemeData().copyWith(
    scaffoldBackgroundColor: const Color.fromARGB(255, 22, 151, 221),
    colorScheme: kColorScheme,
    appBarTheme: const AppBarTheme().copyWith(
        backgroundColor: kColorScheme.onPrimaryContainer,
        foregroundColor: kColorScheme.primaryContainer,
        centerTitle: true),
    cardTheme: const CardTheme().copyWith(
        color: kColorScheme.secondaryContainer,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8)),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer)),
    textTheme: GoogleFonts.latoTextTheme(),
  );

  static final darkTheme = ThemeData().copyWith(
    scaffoldBackgroundColor: const Color.fromARGB(255, 43, 42, 42),
    colorScheme: kColorDarkScheme,
    cardTheme: const CardTheme().copyWith(
      color: kColorDarkScheme.secondaryContainer,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: kColorDarkScheme.primaryContainer,
          foregroundColor: kColorDarkScheme.onPrimaryContainer,
        )),
  );
}