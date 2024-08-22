// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:gym_smart/pages/main_page.dart';
import 'package:gym_smart/utils/types.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  static Color themeColor = const Color.fromARGB(255, 90, 0, 105);
  @override
  Widget build(BuildContext context) {
    const darkSurface = Color.fromRGBO(20, 20, 20, 1);
    ThemeData darkTheme = ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark, 
          seedColor: themeColor, 
          surface: darkSurface,
          onSurface: Colors.white,
          surfaceTint: Colors.transparent,
          surfaceVariant: darkSurface + 0.1,
          onSurfaceVariant: Colors.white,
          background: darkSurface
        ),
    );
    return MaterialApp(
      theme: darkTheme,
      home: const MainPage(),
    );
  }
}
