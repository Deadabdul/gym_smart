import 'package:flutter/material.dart';
import 'package:gym_smart/database/exercise_base.dart';

class ExerciseSearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context){
    return FutureBuilder<List<DatabaseExercise>>(
      future:  ExerciseBase.instance.searchExercisesByName(query), 
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return exerciseTile(snapshot.data![index]);
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }
    );

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<DatabaseExercise>>(
      future: ExerciseBase.instance.searchExercisesByName(query), 
      builder: (context,snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return exerciseTile(snapshot.data![index]);
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }
    );
  }

  ListTile exerciseTile(DatabaseExercise exercise,) {
    return ListTile(
      title: Text(exercise.name),
      subtitle: Text(exercise.muscleGroup),
    );
  }
}