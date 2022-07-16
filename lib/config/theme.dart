import 'package:flutter/material.dart';
import 'package:flutter_assignment/config/colors.dart';

class ThemeClass {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.lightGray,
    appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
    cardColor: Colors.white,
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark(),
  );
}
