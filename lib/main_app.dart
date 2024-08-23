// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_smart/pages/main_page.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  static Color themeColor = const Color.fromARGB(255, 90, 0, 105);
  @override
  Widget build(BuildContext context) {
    const darkSurface = Color.fromRGBO(27, 27, 27, 1);
    ThemeData darkTheme = ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark, 
          seedColor: themeColor,
          surface: darkSurface,
          onSurface: Colors.white,
          surfaceTint: Colors.transparent,
          surfaceVariant: const Color.fromRGBO(48, 48, 48, 1),
          onSurfaceVariant: Colors.white,
          background: darkSurface
        ),
        fontFamily: GoogleFonts.istokWeb().fontFamily,
    );
    return MaterialApp(
      theme: darkTheme,
      home: const MainPage(),
    );
  }
}
