import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_clone/components/player_scroller.dart';
import 'package:spotify_clone/controllers/player_controller.dart';

import 'package:spotify_clone/views/views.dart';

class PlayerFull extends StatelessWidget {
  PlayerFull({Key? key}) : super(key: key);

  final kHeaderTitleStyle = TextStyle(fontSize: 10, letterSpacing: 1);
  final kAlbumNameStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder(
            init: PlayerController(),
            builder: (PlayerController controller) => Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          AppBar(
                            leading: IconButton(
                              icon: Icon(Icons.expand_more),
                              onPressed: Get.back,
                            ),
                            centerTitle: true,
                            title: Column(
                              children: [
                                Text(
                                  'ALBÜMDEN ÇALINIYOR',
                                  style: kHeaderTitleStyle,
                                ),
                                Text(
                                  controller.track!.album.title,
                                  style: kAlbumNameStyle,
                                )
                              ],
                            ),
                            actions: [
                              IconButton(
                                icon: Icon(Icons.more_vert),
                                onPressed: () {},
                              )
                            ],
                          ),
                          Container(
                            height: 470,
                            child: PlayerScroller(),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: PlayerControls(),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: LyricsCard(),
                          )
                        ],
                      ),
                    ),
                  ],
                )));
  }
}

class PlayerControls extends StatelessWidget {
  PlayerControls({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: PlayerController(),
        builder: (PlayerController controller) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            controller.track!.title,
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            controller.track!.artist.name,
                            style: TextStyle(fontSize: 15, color: Colors.grey),
                          )
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          controller.toggleLike();
                        },
                        icon: Icon(
                            controller.track!.liked
                                ? Icons.favorite
                                : Icons.favorite_outline,
                            color: controller.track!.liked
                                ? Colors.green
                                : Colors.white),
                      ),
                    ],
                  ),
                  Obx(
                    () => Slider(
                        inactiveColor: Colors.black12,
                        activeColor: Color.fromARGB(255, 61, 61, 61),
                        value: controller.time.value.toDouble(),
                        max: controller.track!.pDuration.inSeconds.toDouble(),
                        onChangeEnd: (value) => controller.seek(value.toInt()),
                        onChanged: (double value) =>
                            controller.time.value = value.toInt()),
                  ),
                  Obx(() => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(controller.elapsedTimeString,
                                style: kPlayerTimeStringStyle),
                            Text(controller.trackDurationString,
                                style: kPlayerTimeStringStyle),
                          ],
                        ),
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          iconSize: 30,
                          onPressed: controller.toggleShuffle,
                          icon: controller.isShuffleOpen
                              ? Icon(
                                  Icons.shuffle,
                                  color: Colors.green,
                                )
                              : Icon(Icons.shuffle)),
                      IconButton(
                          iconSize: 50,
                          onPressed: () {
                            controller.previous();
                          },
                          icon: Icon(Icons.skip_previous_sharp)),
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.white),
                        child: IconButton(
                            iconSize: 50,
                            onPressed: () {
                              controller.togglePlay();
                            },
                            icon: Icon(
                              controller.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              size: 40,
                            ),
                            color: Colors.black),
                      ),
                      IconButton(
                          iconSize: 50,
                          onPressed: () {
                            controller.next();
                          },
                          icon: Icon(Icons.skip_next_sharp)),
                      IconButton(
                        iconSize: 30,
                        onPressed: () {
                          controller.toggleRepetition();
                        },
                        icon: controller.isRepeated
                            ? Icon(
                                Icons.repeat,
                                color: Colors.green,
                              )
                            : Icon(Icons.repeat),
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
                                  //   Expanded(
                                  //     child: ReorderableListView(
                                  //       header: Column(
                                  //         children: [
                                  //           Row(
                                  //             children: [
                                  //               Text('Şimdi çalınıyor'),
                                  //             ],
                                  //           ),
                                  //           TrackTile(
                                  //             player.track,
                                  //             showAlbumArt: true,
                                  //           ),
                                  //         ],
                                  //       ),
                                  //       children: playlists[0]
                                  //           .tracks
                                  //           .map((e) =>
                                  //               TrackTile(e, key: Key(e.id.toString())))
                                  //           .toList(),
                                  //       onReorder: (oldIndex, newIndex) {
                                  //         var old = playlists[0].tracks[oldIndex];
                                  //         var nedw = playlists[0].tracks[newIndex];
                                  //         playlists[0].tracks[newIndex] = old;

                                  //         playlists[0].tracks[oldIndex] = nedw;
                                  //       },
                                  //     ),
                                  //   )
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
            ));
  }
}

class Header extends StatelessWidget {
  Header({
    Key? key,
  }) : super(key: key);

  final kHeaderTitleStyle = TextStyle(fontSize: 12, letterSpacing: 1);
  final kAlbumNameStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: PlayerController(),
      builder: (PlayerController controller) => Row(
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
                controller.track!.album.title,
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
    );
  }
}

class LyricsCard extends StatefulWidget {
  const LyricsCard({key});

  @override
  State<LyricsCard> createState() => _LyricsCardState();
}

class _LyricsCardState extends State<LyricsCard> {
  @override
  Widget build(BuildContext context) {
    var _scrollController = ScrollController();
    return Container(
      margin: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 30),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      height: 350,
      decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Şarkı Sözleri',
                    style: Theme.of(context).textTheme.button),
                IconButton(
                    onPressed: () {}, icon: Icon(Icons.fullscreen_rounded))
              ],
            ),
          ),
          Expanded(
            flex: 5,
            child: ListView(
              itemExtent: 100,
              controller: _scrollController,
              // physics: NeverScrollableScrollPhysics(),
              children: g
                  .split('\n')
                  .map((e) => Text(
                        e,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontSize: 25),
                      ))
                  .toList(),
            ),
          ),
          ActionChip(
              onPressed: () {
                _scrollController.position.animateTo(
                    _scrollController.offset + 100,
                    duration: Duration(milliseconds: 100),
                    curve: Curves.linear);
              },
              visualDensity: VisualDensity(vertical: -2),
              backgroundColor: Colors.red,
              avatar: Icon(
                Icons.share,
                size: 15,
              ),
              label: Text('PAYLAŞ'))
        ],
      ),
    );
  }
}

const g = """Die Erde hat sich um die Sonne
Schon hundertachtzig Grad gedreht
Ist schon verrückt, wie schnell ein halbes Jahr mit dir vergeht
Hätt' nicht gedacht, dass es uns so weit trägt
Der Asphalt flimmert in der Hitze
Doch die Luft in mir gefriert
Es kommt ein Gewitter auf, ich weiß genau, was jetzt passiert
Wenn Liebesmut gegen Angst verliert
Meine Schritte werden schneller
Doch ich will uns nicht verlier'n
Diesmal ist es anders
Du bist für mich besonders
Und selbst wenn mich mein Fluchtreflex einholt
Und auch dich verletzt, ich glaub' an uns
Ich kann das, ich kann das
Man weiß doch, wie das ist
Sobald es ernst zu werden droht
Fluten Million'n Gründe, warum das mit uns nicht funktioniert
Meine Straßen, bis ich kapitulier'
Aber was, wenn das nicht sein muss?
Wenn es Milliarden Gründe gibt
Die man nur suchen muss; die uns zusammenhalten
Wenn alle Welt um uns sich trennt
Meine Schritte werden schneller
Doch ich werd' uns nicht verlier'n
Diesmal ist es anders
Du bist für mich besonders
Und selbst wenn mich mein Fluchtreflex einholt
Und auch dich verletzt, ich glaub' an uns
Ich kann das, ich kann das, oh-oh, oh-oh
Oh-oh, oh-oh
Ich gehör' ab jetzt zu dir
Keine Chance, dass wir uns je wieder verlier'n
Denn diesmal ist es anders
Du bist für mich besonders
Und selbst wenn mich mein Fluchtreflex einholt
Und auch dich verletzt, ich glaub' an uns
Ich kann das, ich kann das
Denn diesmal ist es anders
Ich kann das, oh-oh
Ich kann das, ich kann das, oh-oh
Ich kann das, ich kann das""";
