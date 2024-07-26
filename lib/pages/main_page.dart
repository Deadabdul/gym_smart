import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gym_smart/database/drift/database.dart';
import 'package:gym_smart/utils/utils.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});


  void _showAddPlaylistDialog(BuildContext context) {
    var textController = TextEditingController();
    openDialog(
      context, 
      "Add Playlist",
      Column(
      children: [

          TextField(
            controller: textController,
            decoration: const InputDecoration(
              labelText: "Playlist Name",
              border: OutlineInputBorder(),
            ),
          ),

          TextButton(
            onPressed: () async {
              await AppDatabase.instance.addPlaylist(textController.text);
              Navigator.pop(context);
            },
            child: const Text("Add")
          )

        ]
      ) 
    );
  }
  Padding _playlistTile(BuildContext context, Playlist playlist) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.surfaceVariant
          
        ),
        height: 60,
        clipBehavior: Clip.hardEdge,
        child: Dismissible(
          direction: DismissDirection.endToStart,
          key: ValueKey(playlist.id),
          onDismissed: (direction) async {
            await deletePlaylist(playlist.id, context);
          },
          background: Container(
            color: Colors.red,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.delete),
              ),
            ),
          ),
          child: ListTile(
            title: Text(
              playlist.name,
              style: const TextStyle(
                fontSize: 24
              ),
            ),
            
          ),
        ),
      ),
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
                      fontSize: 20,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => _showAddPlaylistDialog(context),
                    icon: const Icon(Icons.add)
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var playlist = snapshot.data![index];
                  return _playlistTile(context, playlist);
                },
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
        title: const Text(
          'GYMSMART',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold
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

