import 'dart:ui';

Exercise exerciseFromMap(Map<String, dynamic> map) => Exercise(map['id'], map['exercise']);
List<Exercise> exercisesFromMap(List<Map<String, dynamic>> map) => map.map((e) => exerciseFromMap(e)).toList();
class Exercise {
  final int id;
  final String name;
  Exercise(this.id, this.name);
}

Playlist playlistFromMap(Map<String, dynamic> map) => Playlist(map['id'], map['name']);
List<Playlist> playlistsFromMap(List<Map<String, dynamic>> map) => map.map((e) => playlistFromMap(e)).toList();
class Playlist {
  final int? id;
  final String name;
  Playlist(this.id, this.name);
}

Set setFromMap(Map<String, dynamic> map) => Set(map['id'], map['reps'], map['weight']);
List<Set> setsFromMap(List<Map<String, dynamic>> map) => map.map((e) => setFromMap(e)).toList();
class Set {
  final int id;
  final int reps;
  final int weight;
  Set(this.id, this.reps, this.weight);
}
extension Arithmatic on Color {
  Color operator *(double t) {
    if (t > 1) t = 1;
    if (t < 0) t = 0;
    return withRed((red * t).round()).withGreen((green * t).round()).withBlue((blue * t).round());
  }
  Color operator +(double t) {
    if (t > 1) t = 1;
    if (t < 0) t = 0;
    return withRed((red + t * 255).round()).withGreen((green + t * 255).round()).withBlue((blue + t * 255).round());
  }
  Color operator -(double t) {
    if (t > 1) t = 1;
    if (t < 0) t = 0;
    return withRed((red - t * 255).round()).withGreen((green - t * 255).round()).withBlue((blue - t * 255).round());
  }
}