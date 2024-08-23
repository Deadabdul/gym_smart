
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'database.g.dart';



class Exercises extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();

}

class MySets extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get reps => integer()();
  RealColumn get weight => real()();
  DateTimeColumn get date => dateTime().withDefault(currentDate)();
  IntColumn get exerciseId =>
      integer().references(Exercises, #id, onDelete: KeyAction.cascade)();

}

class Playlists extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();

}

class PlaylistExercises extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get playlistId =>
      integer().references(Playlists, #id, onDelete: KeyAction.cascade)();
  IntColumn get exerciseId =>
      integer().references(Exercises, #id, onDelete: KeyAction.cascade)();
}



@DriftDatabase(
  tables: [Exercises, MySets, Playlists, PlaylistExercises],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase._internal() : super(_openConnection());

  static final AppDatabase _singleton = AppDatabase._internal();
  static AppDatabase get instance => _singleton;

  @override
  int get schemaVersion => 4;
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
    var exerciseCount  = exercises.name.count(filter: exercises.name.equals(exercise));
    var exerciseQuery = selectOnly(exercises)
      ..addColumns([exerciseCount]);
    var count = await exerciseQuery.map((row) => row.read(exerciseCount)).getSingle();
    
    int id;
    if (count != null && count != 0) {
      var query = select(exercises)..where((tbl) => tbl.name.equals(exercise));
      id = await query.getSingle().then((exercise) =>exercise.id);
    } else {
      id = await into(exercises).insert(ExercisesCompanion.insert(name: exercise));
    }

    exerciseCount = playlistExercises.id.count(filter: playlistExercises.exerciseId.equals(id));
    var playlistExerciseQuery = selectOnly(playlistExercises)
      ..addColumns([exerciseCount]);
    count = await playlistExerciseQuery.map((row) => row.read(exerciseCount)).getSingle();
    if (count != null && count != 0) {
      return;
    }
    await into(playlistExercises)
        .insert(PlaylistExercisesCompanion.insert(playlistId: playlistId, exerciseId: id));
  }

  Future<void> addSet(int exerciseId, int reps, double weightInLbs) async {
    await into(mySets)
        .insert(MySetsCompanion.insert(exerciseId: exerciseId, reps: reps, weight: weightInLbs));
  }

  Stream<List<Playlist>> getPlaylists() {
    return select(playlists).watch();
  }
  Stream<List<Exercise>> getExercisesFromPlaylist(int playlistId)  {
    return (select(exercises)
        .join([
          leftOuterJoin(playlistExercises, playlistExercises.exerciseId.equalsExp(exercises.id))
        ])
        ..where(playlistExercises.playlistId.equals(playlistId)))
    .watch().map((rows) => rows.map((row) => row.readTable(exercises)).toList());
  }
  Stream<int?> getExercisesCountFromPlaylist(int playlistId)  {
    var amountOfExerceses = exercises.id.count();
    var query = select(exercises)
        .join([
          leftOuterJoin(
            playlistExercises, 
            playlistExercises.exerciseId.equalsExp(exercises.id),
            useColumns: false
          )
        ])..where(playlistExercises.playlistId.equals(playlistId))
        ..addColumns([amountOfExerceses]);
    return query.map((row) => row.read(amountOfExerceses)).watchSingle();
  }
  Stream<List<Exercise>> getAllExercises() {
    return select(exercises).watch();
  }
  Stream<List<MySet>> getSets(int exerciseId) {
    return (select(mySets)
        ..where((mySet) => mySet.exerciseId.equals(exerciseId)))
    .watch();
  }
  Future<void> deleteExerciseFromPlaylist(int playlistId, int exerciseId) async {
    await (delete(playlistExercises)
        ..where((tbl) => tbl.playlistId.equals(playlistId) 
        & tbl.exerciseId.equals(exerciseId)))
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
  
  Stream<double?> getExercisePersonalRecord(int exerciseId) {
    var max = mySets.weight.max(filter: mySets.exerciseId.equals(exerciseId));
    var query = selectOnly(mySets)
      ..addColumns([max]);
    return query.map((row) => row.read(max)).watchSingle();
  }

  Stream<int?> getSetCountFromExercise(int exerciseId) {
    var count = mySets.id.count(filter: mySets.exerciseId.equals(exerciseId));
    var query = selectOnly(mySets)
      ..addColumns([count]);
    return query.map((row) => row.read(count)).watchSingle();
  }
}