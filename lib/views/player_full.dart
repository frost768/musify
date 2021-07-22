import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_clone/components/player_scroller.dart';
import 'package:spotify_clone/components/track_tile.dart';
import 'package:spotify_clone/controllers/player_controller.dart';
import 'package:spotify_clone/data/playlists.dart';

import 'package:spotify_clone/views/views.dart';

class PlayerFull extends StatelessWidget {
  PlayerFull({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackColor,
      body: GetBuilder(
        init: PlayerController(),
        builder: (PlayerController player) {
          return Stack(children: [
            PlayerScroller(Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.purpleAccent, Colors.black])),
              child: Container(
                decoration: BoxDecoration(color: Colors.purpleAccent),
                margin: const EdgeInsets.only(
                    left: 30, right: 30, top: 155, bottom: 330),
                height: 350,
                width: 350,
              ),
            )),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  Header(),
                  Expanded(
                    flex: 4,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 40),
                      height: 350,
                      width: 350,
                    ),
                  ),
                  Expanded(flex: 3, child: PlayerControls()),
                ],
              ),
            ),
          ]);
        },
      ),
    );
  }
}

class PlayerControls extends StatelessWidget {
  PlayerControls({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: PlayerController(),
      builder: (PlayerController player) => Container(
        margin: const EdgeInsets.only(top: 50),
        height: 240,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      player.track.name,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      player.track.artist.name,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
                IconButton(
                  onPressed: () {
                    player.toggleLike();
                  },
                  icon: Icon(
                      player.track.liked
                          ? Icons.favorite
                          : Icons.favorite_outline,
                      color: player.track.liked ? Colors.green : Colors.white),
                ),
              ],
            ),
            Obx(
              () => Slider(
                inactiveColor: Colors.black12,
                activeColor: Colors.black38,
                value: player.time.value.toDouble(),
                max: player.track.duration.inSeconds.toDouble(),
                onChanged: (value) {
                  player.time.value = value.toInt();
                },
              ),
            ),
            Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(player.elapsedTimeString,
                        style: kPlayerTimeStringStyle),
                    Text(player.trackDurationString,
                        style: kPlayerTimeStringStyle),
                  ],
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    iconSize: 20,
                    onPressed: player.toggleShuffle,
                    icon: player.isShuffleOpen
                        ? Icon(
                            Icons.shuffle_on_sharp,
                            color: Colors.green,
                          )
                        : Icon(Icons.shuffle)),
                IconButton(
                    iconSize: 50,
                    onPressed: () {
                      player.previous();
                    },
                    icon: Icon(Icons.skip_previous_sharp)),
                Container(
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: IconButton(
                      iconSize: 50,
                      onPressed: () {
                        player.togglePlay();
                      },
                      icon: Icon(player.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow_sharp)),
                ),
                IconButton(
                    iconSize: 50,
                    onPressed: () {
                      player.next();
                    },
                    icon: Icon(Icons.skip_next_sharp)),
                IconButton(
                  iconSize: 20,
                  onPressed: () {
                    player.toggleRepetition();
                  },
                  icon: player.isRepeated
                      ? Icon(
                          Icons.repeat_on_sharp,
                          color: Colors.green,
                        )
                      : Icon(Icons.repeat_sharp),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  iconSize: 20,
                  onPressed: () {},
                  icon: Icon(Icons.tv),
                ),
                IconButton(
                  iconSize: 20,
                  onPressed: () {
                    showBottomSheet(
                      context: context,
                      builder: (_) => Container(
                        color: kMainBackColor,
                        height: Get.height,
                        child: Column(
                          children: [
                            Header(),
                            Expanded(
                              child: ReorderableListView(
                                header: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text('Şimdi çalınıyor'),
                                      ],
                                    ),
                                    TrackTile(
                                      player.track,
                                      showAlbumArt: true,
                                    ),
                                  ],
                                ),
                                children: playlists[0]
                                    .tracks
                                    .map((e) =>
                                        TrackTile(e, key: Key(e.id.toString())))
                                    .toList(),
                                onReorder: (oldIndex, newIndex) {
                                  var old = playlists[0].tracks[oldIndex];
                                  var nedw = playlists[0].tracks[newIndex];
                                  playlists[0].tracks[newIndex] = old;

                                  playlists[0].tracks[oldIndex] = nedw;
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.playlist_play),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Header extends GetWidget<PlayerController> {
  Header({
    Key? key,
  }) : super(key: key);

  final kHeaderTitleStyle = TextStyle(fontSize: 12, letterSpacing: 1);
  final kAlbumNameStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: PlayerController(),
      builder: (PlayerController player) => Padding(
        padding: EdgeInsets.only(top: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_drop_down_circle_sharp,
                )),
            Column(
              children: [
                Text(
                  'ALBÜMDEN ÇALINIYOR',
                  style: kHeaderTitleStyle,
                ),
                Text(
                  player.track.album.name,
                  style: kAlbumNameStyle,
                )
              ],
            ),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.more_vert,
                )),
          ],
        ),
      ),
    );
  }
}
