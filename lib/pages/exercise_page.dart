import 'package:flutter/material.dart';
import 'package:gym_smart/database/drift/database.dart';

class ExercisePage extends StatelessWidget {
  final Exercise exercise;
  const ExercisePage({ required this.exercise, super.key});


  Widget _sets() {
    return StreamBuilder<List<MySet>>(
      stream: AppDatabase.instance.getSetsFromExercise(exercise.name),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: snapshot.data!.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => ListTile(
            title: Text(snapshot.data![index].reps.toString()),
            subtitle: Text(snapshot.data![index].weight.toString()),
          ),
        );
      }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(exercise.name),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: _sets(),
      ),
    );
  }
}