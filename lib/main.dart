// ignore_for_file: deprecated_member_use

import 'package:flutter/cupertino.dart';
import 'package:gym_smart/database/exercise_base.dart';
import 'package:gym_smart/main_app.dart';

void main() {
  _init();
}

Future<void> _init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ExerciseBase.init();
  runApp(const MainApp());
}
