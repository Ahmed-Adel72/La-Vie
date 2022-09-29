import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor=Color(0xff1ABC00);
ThemeData lightMode=ThemeData(
  textTheme: TextTheme(
    bodyText1: GoogleFonts.roboto(
      fontSize: 14,
      color: const Color(0xff6F6F6F),
    ),
    bodyText2: GoogleFonts.roboto(
      fontSize: 16.0,
      color: const Color(0xff979797),
    ),
  ),
  primaryColor: const Color(0xff1ABC00),
);