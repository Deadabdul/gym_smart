// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_smart/database/exercise_base.dart';
import 'package:gym_smart/pages/main_page.dart';
import 'package:gym_smart/utils/types.dart';

void main() {
  _init();
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ExerciseBase.init();
  runApp(const MainApp());
}

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
    darkTheme = darkTheme.copyWith(
      textTheme: GoogleFonts.robotoCondensedTextTheme(darkTheme.textTheme),
    );
    ThemeData lightTheme = ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: themeColor, 
          surface: Colors.white,
          onSurface: Colors.black,
          surfaceTint: Colors.transparent,
          surfaceVariant: Colors.white - 0.05,
          onSurfaceVariant: Colors.black,
          background: Colors.white,
        ),
        
    );
    lightTheme = lightTheme.copyWith(
      textTheme: GoogleFonts.robotoCondensedTextTheme(lightTheme.textTheme),
    );
    return MaterialApp(
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const MainPage(),
    );
  }
}
