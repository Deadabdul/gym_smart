import 'package:flutter/material.dart';
import 'package:gym_smart/database/drift/database.dart';
import 'package:gym_smart/search_delegates/exercise_search_delegate.dart';

class PlaylistPage extends StatelessWidget {
  final Playlist playlist;
  const PlaylistPage({super.key, required this.playlist});

  Future<void> _addExercise(BuildContext context) async {
    final exercise = await showSearch<String?>(
      context: context,
      delegate: ExerciseSearchDelegate(),
    );

    if (exercise == null) {
      return;
    }
    await AppDatabase.instance.addExerciseToPlaylist(playlist.id, exercise);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        title: Text(
          playlist.name,
          style: const TextStyle(
            fontSize: 27,
          ),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addExercise(context),
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: AppDatabase.instance.getExercisesFromPlaylist(playlist.id), 
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "No exercises in playlist",
                      style: TextStyle(
                        fontSize: 25
                      ),
                    ),
                    TextButton(
                      onPressed: () => _addExercise(context),
                      child: const Text("Add exercises")
                    ),
                  ],
                ),
              );
            }
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return exerciseTile(snapshot, index);
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      )
    );
  }

  ListTile exerciseTile(AsyncSnapshot<List<Exercise>> snapshot, int index) {
    return ListTile(
      title: Text(snapshot.data![index].exercise),
    );
  }
}