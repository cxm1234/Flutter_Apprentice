import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FooderlichTheme {
  static TextTheme lightTextTheme = TextTheme(
    bodySmall: GoogleFonts.openSans(fontSize: 14.0, fontWeight: FontWeight.w700, color: Colors.black),
    headlineSmall: GoogleFonts.openSans(fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.black),
    headlineMedium: GoogleFonts.openSans(fontSize: 21.0, fontWeight: FontWeight.w700, color: Colors.black),
    headlineLarge: GoogleFonts.openSans(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black),
    titleLarge: GoogleFonts.openSans(fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.black)
  );

  static TextTheme darkTextTheme = TextTheme(
    bodyLarge: GoogleFonts.openSans(fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.white),
    displayLarge: GoogleFonts.openSans(fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.white),
    displayMedium: GoogleFonts.openSans(fontSize: 21.0, fontWeight: FontWeight.w700, color: Colors.white),
    displaySmall: GoogleFonts.openSans(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.white),
    titleLarge: GoogleFonts.openSans(fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.white)
  );

  static ThemeData light() {
    final ThemeData theme = ThemeData(
      brightness: Brightness.light,
      primaryColor: Colors.white,
      textSelectionTheme: const TextSelectionThemeData(selectionColor: Colors.green),
      textTheme: lightTextTheme
    );
    return theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(secondary: Colors.black)
    );
  }

  static ThemeData dark() {
    final ThemeData theme = ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.grey[900],
      textTheme: darkTextTheme
    );
    return theme.copyWith(colorScheme: theme.colorScheme.copyWith(secondary: Colors.green[600]));
  }
}