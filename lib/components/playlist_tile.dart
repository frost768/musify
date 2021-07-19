import 'package:flutter/material.dart';

class PlaylistTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool isCreatePlaylist;
  final bool isFavoriteList;
  final Function()? onTap;
  final playlistContainer = Container(
    height: 50,
    width: 50,
    child: Icon(Icons.library_music_sharp),
  );
  final favContainer = Container(
    height: 50,
    width: 50,
    decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.blue, Colors.purple])),
    child: Icon(Icons.favorite),
  );
  final createContainer = Container(
    height: 50,
    width: 50,
    child: Icon(Icons.add),
  );
  PlaylistTile(this.title,
      {Key? key,
      this.onTap,
      this.subtitle,
      this.isCreatePlaylist = false,
      this.isFavoriteList = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: isCreatePlaylist
          ? createContainer
          : isFavoriteList
              ? favContainer
              : playlistContainer,
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: subtitle == null
          ? null
          : Text(
              subtitle!,
              style: TextStyle(fontSize: 13),
            ),
    );
  }
}
