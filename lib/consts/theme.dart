import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles {
  static ThemeData themedata(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      scaffoldBackgroundColor: isDarkTheme
          ? const Color.fromARGB(255, 8, 8, 19)
          : const Color.fromARGB(255, 220, 220, 230),
      primaryColor: const Color(0xFF67c766),
      // secondaryHeaderColor: const Color.fromARGB(255, 195, 205, 85),
      // secondaryHeaderColor: const Color.fromARGB(255, 218, 213, 201),
      secondaryHeaderColor: const Color(0xFFFe9900),
      colorScheme: ThemeData().colorScheme.copyWith(
          secondary: isDarkTheme
              ? const Color.fromARGB(255, 8, 8, 19)
              : const Color.fromARGB(255, 220, 220, 230),
          brightness: isDarkTheme ? Brightness.dark : Brightness.light),
      cardColor: isDarkTheme
          ? const Color.fromARGB(255, 8, 8, 19)
          : const Color.fromARGB(255, 220, 220, 230),
      canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme
              ? const ColorScheme.dark()
              : const ColorScheme.light()),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.lato(
            textStyle:
                TextStyle(color: isDarkTheme ? Colors.white : Colors.black)),
        displayMedium: GoogleFonts.lato(
            textStyle:
                TextStyle(color: isDarkTheme ? Colors.white : Colors.black)),
        displaySmall: GoogleFonts.lato(
            textStyle:
                TextStyle(color: isDarkTheme ? Colors.white : Colors.black)),
        headlineLarge: GoogleFonts.lato(
            textStyle:
                TextStyle(color: isDarkTheme ? Colors.white : Colors.black)),
        headlineMedium: GoogleFonts.lato(
            textStyle:
                TextStyle(color: isDarkTheme ? Colors.white : Colors.black)),
        headlineSmall: GoogleFonts.lato(
            textStyle:
                TextStyle(color: isDarkTheme ? Colors.white : Colors.black)),
        titleLarge: GoogleFonts.lato(
            textStyle:
                TextStyle(color: isDarkTheme ? Colors.white : Colors.black)),
        titleMedium: GoogleFonts.lato(
            textStyle:
                TextStyle(color: isDarkTheme ? Colors.white : Colors.black)),
        titleSmall: GoogleFonts.lato(
            textStyle:
                TextStyle(color: isDarkTheme ? Colors.white : Colors.black)),
        bodyLarge: GoogleFonts.lato(
            textStyle:
                TextStyle(color: isDarkTheme ? Colors.white : Colors.black)),
        bodyMedium: GoogleFonts.lato(
            textStyle:
                TextStyle(color: isDarkTheme ? Colors.white : Colors.black)),
        bodySmall: GoogleFonts.lato(
            textStyle:
                TextStyle(color: isDarkTheme ? Colors.white : Colors.black)),
        labelLarge: GoogleFonts.lato(
            textStyle:
                TextStyle(color: isDarkTheme ? Colors.white : Colors.black)),
        labelMedium: GoogleFonts.lato(
            textStyle:
                TextStyle(color: isDarkTheme ? Colors.white : Colors.black)),
        labelSmall: GoogleFonts.lato(
            textStyle:
                TextStyle(color: isDarkTheme ? Colors.white : Colors.black)),
      ),
    );
  }
}
