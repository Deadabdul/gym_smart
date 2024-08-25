
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'database.g.dart';



class Exercises extends Table {
  TextColumn get name => text()();

  @override
  Set<Column> get primaryKey => {name};

}

class MySets extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get reps => integer()();
  RealColumn get weight => real()();
  DateTimeColumn get date => dateTime().withDefault(currentDate)();
  TextColumn get exerciseName =>
      text().references(Exercises, #name, onDelete: KeyAction.cascade)();

}

class Playlists extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();

}

class PlaylistExercises extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get playlistId =>
      integer().references(Playlists, #id, onDelete: KeyAction.cascade)();
  TextColumn get exerciseName =>
      text().references(Exercises, #name, onDelete: KeyAction.cascade)();
}



@DriftDatabase(
  tables: [Exercises, MySets, Playlists, PlaylistExercises],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase._internal() : super(_openConnection());

  static final AppDatabase _singleton = AppDatabase._internal();
  static AppDatabase get instance => _singleton;

  @override
  int get schemaVersion => 5;
  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {

      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(join(dbFolder.path, 'userdata.db'));

      if (Platform.isAndroid) {
        await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
      }

      final cachebase = (await getTemporaryDirectory()).path;
      sqlite3.tempDirectory = cachebase;

      return NativeDatabase.createInBackground(file);
    });
  }
  Future<void> addPlaylist(String name) async{
    await into(playlists)
        .insert(PlaylistsCompanion.insert(name: name));
  }

  Future<void> addExerciseToPlaylist(int playlistId, String exercise) async {
    var exerciseCount = playlistExercises.id.count(filter: playlistExercises.exerciseName.equals(exercise));
    var playlistExerciseQuery = selectOnly(playlistExercises)
      ..addColumns([exerciseCount]);
    var count = await playlistExerciseQuery.map((row) => row.read(exerciseCount)).getSingle();
    if (count != null && count != 0) {
      return;
    }


    exerciseCount  = exercises.name.count(filter: exercises.name.equals(exercise));
    var exerciseQuery = selectOnly(exercises)
      ..addColumns([exerciseCount]);
    count = await exerciseQuery.map((row) => row.read(exerciseCount)).getSingle();
    if (count == null || count == 0) {
      await into(exercises).insert(ExercisesCompanion.insert(name: exercise));
    }

    await into(playlistExercises)
        .insert(PlaylistExercisesCompanion.insert(playlistId: playlistId, exerciseName: exercise));
  }

  Future<void> addSet(String exercise, int reps, double weightInLbs) async {
    await into(mySets)
        .insert(MySetsCompanion.insert(exerciseName: exercise, reps: reps, weight: weightInLbs));
  }

  Stream<List<Playlist>> getPlaylists() {
    return select(playlists).watch();
  }
  Stream<List<Exercise>> getExercisesFromPlaylist(int playlistId)  {
    return (select(exercises)
        .join([
          leftOuterJoin(playlistExercises, playlistExercises.exerciseName.equalsExp(exercises.name))
        ])
        ..where(playlistExercises.playlistId.equals(playlistId)))
    .watch().map((rows) => rows.map((row) => row.readTable(exercises)).toList());
  }
  Stream<int?> getExercisesCountFromPlaylist(int playlistId)  {
    var amountOfExerceses = exercises.name.count( filter: playlistExercises.playlistId.equals(playlistId) );
    var query = selectOnly(exercises)
        ..addColumns([amountOfExerceses]);
    return query.map((row) => row.read(amountOfExerceses)).watchSingle();
  }
  Stream<List<Exercise>> getAllExercises() {
    return select(exercises).watch();
  }
  Stream<List<MySet>> getSets(String exerciseName) {
    return (select(mySets)
        ..where((mySet) => mySet.exerciseName.equals(exerciseName)))
    .watch();
  }
  Future<void> deleteExerciseFromPlaylist(int playlistId, String exerciseName) async {
    await (delete(playlistExercises)
        ..where((tbl) => tbl.playlistId.equals(playlistId) 
        & tbl.exerciseName.equals(exerciseName)))
    .go();
  }
  Future<void> deletePlaylist(int playlistId) async {
    await (delete(playlists)
        ..where((tbl) => tbl.id.equals(playlistId)))
    .go();
  }
  Future<void> deleteSet(int setId) async {
    await (delete(mySets)
        ..where((tbl) => tbl.id.equals(setId)))
    .go();
  }
  
  Stream<double?> getExercisePersonalRecord(String exerciseName) {
    var max = mySets.weight.max(filter: mySets.exerciseName.equals(exerciseName));
    var query = selectOnly(mySets)
      ..addColumns([max]);
    return query.map((row) => row.read(max)).watchSingle();
  }

  Stream<int?> getSetCountFromExercise(String exerciseName) {
    var count = mySets.id.count(filter: mySets.exerciseName.equals(exerciseName));
    var query = selectOnly(mySets)
      ..addColumns([count]);
    return query.map((row) => row.read(count)).watchSingle();
  }
}