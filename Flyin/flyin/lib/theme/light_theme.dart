import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: const ColorScheme.light(
    surface: Color.fromARGB(255, 243, 236, 252), // any surface above background
    background: Color.fromARGB(255, 246, 246, 246), // background color
    primary: Color(0xFFBB86FC), // primary buttons etc
    secondary: Color(0xFFDFC5FF), // dulled primary
    tertiary: Color(0xFF03DAC6), // secondary buttons
    onSurface: Color(0xFF6D6D6D), // On Surface title
    onBackground: Color(0xFF2D2D2D), // on Background title
    onPrimary: Color(0xFF000000), // Text on primary
    onSecondary: Color(0xFF000000), // text on secondary
    onTertiary: Color(0xFF000000), // text on tertiary
    errorContainer: Color(0xFFEC3F78), // error box / container
    onError: Color(0xFFFFFFFF), // Text on Error container
  ),
  useMaterial3: true,
  bottomNavigationBarTheme:
      const BottomNavigationBarThemeData(selectedItemColor: Colors.white),
);
