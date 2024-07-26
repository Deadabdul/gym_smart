import 'dart:io';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
class ExerciseBase {

  static final ExerciseBase _singleton = ExerciseBase._internal();
  static ExerciseBase get instance => _singleton;

  late Database _db;

  ExerciseBase._internal();
  static Future<void> init() async {
      var dbDir = await getDatabasesPath();
      var dbPath = '$dbDir/exercises.db';
      deleteDatabase(dbPath);
      ByteData data = await rootBundle.load("assets/exercises.db");
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(dbPath).writeAsBytes(bytes);
      _singleton._db = await openDatabase(dbPath);
  }

  // Searches for exercises by name in the database.
  Future<List<DatabaseExercise>> searchExercisesByName(String name) async {
    var data = await _db.query("exercises", where: "LOWER(exercise) like LOWER(?)", whereArgs: ["%$name%"]);
    var exercises = databaseExercisesFromMap(data);
    return exercises;
  }
  Future<List<DatabaseExercise>> getAllExercises() async{
    var data = await _db.query("exercises");
    var exercises = databaseExercisesFromMap(data);
    return exercises;
  }

  Future<List<DatabaseExercise>> filterExercisesByMuscleGroup(String muscleGroup) async{
    var data = await _db.query("exercises", where: "LOWER(muscle_group) = LOWER(?)", whereArgs: [muscleGroup]);
    var exercises = databaseExercisesFromMap(data);
    return exercises;
  }
}

DatabaseExercise databaseExerciseFromMap(Map<String, dynamic> map) => DatabaseExercise(map['exercise'], map['muscle_group']);
List<DatabaseExercise> databaseExercisesFromMap(List<Map<String, dynamic>> map) => map.map((e) => databaseExerciseFromMap(e)).toList();
class DatabaseExercise {
  final String name;
  final String muscleGroup;

  DatabaseExercise(this.name, this.muscleGroup);
}