import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_clone/components/explicit_widget.dart';
import 'package:spotify_clone/controllers/player_controller.dart';
import 'package:spotify_clone/models/track.dart';

class TrackTile extends StatelessWidget {
  final Track track;
  final textStyle = TextStyle(fontSize: 12, color: Colors.grey);
  TrackTile(this.track, {Key? key}) : super(key: key);
  var player = Get.find<PlayerController>();
  bool get isPlaying {
    if (player.track == null) return false;
    return player.track!.id == track.id;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => player.playTrack(track),
      leading: SizedBox(
        width: 60,
        height: 60,
        child: Image.network(track.album.coverBig),
      ),
      title: isPlaying
          ? Row(
              children: [
                Icon(
                  Icons.equalizer,
                  size: 20,
                ),
                Container(
                  width: MediaQuery.of(context).size.width / 2 - 5,
                  margin: const EdgeInsets.only(left: 5),
                  child: Text(
                    track.title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.green),
                  ),
                )
              ],
            )
          : Text(
              track.title,
              style: TextStyle(color: Colors.white),
            ),
      subtitle: Row(
        children: [
          if (track.explicitLyrics) ExplicitWidget(),
          Text(
            track.artist.name,
            style: textStyle,
          ),
        ],
      ),
      trailing: IconButton(
          onPressed: () {
            showBottomSheet(
              context: context,
              builder: (context) {
                return Container(
                  height: Get.height,
                  width: Get.width,
                  child: Column(children: [
                    Text(track.title),
                    Text(track.artist.name),
                    ListTile(
                      title: Text('Sıraya ekle'),
                      onTap: () {
                        Get.back();
                        var player = Get.find<PlayerController>();
                        player.addToPlaylist(track);
                      },
                    )
                  ]),
                );
              },
            );
          },
          icon: Icon(
            Icons.more_vert_outlined,
            color: Colors.grey,
          )),
    );
  }
}
