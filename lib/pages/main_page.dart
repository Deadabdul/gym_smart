import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_smart/database/drift/database.dart';
import 'package:gym_smart/pages/playlist_page.dart';
import 'package:gym_smart/utils/utils.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});


  void _showAddPlaylistDialog(BuildContext context) {
    var textController = TextEditingController();
    String error = "";
    openDialog(
      context, 
      "Add Playlist",
      StatefulBuilder(
        builder: (context, setState) => Column(
          children: [
            TextField(
              controller: textController,
              decoration: const InputDecoration(
                labelText: "Playlist Name",
                border: OutlineInputBorder(),
              ),
            ),
            Text(error, style: const TextStyle(color: Colors.red),),
            TextButton(
              onPressed: () async {
                if (textController.text.isEmpty) {
                  setState(() {
                    error = "Playlist name can't be empty";
                  });
                  return;
                }
                await AppDatabase.instance.addPlaylist(textController.text);
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
  Widget _playlistTile(BuildContext context, Playlist playlist) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () => Navigator.push(context, CupertinoPageRoute(builder: (context) => PlaylistPage(playlist: playlist))),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).colorScheme.surfaceVariant
            
          ),
          height: 72,
          clipBehavior: Clip.hardEdge,
          child: Dismissible(
            direction: DismissDirection.endToStart,
            key: ValueKey(playlist.id),
            onDismissed: (direction) {
               deletePlaylist(playlist.id, context);
            },
            background: Container(
              color: Colors.red,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text("Delete", style: TextStyle(color: Colors.white),),
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        playlist.name,
                        style: const TextStyle(
                          fontSize: 24,
                          height: 1,
                        ),
                        
                        textAlign: TextAlign.left,
                      ),
                      _playlistExercisesCount(playlist),
                    ],
                  ),
                  const Icon(
                    CupertinoIcons.chevron_right,
                    size: 35,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _playlistExercisesCount(Playlist playlist) {
    return StreamBuilder<int?>(
                    stream: AppDatabase.instance.getExercisesCountFromPlaylist(playlist.id),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: snapshot.data.toString(),
                                style: const TextStyle(
                                  fontSize: 16
                                )
                              ),
                              TextSpan(
                                text: " Exercise${snapshot.data == 1 ? "" : "s"}",
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey
                                )
                              )
                            ]
                          )
                        );
                      } else {
                        return RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: "0",
                                style: TextStyle(
                                  fontSize: 20
                                )
                              ),
                              TextSpan(
                                text: " exercises",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey
                                )
                              )
                            ]
                          )
                        );
                      }
                    },
                  );
  }

  Future<void> deletePlaylist(int id, BuildContext context) async {
    await AppDatabase.instance.deletePlaylist(id);
    Flushbar(
      message: "Playlist Deleted",
      duration: const Duration(seconds: 1),
      animationDuration: const Duration(milliseconds: 200),
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
    ).show(context);
  }
  Widget _playlists(){
    return StreamBuilder<List<Playlist>>(
      stream: AppDatabase.instance.getPlaylists(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "No Playlists Just Yet",
                    style: TextStyle(
                      fontSize: 25
                    ),
                  ),
                  TextButton(
                    onPressed: () => _showAddPlaylistDialog(context),
                    child: const Text("Add Playlist")
                  ),
                ],
              ),
            );
          }
          return Column(
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text(
                    "Playlists", 
                    style: TextStyle(
                      fontSize: 33,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => _showAddPlaylistDialog(context),
                    icon: const Icon(
                      Icons.add,
                      size: 40,
                    )
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    var playlist = snapshot.data![index];
                    return _playlistTile(context, playlist);
                  },
                ),
              ),
            ],
          );
        } else {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }
      }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'GYMSMART',
          style: TextStyle(
            fontSize: 24,
            fontFamily: GoogleFonts.robotoCondensed().fontFamily,
            fontWeight: FontWeight.bold,
            color: const Color.fromRGBO(200, 200, 200, 1)
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: _playlists(),
      ),
    );
  }

  
}

