import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  colorScheme: const ColorScheme.light(
    surface: Color.fromARGB(255, 44, 44, 44), // any surface above background
    background: Color.fromARGB(255, 26, 26, 26), // background color
    primary: Color(0xFFBB86FC), // primary buttons etc
    secondary: Color(0xFFDFC5FF), // dulled primary
    tertiary: Color(0xFF03DAC6), // secondary buttons
    onSurface: Color(0xFF787878), // On Surface title
    onBackground: Color(0xFFE3E3E3), // on Background title
    onPrimary: Color(0xFF000000), // Text on primary
    onSecondary: Color(0xFF000000), // text on secondary
    onTertiary: Color(0xFF000000), // text on tertiary
    errorContainer: Color(0xFFEC3F78), // error box / container
    onError: Color(0xFFFFFFFF), // Text on Error container
  ),
  useMaterial3: true,
);
