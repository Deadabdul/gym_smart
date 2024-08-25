// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ExercisesTable extends Exercises
    with TableInfo<$ExercisesTable, Exercise> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExercisesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'exercises';
  @override
  VerificationContext validateIntegrity(Insertable<Exercise> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {name};
  @override
  Exercise map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Exercise(
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $ExercisesTable createAlias(String alias) {
    return $ExercisesTable(attachedDatabase, alias);
  }
}

class Exercise extends DataClass implements Insertable<Exercise> {
  final String name;
  const Exercise({required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['name'] = Variable<String>(name);
    return map;
  }

  ExercisesCompanion toCompanion(bool nullToAbsent) {
    return ExercisesCompanion(
      name: Value(name),
    );
  }

  factory Exercise.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Exercise(
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'name': serializer.toJson<String>(name),
    };
  }

  Exercise copyWith({String? name}) => Exercise(
        name: name ?? this.name,
      );
  Exercise copyWithCompanion(ExercisesCompanion data) {
    return Exercise(
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Exercise(')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => name.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is Exercise && other.name == this.name);
}

class ExercisesCompanion extends UpdateCompanion<Exercise> {
  final Value<String> name;
  final Value<int> rowid;
  const ExercisesCompanion({
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExercisesCompanion.insert({
    required String name,
    this.rowid = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Exercise> custom({
    Expression<String>? name,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (name != null) 'name': name,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExercisesCompanion copyWith({Value<String>? name, Value<int>? rowid}) {
    return ExercisesCompanion(
      name: name ?? this.name,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExercisesCompanion(')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MySetsTable extends MySets with TableInfo<$MySetsTable, MySet> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MySetsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _repsMeta = const VerificationMeta('reps');
  @override
  late final GeneratedColumn<int> reps = GeneratedColumn<int>(
      'reps', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _weightMeta = const VerificationMeta('weight');
  @override
  late final GeneratedColumn<double> weight = GeneratedColumn<double>(
      'weight', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDate);
  static const VerificationMeta _exerciseNameMeta =
      const VerificationMeta('exerciseName');
  @override
  late final GeneratedColumn<String> exerciseName = GeneratedColumn<String>(
      'exercise_name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES exercises (name) ON DELETE CASCADE'));
  @override
  List<GeneratedColumn> get $columns => [id, reps, weight, date, exerciseName];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'my_sets';
  @override
  VerificationContext validateIntegrity(Insertable<MySet> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('reps')) {
      context.handle(
          _repsMeta, reps.isAcceptableOrUnknown(data['reps']!, _repsMeta));
    } else if (isInserting) {
      context.missing(_repsMeta);
    }
    if (data.containsKey('weight')) {
      context.handle(_weightMeta,
          weight.isAcceptableOrUnknown(data['weight']!, _weightMeta));
    } else if (isInserting) {
      context.missing(_weightMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    }
    if (data.containsKey('exercise_name')) {
      context.handle(
          _exerciseNameMeta,
          exerciseName.isAcceptableOrUnknown(
              data['exercise_name']!, _exerciseNameMeta));
    } else if (isInserting) {
      context.missing(_exerciseNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MySet map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MySet(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      reps: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}reps'])!,
      weight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}weight'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      exerciseName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}exercise_name'])!,
    );
  }

  @override
  $MySetsTable createAlias(String alias) {
    return $MySetsTable(attachedDatabase, alias);
  }
}

class MySet extends DataClass implements Insertable<MySet> {
  final int id;
  final int reps;
  final double weight;
  final DateTime date;
  final String exerciseName;
  const MySet(
      {required this.id,
      required this.reps,
      required this.weight,
      required this.date,
      required this.exerciseName});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['reps'] = Variable<int>(reps);
    map['weight'] = Variable<double>(weight);
    map['date'] = Variable<DateTime>(date);
    map['exercise_name'] = Variable<String>(exerciseName);
    return map;
  }

  MySetsCompanion toCompanion(bool nullToAbsent) {
    return MySetsCompanion(
      id: Value(id),
      reps: Value(reps),
      weight: Value(weight),
      date: Value(date),
      exerciseName: Value(exerciseName),
    );
  }

  factory MySet.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MySet(
      id: serializer.fromJson<int>(json['id']),
      reps: serializer.fromJson<int>(json['reps']),
      weight: serializer.fromJson<double>(json['weight']),
      date: serializer.fromJson<DateTime>(json['date']),
      exerciseName: serializer.fromJson<String>(json['exerciseName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'reps': serializer.toJson<int>(reps),
      'weight': serializer.toJson<double>(weight),
      'date': serializer.toJson<DateTime>(date),
      'exerciseName': serializer.toJson<String>(exerciseName),
    };
  }

  MySet copyWith(
          {int? id,
          int? reps,
          double? weight,
          DateTime? date,
          String? exerciseName}) =>
      MySet(
        id: id ?? this.id,
        reps: reps ?? this.reps,
        weight: weight ?? this.weight,
        date: date ?? this.date,
        exerciseName: exerciseName ?? this.exerciseName,
      );
  MySet copyWithCompanion(MySetsCompanion data) {
    return MySet(
      id: data.id.present ? data.id.value : this.id,
      reps: data.reps.present ? data.reps.value : this.reps,
      weight: data.weight.present ? data.weight.value : this.weight,
      date: data.date.present ? data.date.value : this.date,
      exerciseName: data.exerciseName.present
          ? data.exerciseName.value
          : this.exerciseName,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MySet(')
          ..write('id: $id, ')
          ..write('reps: $reps, ')
          ..write('weight: $weight, ')
          ..write('date: $date, ')
          ..write('exerciseName: $exerciseName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, reps, weight, date, exerciseName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MySet &&
          other.id == this.id &&
          other.reps == this.reps &&
          other.weight == this.weight &&
          other.date == this.date &&
          other.exerciseName == this.exerciseName);
}

class MySetsCompanion extends UpdateCompanion<MySet> {
  final Value<int> id;
  final Value<int> reps;
  final Value<double> weight;
  final Value<DateTime> date;
  final Value<String> exerciseName;
  const MySetsCompanion({
    this.id = const Value.absent(),
    this.reps = const Value.absent(),
    this.weight = const Value.absent(),
    this.date = const Value.absent(),
    this.exerciseName = const Value.absent(),
  });
  MySetsCompanion.insert({
    this.id = const Value.absent(),
    required int reps,
    required double weight,
    this.date = const Value.absent(),
    required String exerciseName,
  })  : reps = Value(reps),
        weight = Value(weight),
        exerciseName = Value(exerciseName);
  static Insertable<MySet> custom({
    Expression<int>? id,
    Expression<int>? reps,
    Expression<double>? weight,
    Expression<DateTime>? date,
    Expression<String>? exerciseName,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (reps != null) 'reps': reps,
      if (weight != null) 'weight': weight,
      if (date != null) 'date': date,
      if (exerciseName != null) 'exercise_name': exerciseName,
    });
  }

  MySetsCompanion copyWith(
      {Value<int>? id,
      Value<int>? reps,
      Value<double>? weight,
      Value<DateTime>? date,
      Value<String>? exerciseName}) {
    return MySetsCompanion(
      id: id ?? this.id,
      reps: reps ?? this.reps,
      weight: weight ?? this.weight,
      date: date ?? this.date,
      exerciseName: exerciseName ?? this.exerciseName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (reps.present) {
      map['reps'] = Variable<int>(reps.value);
    }
    if (weight.present) {
      map['weight'] = Variable<double>(weight.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (exerciseName.present) {
      map['exercise_name'] = Variable<String>(exerciseName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MySetsCompanion(')
          ..write('id: $id, ')
          ..write('reps: $reps, ')
          ..write('weight: $weight, ')
          ..write('date: $date, ')
          ..write('exerciseName: $exerciseName')
          ..write(')'))
        .toString();
  }
}

class $PlaylistsTable extends Playlists
    with TableInfo<$PlaylistsTable, Playlist> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlaylistsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'playlists';
  @override
  VerificationContext validateIntegrity(Insertable<Playlist> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Playlist map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Playlist(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
    );
  }

  @override
  $PlaylistsTable createAlias(String alias) {
    return $PlaylistsTable(attachedDatabase, alias);
  }
}

class Playlist extends DataClass implements Insertable<Playlist> {
  final int id;
  final String name;
  const Playlist({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  PlaylistsCompanion toCompanion(bool nullToAbsent) {
    return PlaylistsCompanion(
      id: Value(id),
      name: Value(name),
    );
  }

  factory Playlist.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Playlist(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  Playlist copyWith({int? id, String? name}) => Playlist(
        id: id ?? this.id,
        name: name ?? this.name,
      );
  Playlist copyWithCompanion(PlaylistsCompanion data) {
    return Playlist(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Playlist(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Playlist && other.id == this.id && other.name == this.name);
}

class PlaylistsCompanion extends UpdateCompanion<Playlist> {
  final Value<int> id;
  final Value<String> name;
  const PlaylistsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  PlaylistsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<Playlist> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  PlaylistsCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return PlaylistsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlaylistsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $PlaylistExercisesTable extends PlaylistExercises
    with TableInfo<$PlaylistExercisesTable, PlaylistExercise> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlaylistExercisesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _playlistIdMeta =
      const VerificationMeta('playlistId');
  @override
  late final GeneratedColumn<int> playlistId = GeneratedColumn<int>(
      'playlist_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES playlists (id) ON DELETE CASCADE'));
  static const VerificationMeta _exerciseNameMeta =
      const VerificationMeta('exerciseName');
  @override
  late final GeneratedColumn<String> exerciseName = GeneratedColumn<String>(
      'exercise_name', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES exercises (name) ON DELETE CASCADE'));
  @override
  List<GeneratedColumn> get $columns => [id, playlistId, exerciseName];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'playlist_exercises';
  @override
  VerificationContext validateIntegrity(Insertable<PlaylistExercise> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('playlist_id')) {
      context.handle(
          _playlistIdMeta,
          playlistId.isAcceptableOrUnknown(
              data['playlist_id']!, _playlistIdMeta));
    } else if (isInserting) {
      context.missing(_playlistIdMeta);
    }
    if (data.containsKey('exercise_name')) {
      context.handle(
          _exerciseNameMeta,
          exerciseName.isAcceptableOrUnknown(
              data['exercise_name']!, _exerciseNameMeta));
    } else if (isInserting) {
      context.missing(_exerciseNameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlaylistExercise map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlaylistExercise(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      playlistId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}playlist_id'])!,
      exerciseName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}exercise_name'])!,
    );
  }

  @override
  $PlaylistExercisesTable createAlias(String alias) {
    return $PlaylistExercisesTable(attachedDatabase, alias);
  }
}

class PlaylistExercise extends DataClass
    implements Insertable<PlaylistExercise> {
  final int id;
  final int playlistId;
  final String exerciseName;
  const PlaylistExercise(
      {required this.id, required this.playlistId, required this.exerciseName});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['playlist_id'] = Variable<int>(playlistId);
    map['exercise_name'] = Variable<String>(exerciseName);
    return map;
  }

  PlaylistExercisesCompanion toCompanion(bool nullToAbsent) {
    return PlaylistExercisesCompanion(
      id: Value(id),
      playlistId: Value(playlistId),
      exerciseName: Value(exerciseName),
    );
  }

  factory PlaylistExercise.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlaylistExercise(
      id: serializer.fromJson<int>(json['id']),
      playlistId: serializer.fromJson<int>(json['playlistId']),
      exerciseName: serializer.fromJson<String>(json['exerciseName']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'playlistId': serializer.toJson<int>(playlistId),
      'exerciseName': serializer.toJson<String>(exerciseName),
    };
  }

  PlaylistExercise copyWith({int? id, int? playlistId, String? exerciseName}) =>
      PlaylistExercise(
        id: id ?? this.id,
        playlistId: playlistId ?? this.playlistId,
        exerciseName: exerciseName ?? this.exerciseName,
      );
  PlaylistExercise copyWithCompanion(PlaylistExercisesCompanion data) {
    return PlaylistExercise(
      id: data.id.present ? data.id.value : this.id,
      playlistId:
          data.playlistId.present ? data.playlistId.value : this.playlistId,
      exerciseName: data.exerciseName.present
          ? data.exerciseName.value
          : this.exerciseName,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlaylistExercise(')
          ..write('id: $id, ')
          ..write('playlistId: $playlistId, ')
          ..write('exerciseName: $exerciseName')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, playlistId, exerciseName);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlaylistExercise &&
          other.id == this.id &&
          other.playlistId == this.playlistId &&
          other.exerciseName == this.exerciseName);
}

class PlaylistExercisesCompanion extends UpdateCompanion<PlaylistExercise> {
  final Value<int> id;
  final Value<int> playlistId;
  final Value<String> exerciseName;
  const PlaylistExercisesCompanion({
    this.id = const Value.absent(),
    this.playlistId = const Value.absent(),
    this.exerciseName = const Value.absent(),
  });
  PlaylistExercisesCompanion.insert({
    this.id = const Value.absent(),
    required int playlistId,
    required String exerciseName,
  })  : playlistId = Value(playlistId),
        exerciseName = Value(exerciseName);
  static Insertable<PlaylistExercise> custom({
    Expression<int>? id,
    Expression<int>? playlistId,
    Expression<String>? exerciseName,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (playlistId != null) 'playlist_id': playlistId,
      if (exerciseName != null) 'exercise_name': exerciseName,
    });
  }

  PlaylistExercisesCompanion copyWith(
      {Value<int>? id, Value<int>? playlistId, Value<String>? exerciseName}) {
    return PlaylistExercisesCompanion(
      id: id ?? this.id,
      playlistId: playlistId ?? this.playlistId,
      exerciseName: exerciseName ?? this.exerciseName,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (playlistId.present) {
      map['playlist_id'] = Variable<int>(playlistId.value);
    }
    if (exerciseName.present) {
      map['exercise_name'] = Variable<String>(exerciseName.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlaylistExercisesCompanion(')
          ..write('id: $id, ')
          ..write('playlistId: $playlistId, ')
          ..write('exerciseName: $exerciseName')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ExercisesTable exercises = $ExercisesTable(this);
  late final $MySetsTable mySets = $MySetsTable(this);
  late final $PlaylistsTable playlists = $PlaylistsTable(this);
  late final $PlaylistExercisesTable playlistExercises =
      $PlaylistExercisesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [exercises, mySets, playlists, playlistExercises];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('exercises',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('my_sets', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('playlists',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('playlist_exercises', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('exercises',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('playlist_exercises', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$ExercisesTableCreateCompanionBuilder = ExercisesCompanion Function({
  required String name,
  Value<int> rowid,
});
typedef $$ExercisesTableUpdateCompanionBuilder = ExercisesCompanion Function({
  Value<String> name,
  Value<int> rowid,
});

class $$ExercisesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ExercisesTable,
    Exercise,
    $$ExercisesTableFilterComposer,
    $$ExercisesTableOrderingComposer,
    $$ExercisesTableCreateCompanionBuilder,
    $$ExercisesTableUpdateCompanionBuilder> {
  $$ExercisesTableTableManager(_$AppDatabase db, $ExercisesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$ExercisesTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$ExercisesTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<String> name = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ExercisesCompanion(
            name: name,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String name,
            Value<int> rowid = const Value.absent(),
          }) =>
              ExercisesCompanion.insert(
            name: name,
            rowid: rowid,
          ),
        ));
}

class $$ExercisesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableFilterComposer(super.$state);
  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter mySetsRefs(
      ComposableFilter Function($$MySetsTableFilterComposer f) f) {
    final $$MySetsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.name,
        referencedTable: $state.db.mySets,
        getReferencedColumn: (t) => t.exerciseName,
        builder: (joinBuilder, parentComposers) => $$MySetsTableFilterComposer(
            ComposerState(
                $state.db, $state.db.mySets, joinBuilder, parentComposers)));
    return f(composer);
  }

  ComposableFilter playlistExercisesRefs(
      ComposableFilter Function($$PlaylistExercisesTableFilterComposer f) f) {
    final $$PlaylistExercisesTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.name,
            referencedTable: $state.db.playlistExercises,
            getReferencedColumn: (t) => t.exerciseName,
            builder: (joinBuilder, parentComposers) =>
                $$PlaylistExercisesTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.playlistExercises,
                    joinBuilder,
                    parentComposers)));
    return f(composer);
  }
}

class $$ExercisesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $ExercisesTable> {
  $$ExercisesTableOrderingComposer(super.$state);
  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$MySetsTableCreateCompanionBuilder = MySetsCompanion Function({
  Value<int> id,
  required int reps,
  required double weight,
  Value<DateTime> date,
  required String exerciseName,
});
typedef $$MySetsTableUpdateCompanionBuilder = MySetsCompanion Function({
  Value<int> id,
  Value<int> reps,
  Value<double> weight,
  Value<DateTime> date,
  Value<String> exerciseName,
});

class $$MySetsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $MySetsTable,
    MySet,
    $$MySetsTableFilterComposer,
    $$MySetsTableOrderingComposer,
    $$MySetsTableCreateCompanionBuilder,
    $$MySetsTableUpdateCompanionBuilder> {
  $$MySetsTableTableManager(_$AppDatabase db, $MySetsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$MySetsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$MySetsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> reps = const Value.absent(),
            Value<double> weight = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<String> exerciseName = const Value.absent(),
          }) =>
              MySetsCompanion(
            id: id,
            reps: reps,
            weight: weight,
            date: date,
            exerciseName: exerciseName,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int reps,
            required double weight,
            Value<DateTime> date = const Value.absent(),
            required String exerciseName,
          }) =>
              MySetsCompanion.insert(
            id: id,
            reps: reps,
            weight: weight,
            date: date,
            exerciseName: exerciseName,
          ),
        ));
}

class $$MySetsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $MySetsTable> {
  $$MySetsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get reps => $state.composableBuilder(
      column: $state.table.reps,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<double> get weight => $state.composableBuilder(
      column: $state.table.weight,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$ExercisesTableFilterComposer get exerciseName {
    final $$ExercisesTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.exerciseName,
        referencedTable: $state.db.exercises,
        getReferencedColumn: (t) => t.name,
        builder: (joinBuilder, parentComposers) =>
            $$ExercisesTableFilterComposer(ComposerState(
                $state.db, $state.db.exercises, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$MySetsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $MySetsTable> {
  $$MySetsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get reps => $state.composableBuilder(
      column: $state.table.reps,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<double> get weight => $state.composableBuilder(
      column: $state.table.weight,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<DateTime> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$ExercisesTableOrderingComposer get exerciseName {
    final $$ExercisesTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.exerciseName,
        referencedTable: $state.db.exercises,
        getReferencedColumn: (t) => t.name,
        builder: (joinBuilder, parentComposers) =>
            $$ExercisesTableOrderingComposer(ComposerState(
                $state.db, $state.db.exercises, joinBuilder, parentComposers)));
    return composer;
  }
}

typedef $$PlaylistsTableCreateCompanionBuilder = PlaylistsCompanion Function({
  Value<int> id,
  required String name,
});
typedef $$PlaylistsTableUpdateCompanionBuilder = PlaylistsCompanion Function({
  Value<int> id,
  Value<String> name,
});

class $$PlaylistsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PlaylistsTable,
    Playlist,
    $$PlaylistsTableFilterComposer,
    $$PlaylistsTableOrderingComposer,
    $$PlaylistsTableCreateCompanionBuilder,
    $$PlaylistsTableUpdateCompanionBuilder> {
  $$PlaylistsTableTableManager(_$AppDatabase db, $PlaylistsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$PlaylistsTableFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $$PlaylistsTableOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
          }) =>
              PlaylistsCompanion(
            id: id,
            name: name,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
          }) =>
              PlaylistsCompanion.insert(
            id: id,
            name: name,
          ),
        ));
}

class $$PlaylistsTableFilterComposer
    extends FilterComposer<_$AppDatabase, $PlaylistsTable> {
  $$PlaylistsTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ComposableFilter playlistExercisesRefs(
      ComposableFilter Function($$PlaylistExercisesTableFilterComposer f) f) {
    final $$PlaylistExercisesTableFilterComposer composer =
        $state.composerBuilder(
            composer: this,
            getCurrentColumn: (t) => t.id,
            referencedTable: $state.db.playlistExercises,
            getReferencedColumn: (t) => t.playlistId,
            builder: (joinBuilder, parentComposers) =>
                $$PlaylistExercisesTableFilterComposer(ComposerState(
                    $state.db,
                    $state.db.playlistExercises,
                    joinBuilder,
                    parentComposers)));
    return f(composer);
  }
}

class $$PlaylistsTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $PlaylistsTable> {
  $$PlaylistsTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get name => $state.composableBuilder(
      column: $state.table.name,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

typedef $$PlaylistExercisesTableCreateCompanionBuilder
    = PlaylistExercisesCompanion Function({
  Value<int> id,
  required int playlistId,
  required String exerciseName,
});
typedef $$PlaylistExercisesTableUpdateCompanionBuilder
    = PlaylistExercisesCompanion Function({
  Value<int> id,
  Value<int> playlistId,
  Value<String> exerciseName,
});

class $$PlaylistExercisesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $PlaylistExercisesTable,
    PlaylistExercise,
    $$PlaylistExercisesTableFilterComposer,
    $$PlaylistExercisesTableOrderingComposer,
    $$PlaylistExercisesTableCreateCompanionBuilder,
    $$PlaylistExercisesTableUpdateCompanionBuilder> {
  $$PlaylistExercisesTableTableManager(
      _$AppDatabase db, $PlaylistExercisesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $$PlaylistExercisesTableFilterComposer(ComposerState(db, table)),
          orderingComposer: $$PlaylistExercisesTableOrderingComposer(
              ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> playlistId = const Value.absent(),
            Value<String> exerciseName = const Value.absent(),
          }) =>
              PlaylistExercisesCompanion(
            id: id,
            playlistId: playlistId,
            exerciseName: exerciseName,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int playlistId,
            required String exerciseName,
          }) =>
              PlaylistExercisesCompanion.insert(
            id: id,
            playlistId: playlistId,
            exerciseName: exerciseName,
          ),
        ));
}

class $$PlaylistExercisesTableFilterComposer
    extends FilterComposer<_$AppDatabase, $PlaylistExercisesTable> {
  $$PlaylistExercisesTableFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  $$PlaylistsTableFilterComposer get playlistId {
    final $$PlaylistsTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.playlistId,
        referencedTable: $state.db.playlists,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$PlaylistsTableFilterComposer(ComposerState(
                $state.db, $state.db.playlists, joinBuilder, parentComposers)));
    return composer;
  }

  $$ExercisesTableFilterComposer get exerciseName {
    final $$ExercisesTableFilterComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.exerciseName,
        referencedTable: $state.db.exercises,
        getReferencedColumn: (t) => t.name,
        builder: (joinBuilder, parentComposers) =>
            $$ExercisesTableFilterComposer(ComposerState(
                $state.db, $state.db.exercises, joinBuilder, parentComposers)));
    return composer;
  }
}

class $$PlaylistExercisesTableOrderingComposer
    extends OrderingComposer<_$AppDatabase, $PlaylistExercisesTable> {
  $$PlaylistExercisesTableOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  $$PlaylistsTableOrderingComposer get playlistId {
    final $$PlaylistsTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.playlistId,
        referencedTable: $state.db.playlists,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder, parentComposers) =>
            $$PlaylistsTableOrderingComposer(ComposerState(
                $state.db, $state.db.playlists, joinBuilder, parentComposers)));
    return composer;
  }

  $$ExercisesTableOrderingComposer get exerciseName {
    final $$ExercisesTableOrderingComposer composer = $state.composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.exerciseName,
        referencedTable: $state.db.exercises,
        getReferencedColumn: (t) => t.name,
        builder: (joinBuilder, parentComposers) =>
            $$ExercisesTableOrderingComposer(ComposerState(
                $state.db, $state.db.exercises, joinBuilder, parentComposers)));
    return composer;
  }
}

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ExercisesTableTableManager get exercises =>
      $$ExercisesTableTableManager(_db, _db.exercises);
  $$MySetsTableTableManager get mySets =>
      $$MySetsTableTableManager(_db, _db.mySets);
  $$PlaylistsTableTableManager get playlists =>
      $$PlaylistsTableTableManager(_db, _db.playlists);
  $$PlaylistExercisesTableTableManager get playlistExercises =>
      $$PlaylistExercisesTableTableManager(_db, _db.playlistExercises);
}
