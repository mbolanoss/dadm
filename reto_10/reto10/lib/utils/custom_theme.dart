import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const lavender = Color(0xFFeeeeff);
const blue = Color(0xFF706993);
const red = Color(0xFFDB3A34);
const purple = Color(0xFF331e38);
const yellow = Color(0xFFFFC857);

ThemeData lightTheme = ThemeData(
  useMaterial3: true,

  colorScheme: const ColorScheme.light().copyWith(
    background: lavender,
  ),

  // Botones flotantes
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: purple,
    foregroundColor: Colors.white,
    iconSize: 30,
  ),

  // Botones
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      elevation: MaterialStateProperty.all(5),
      backgroundColor: MaterialStateProperty.all(yellow),
    ),
  ),

  // Textos
  textTheme: TextTheme(
    // Titulo
    displayLarge: GoogleFonts.nunito(
      fontWeight: FontWeight.bold,
      fontSize: 36,
    ),
    // Subtitulo
    displayMedium: GoogleFonts.nunito(
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
    // Texto normal
    displaySmall: GoogleFonts.nunito(
      fontSize: 26,
      fontWeight: FontWeight.w600,
    ),
    // Botones
    labelLarge: GoogleFonts.nunito(
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 26,
    ),
    labelSmall: GoogleFonts.nunito(
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontSize: 16,
    ),
    // Text inputs
    bodyLarge: GoogleFonts.nunito(
      fontWeight: FontWeight.bold,
      color: Colors.black,
      fontSize: 22,
    ),
  ),

  // Text inputs
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: GoogleFonts.nunito(
      color: blue,
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
    errorStyle: GoogleFonts.nunito(
      color: red,
      fontSize: 16,
    ),
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(
        width: 3,
        color: blue,
      ),
    ),
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(
        width: 3,
        color: yellow,
      ),
    ),
    errorBorder: const UnderlineInputBorder(
      borderSide: BorderSide(
        width: 3,
        color: red,
      ),
    ),
  ),
);
