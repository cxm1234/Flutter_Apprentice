import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FooderlichTheme {
  static TextTheme lightTextTheme = TextTheme(
    bodyText1: GoogleFonts.openSans(fontSize: 14.0, fontWeight: FontWeight.w700, color: Colors.black),
    headline1: GoogleFonts.openSans(fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.black),
    headline2: GoogleFonts.openSans(fontSize: 21.0, fontWeight: FontWeight.w700, color: Colors.black),
    headline3: GoogleFonts.openSans(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black),
    headline6: GoogleFonts.openSans(fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.black)
  );

  static TextTheme darkTextTheme = TextTheme(
    bodyText1: GoogleFonts.openSans(fontSize: 14.0, fontWeight: FontWeight.w600, color: Colors.white),
    headline1: GoogleFonts.openSans(fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.white),
    headline2: GoogleFonts.openSans(fontSize: 21.0, fontWeight: FontWeight.w700, color: Colors.white),
    headline3: GoogleFonts.openSans(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.white),
    headline6: GoogleFonts.openSans(fontSize: 20.0, fontWeight: FontWeight.w600, color: Colors.white)
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