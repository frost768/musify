import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_clone/controllers/PlayerController.dart';

import 'package:spotify_clone/views/views.dart';

class PlayerFull extends StatelessWidget {
  PlayerFull({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kMainBackColor,
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Header(),
              ScrollableArt(),
              PlayerControls(),
            ],
          ),
        ),
      ),
    );
  }
}

class PlayerControls extends StatelessWidget {
  PlayerControls({Key? key}) : super(key: key);
// PlayerController player = Get.find();
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
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      player.track.artist,
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
                value: player.time.value,
                max: player.track.duration.inSeconds.toDouble(),
                onChanged: (value) {
                  player.time.value = value;
                },
              ),
            ),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(player.elapsedTimeString,
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  Text(player.trackDurationString,
                      style: TextStyle(
                        color: Colors.white,
                      )),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    color: Colors.white,
                    iconSize: 20,
                    onPressed: () {},
                    icon: Icon(Icons.shuffle_sharp)),
                IconButton(
                    color: Colors.white,
                    iconSize: 50,
                    onPressed: () {
                      player.previous();
                    },
                    icon: Icon(Icons.skip_previous_sharp)),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white, shape: BoxShape.circle),
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
                    color: Colors.white,
                    iconSize: 50,
                    onPressed: () {
                      player.next();
                    },
                    icon: Icon(Icons.skip_next_sharp)),
                IconButton(
                  color: Colors.white,
                  iconSize: 20,
                  onPressed: () {},
                  icon: Icon(Icons.repeat_sharp),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  color: Colors.white,
                  iconSize: 20,
                  onPressed: () {},
                  icon: Icon(Icons.tv),
                ),
                IconButton(
                  color: Colors.white,
                  iconSize: 20,
                  onPressed: () {},
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

class ScrollableArt extends GetWidget<PlayerController> {
  ScrollableArt({Key? key}) : super(key: key);
  // PlayerController player = Get.find<PlayerController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 50),
      height: 350,
      width: 350,
      child: Placeholder(
        color: Colors.white,
      ),
    );
  }
}

class Header extends GetWidget<PlayerController> {
  Header({
    Key? key,
  }) : super(key: key);

  final kHeaderTitleStyle = TextStyle(fontSize: 12, color: Colors.grey);
  final kAlbumNameStyle =
      TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: PlayerController(),
      builder: (PlayerController player) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(
                Icons.arrow_drop_down_circle_sharp,
                color: Colors.white,
              )),
          Expanded(
              child: Column(
            children: [
              Text(
                'ALBÜMDEN ÇALINIYOR',
                style: kHeaderTitleStyle,
              ),
              Text(
                player.track.album,
                style: kAlbumNameStyle,
              )
            ],
          )),
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              )),
        ],
      ),
    );
  }
}
