import 'package:flutter/material.dart';

class PlaylistTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool isAdd;
  final bool isFavoriteList;
  final bool isPinned;
  final Function()? onTap;
  final playlistContainer = Container(
    height: 60,
    width: 60,
    child: Icon(Icons.library_music_sharp),
  );
  final favContainer = Container(
    height: 60,
    width: 60,
    decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Colors.blue, Colors.purple])),
    child: Icon(Icons.favorite),
  );
  final createContainer = Container(
    height: 60,
    width: 60,
    child: Icon(
      Icons.add,
      size: 40,
    ),
  );

  final String? coverUrl;
  PlaylistTile(this.title,
      {Key? key,
      this.onTap,
      this.subtitle,
      this.coverUrl,
      this.isAdd = false,
      this.isFavoriteList = false,
      this.isPinned = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      trailing: isAdd
          ? SizedBox()
          : isPinned
              ? IconButton(
                  icon: Icon(Icons.pin),
                  onPressed: () {},
                )
              : IconButton(
                  icon: Icon(Icons.more_vert),
                  onPressed: () {},
                ),
      leading: coverUrl != null
          ? Image.network(coverUrl!)
          : isAdd
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
