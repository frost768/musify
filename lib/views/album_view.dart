import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_clone/components/bottom_nav_bar.dart';
import 'package:spotify_clone/components/home_horizontal_slider.dart';
import 'package:spotify_clone/components/play_shuffle_button.dart';
import 'package:spotify_clone/components/track_tile.dart';
import 'package:spotify_clone/controllers/album_controller.dart';
import 'package:spotify_clone/models/album.dart';
import 'package:spotify_clone/views/views.dart';

class AlbumView extends StatelessWidget {
  Album? album;
  AlbumView({this.album, Key? key}) : super(key: key);
  // String get albumTrackAndDurationInfo =>
  //     '${album!.tracks.length} şarkı • ${album!.duration.inMinutes} dk.  ${album!.duration.inSeconds - album!.duration.inMinutes * 60} sn.';
  final albumNameStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
  final boxDecoration = BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.grey, kMainBackColor]));
  final albumArtNameStyle =
      TextStyle(fontWeight: FontWeight.bold, fontSize: 25);
  final albumArtSubtitleStyle =
      TextStyle(color: Colors.grey, fontWeight: FontWeight.w500);
  final albumTrackAndDurationInfoStyle = TextStyle(color: Colors.white);
  final youMayAlsoLikeTheseStyle =
      TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  final copyrightTextStyle = TextStyle(fontSize: 15);
  final copyrightTextMargin =
      const EdgeInsets.only(left: 10, top: 40, bottom: 20);
  final albumArtSubtitleMargin = const EdgeInsets.only(bottom: 10);
  final albumArtMargin =
      const EdgeInsets.only(left: 50, right: 50, top: 50, bottom: 10);
  @override
  Widget build(BuildContext context) {
    album = ModalRoute.of(context)!.settings.arguments as Album;
    return GetBuilder(
      init: AlbumController(album!),
      builder: (AlbumController albumController) {
        var _appBar = AppBar(
            title: Text(
              album!.title,
              style: albumNameStyle,
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: albumController.toggleLike,
                icon: album!.isFavorite
                    ? Icon(Icons.favorite, color: Colors.green)
                    : Icon(Icons.favorite_outline),
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.more_vert)),
            ]);

        return Scaffold(
          backgroundColor: kMainBackColor,
          appBar: _appBar,
          bottomNavigationBar: BottomNavBar(),
          body: SingleChildScrollView(
              child: Column(
            children: [
              Container(
                  margin: albumArtMargin,
                  height: 170,
                  width: 170,
                  color: Colors.white),
              Container(
                margin: const EdgeInsets.all(10),
                child: Text(
                  album!.title,
                  style: albumArtNameStyle,
                ),
              ),
              Container(
                margin: albumArtSubtitleMargin,
                height: 20,
                child: Text(
                  'd',
                  // 'Albüm / ${album!.artist.name} • ${album!.createdAt!.year}',
                  style: albumArtSubtitleStyle,
                ),
              ),
              PlayShuffleButton(),
              // ...album!.tracks.map((track) => TrackTile(track)).toList(),
              // ListTile(
              //   title: Text(
              //     '${album!.createdAt!.ddMonthYYYY}',
              //   ),
              //   subtitle: Text(
              //     albumTrackAndDurationInfo,
              //     style: albumTrackAndDurationInfoStyle,
              //   ),
              // ),
              // ListTile(
              //   leading: CircleAvatar(
              //     radius: 25,
              //     backgroundColor: Colors.white,
              //   ),
              //   title: Text(
              //     '${album!.artist.name}',
              //   ),
              // ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                child: HomeHorizontalSlider(
                    header: Center(
                  child: Text(
                    albumViewYouMayAlsoLikeThese,
                    style: youMayAlsoLikeTheseStyle,
                  ),
                )),
              ),
              // Row(
              //   children: [
              //     Container(
              //         margin: copyrightTextMargin,
              //         child: Text(
              //           '${album!.copyrightText}',
              //           style: copyrightTextStyle,
              //         )),
              //   ],
              // )
            ],
          )),
        );
      },
    );
  }
}
