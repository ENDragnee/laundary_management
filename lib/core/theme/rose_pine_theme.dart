import 'package:flutter/material.dart';

class RosePineTheme {
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFFAF4ED), // Base
    primaryColor: const Color(0xFFD7827E), // Rose
    colorScheme: const ColorScheme.light(
      primary: Color(0xFFB4637A), // Rose
      secondary: Color(0xFF286983), // Base
      surface: Color(0xFFFFFBF3), // Surface
      onPrimary: Color(0xFFFFFFFF),
      onSecondary: Color(0xFFFFFFFF),
      onSurfaceVariant: Color(0xFF575279), // Text
      onSurface: Color(0xFF575279), // Text
      error: Color(0xFFB4637A), // Rose
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFFFFBF3), // Surface
      foregroundColor: Color(0xFF575279), // Text
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFFB4637A), // Rose
      foregroundColor: Color(0xFFFFFFFF),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF191724), // Base
    primaryColor: const Color(0xFFEBBCBA), // Rose
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFFEB6F92), // Rose
      secondary: Color(0xFF31748F), // Base
      surface: Color(0xFF26233A), // Surface
      onPrimary: Color(0xFF191724),
      onSecondary: Color(0xFF191724), // Text
      onSurface: Color(0xFFE0DEF4), // Text
      error: Color(0xFFEB6F92), // Rose
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1F1D2E), // Surface
      foregroundColor: Color(0xFFE0DEF4), // Text
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFFEB6F92), // Rose
      foregroundColor: Color(0xFF191724),
    ),
  );
}