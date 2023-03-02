import 'package:flutter/material.dart';
import 'package:spotify_clone/models/track.dart';

class PlaylistPlayButton extends StatelessWidget {
  final List<Track> tracks;
  PlaylistPlayButton(
    this.tracks, {
    Key? key,
  }) : super(key: key);

  final boxDecoration = BoxDecoration(
    shape: BoxShape.circle,
    color: Colors.green.shade900,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: boxDecoration,
        child: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.play_arrow,
              size: 35,
            )));
  }
}
