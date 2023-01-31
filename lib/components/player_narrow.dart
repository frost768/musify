import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_clone/components/player_scroller.dart';
import 'package:spotify_clone/controllers/player_controller.dart';
import 'package:spotify_clone/views/views.dart';

class PlayerNarrow extends StatelessWidget {
  PlayerNarrow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: PlayerController(),
      builder: (PlayerController player) {
        if (player.track == null) return Container();
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: BorderRadius.circular(5)),
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: kPlayerNarrowHeight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Album Art

                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                        onTap: () => Get.to(() => PlayerFull(),
                            transition: Transition.downToUp),
                        child: Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              margin: const EdgeInsets.only(right: 10),
                              child:
                                  Image.network(player.track!.album.coverBig),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            Expanded(child: PlayerScroller(isNarrow: true)),
                          ],
                        ),
                      ),
                    ),

                    // Like And Play
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // IconButton(
                          //   onPressed: () {
                          //     player.toggleLike();
                          //   },
                          //   icon: Icon(Icons.device_hub),
                          // ),
                          IconButton(
                            onPressed: () {
                              player.toggleLike();
                            },
                            icon: Icon(
                              player.track!.liked
                                  ? Icons.favorite
                                  : Icons.favorite_outline,
                              color: player.track!.liked
                                  ? Colors.green
                                  : Colors.white,
                              size: 30,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              player.togglePlay();
                            },
                            icon: Icon(
                              player.isPlaying ? Icons.pause : Icons.play_arrow,
                              size: 30,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Obx(
                () => Container(
                  height: kPlayerElapsedTimeNarrowHeight,
                  width: player.time.value *
                      (Get.size.width / player.track!.pDuration.inSeconds),
                  decoration: BoxDecoration(
                      gradient:
                          LinearGradient(colors: [Colors.purple, Colors.pink])),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
