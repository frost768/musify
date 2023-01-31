import 'package:flutter/material.dart';
import 'package:flutter_lyric/lyrics_reader.dart';
import 'package:flutter_lyric/lyrics_reader_model.dart';
import 'package:get/get.dart';
import 'package:spotify_clone/components/player_scroller.dart';
import 'package:spotify_clone/controllers/player_controller.dart';
import 'package:spotify_clone/services/lyrics_service.dart';

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
                          Container(
                            width: MediaQuery.of(context).size.width / 1.4,
                            child: Text(
                              controller.track!.title,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
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
                  SizedBox(height: 20),
                  Obx(
                    () => Slider(
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

class LyUI extends UINetease {
  LyUI()
      : super(
          lyricAlign: LyricAlign.LEFT,
          defaultSize: 30,
          otherMainSize: 20,
          defaultExtSize: 10,
        );
  @override
  Color getLyricHightlightColor() {
    return Colors.white;
  }

  @override
  TextStyle getPlayingMainTextStyle() {
    return TextStyle(
        fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white);
  }

  @override
  TextStyle getOtherMainTextStyle() {
    return TextStyle(
        fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white60);
  }

  @override
  bool get highlight => true;
  @override
  double get lineGap => 10;
}

class _LyricsCardState extends State<LyricsCard> {
  final lyricUI = LyUI();
  String lrc = '';

  bool isLoading = true;
  LyricsReaderModel _getLyricModel(String lrc) =>
      LyricsModelBuilder.create().bindLyricToMain(lrc).getModel();
  PlayerController? player;
  @override
  void initState() {
    super.initState();
    player = Get.find<PlayerController>();
    player!.onPositionChanged = () {
      setState(() {});
    };
    fetch();
  }

  void fetch() async {
    lrc = await LyricsifyLyricsFinder()
        .getLrc(player!.track!.title, player!.track!.artist.name);
    setState(() {
      isLoading = false;
    });
  }

  double _offset = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 30),
      padding: const EdgeInsets.only(left: 10, top: 5),
      height: 370,
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
            flex: 10,
            child: Visibility(
              visible: !isLoading,
              replacement: Center(child: CircularProgressIndicator()),
              child: LyricsReader(
                model: _getLyricModel(lrc),
                position: player!.timeInMilliseconds + (_offset * 100).toInt(),
                lyricUi: lyricUI,
                playing: player!.isPlaying,
                size: Size(
                    double.infinity, MediaQuery.of(context).size.height / 2),
                emptyBuilder: () => Center(
                  child: Text(
                    "No lyrics",
                    style: lyricUI.getOtherMainTextStyle(),
                  ),
                ),
              ),
            ),
          ),
          ActionChip(
              onPressed: () {},
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
