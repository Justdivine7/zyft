import 'package:flutter/material.dart';

// LIGHT AND DARK MODE THEMES
ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'Montserrat',
  primaryColor: Color(0xFF0175DC),
  scaffoldBackgroundColor: Color(0xFFFFFFFF),
  shadowColor: Color(0xFFD9D9D9),
  hoverColor: Color(0xFFFF0000),
  // Deep blue
  indicatorColor: Color(0xFF0175DC),
  // light blue
  canvasColor: Color(0xFF0175DA),
  highlightColor: Color(0xFF787878),
  textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.black)),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  fontFamily: 'Montserrat',
  primaryColor: Color(0xFF0175DC),
  scaffoldBackgroundColor: Color(0xFF18181A),
  shadowColor: Color(0xFFD9D9D9),
  hoverColor: Color(0xFFFF0000),
  indicatorColor: Color(0xFF0175DC),
  canvasColor: Color(0xFF0175DA),
  highlightColor: Color(0xFF787878),
  textTheme: const TextTheme(bodySmall: TextStyle(color: Colors.white)),
);
