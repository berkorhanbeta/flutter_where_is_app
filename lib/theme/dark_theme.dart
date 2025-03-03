import 'package:flutter/material.dart';

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Color(0xFF36393A),
  hintColor: Colors.blueAccent,
  // Define additional dark theme properties here

  scaffoldBackgroundColor: Color(0xFF36393A),
  cardTheme: CardTheme (
    color: Color(0xFF26292A)
  ),
  appBarTheme: AppBarTheme(
    color: Color(0xFF26292A)
  )

);