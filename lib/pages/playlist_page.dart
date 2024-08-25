import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_smart/database/drift/database.dart';
import 'package:gym_smart/pages/exercise_page.dart';
import 'package:gym_smart/search_delegates/exercise_search_delegate.dart';
import 'package:gym_smart/utils/utils.dart';

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
  void _showAddSetDialog(String exerciseName, BuildContext context) {
    var reps = TextEditingController();
    var weight = TextEditingController();
    var error = "";
    openDialog(
      context,
      "Add Set",
      StatefulBuilder(
        builder: (context, setState) => Column(
          children: [
            TextField(
              controller: reps,
              decoration: const InputDecoration(
                labelText: "Reps",
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: weight,
              decoration: const InputDecoration(
                labelText: "Weight",
                border: OutlineInputBorder(),
              ),
            ),
            Text(error, style: const TextStyle(color: Colors.red),),
            TextButton(
              onPressed: () async {
                if (reps.text.isEmpty) {
                  setState(() {
                    error = "Reps can't be empty";
                  });
                  return;
                }
                if (weight.text.isEmpty) {
                  setState(() {
                    error = "Weight can't be empty";
                  });
                  return;
                }
                await AppDatabase.instance.addSet(exerciseName, int.parse(reps.text), double.parse(weight.text));
                Navigator.pop(context);
              },
              child: const Text(
                "Add",
                style: TextStyle(
                  fontSize: 20
                ),
              )
            ),
          ]
        ),
      ) 
    );


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        leading: IconButton(
          icon: const Icon(CupertinoIcons.chevron_left),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          playlist.name,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold
          ),
        ),
        actions: const [
          IconButton(
            onPressed: null,
            icon: Icon(
              CupertinoIcons.square_pencil_fill,
              color: Colors.white,
            )
          ),
          IconButton(
            onPressed: null,
            icon: Icon(
              CupertinoIcons.share,
              color: Colors.white,
            )
          )
        ],
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addExercise(context),
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: StreamBuilder(
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
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const Divider(),
                    const SizedBox(height: 35),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Theme.of(context).colorScheme.surfaceVariant
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              exerciseTile(snapshot.data![index], context),
                              index != snapshot.data!.length - 1 ? const Divider( height: 0) : Container(),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        ),
      )
    );
  }

  Future<void> deleteExercise(String name, BuildContext context) async {
    await AppDatabase.instance.deleteExerciseFromPlaylist(playlist.id, name);
    Flushbar(
      message: "Exercise Deleted",
      duration: const Duration(seconds: 1),
      animationDuration: const Duration(milliseconds: 200),
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
    ).show(context);
  }

  Widget exerciseTile(Exercise exercise, BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => ExercisePage(exercise: exercise))
      ),
      child: Dismissible(
        direction: DismissDirection.endToStart,
        key: ValueKey(exercise.name),
        onDismissed: (direction) {
            deleteExercise(exercise.name, context);
        },
        background: Container(
          padding: const EdgeInsets.all(8.0),
          color: Colors.red,
          child: const Align(
            alignment: Alignment.centerRight,
            child: Text("Delete", style: TextStyle(color: Colors.white),),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      exercise.name,
                      style: const TextStyle(
                        fontSize: 21,
                        height: 1,
                      ),
                      
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        StreamBuilder<double?>(
                          stream: AppDatabase.instance.getExercisePersonalRecord(exercise.name),
                          builder: (context, snapshot) => RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: snapshot.data?.toStringAsFixed(1) ?? "N/A",
                                  style: const TextStyle(
                                    fontSize: 15
                                  )
                                ),
                                TextSpan(
                                  text: " PR",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).colorScheme.primaryFixedDim
                                  )
                                ),
                              ]
                            )
                          ),
                        ),
                        const SizedBox(width: 30),
                        StreamBuilder<int?>(
                          stream: AppDatabase.instance.getSetCountFromExercise(exercise.name),
                          builder: (context, snapshot) {
                            return RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: snapshot.data.toString(),
                                    style: const TextStyle(
                                      fontSize: 15
                                    )
                                  ),
                                  TextSpan(
                                    text: " Set${snapshot.data == 1 ? "" : "s"}",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey
                                    )
                                  )
                                ]
                              )
                            );
                          }
                        )
                      ],
                    )
                  ],
                ),
              ),
              const Icon(
                CupertinoIcons.chevron_right,
                size: 35,
              ),
            ],
          ),
        ),
      ),
    );
  }
}