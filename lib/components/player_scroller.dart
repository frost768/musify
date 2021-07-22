import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_clone/controllers/player_controller.dart';

class PlayerScroller extends StatelessWidget {
  final Widget child;
  PlayerScroller(this.child, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: PlayerController(),
      builder: (PlayerController player) => PageView(
        onPageChanged: player.setTrack,
        children: player.playlist.tracks.map((e) => child).toList(),
      ),
    );
  }
}
