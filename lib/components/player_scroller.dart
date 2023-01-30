import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_clone/controllers/player_controller.dart';
import 'package:spotify_clone/core/strings.dart';

class PlayerScroller extends StatelessWidget {
  final bool isNarrow;
  PlayerScroller({this.isNarrow = false, Key? key}) : super(key: key);
  final TextStyle kSongNameStyle =
      TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold);
  final TextStyle kArtistStyle =
      TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.grey);
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: PlayerController(),
      builder: (PlayerController player) {
        if (player.playlist.tracks.isEmpty) return Container();
        return PageView.builder(
          itemCount: player.isRepeated ? null : player.playlist.tracks.length,
          controller: player.playerScrollerPageController,
          onPageChanged: player.onPageChanged,
          itemBuilder: (context, index) {
            if (isNarrow) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    player.playlist
                        .tracks[index % player.playlist.tracks.length].title,
                    style: kSongNameStyle,
                  ),
                  Text(
                    player
                        .playlist
                        .tracks[index % player.playlist.tracks.length]
                        .artist
                        .name,
                    style: kArtistStyle,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Offstage(
                    child: Text(
                      playerNarrowAvaiableDevices,
                      style: kSongNameStyle,
                    ),
                  )
                ],
              );
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Image.network(
                  player.playlist.tracks[index % player.playlist.tracks.length]
                      .album.coverXl,
                ),
              );
            }
          },
        );
      },
    );
  }
}
