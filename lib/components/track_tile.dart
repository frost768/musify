import 'package:flutter/material.dart';
import 'package:spotify_clone/models/track.dart';

class TrackTile extends StatelessWidget {
  final Track track;
  TrackTile(this.track, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        track.name,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        track.artist.name,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      trailing: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.more_vert_outlined,
            color: Colors.grey,
          )),
    );
  }
}
