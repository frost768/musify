import 'dart:async';

import 'package:get/get.dart';
import 'package:spotify_clone/controllers/user_controller.dart';
import 'package:spotify_clone/data/playlists.dart';
import 'package:spotify_clone/models/track.dart';

class PlayerController extends GetxController {
  UserController user = Get.find<UserController>();
  int trackIndex = 0;
  Track track = playlists[0].tracks[0];
  bool isPlaying = false;
  String get elapsedTimeString =>
      DateTime.fromMillisecondsSinceEpoch(time.value.toInt() * 1000)
          .toIso8601String()
          .split('T')[1]
          .split('.')[0]
          .substring(3);
  String get trackDurationString =>
      DateTime.fromMillisecondsSinceEpoch(track.duration.inMilliseconds)
          .toIso8601String()
          .split('T')[1]
          .split('.')[0]
          .substring(3);
  var time = 0.obs;
  void togglePlay() async {
    if (!isPlaying)
      play();
    else
      pause();
  }

  void setTrack(int index) {
    time.value = 0;
    trackIndex = index;
    track = playlists[0].tracks[index];
    update();
    play();
  }

  void toggleLike() {
    track.liked = !track.liked;
    if (track.liked)
      user.addToFavorites(track);
    else
      user.removeFromFavorites(track.id);
    user.update();
    update();
  }

  void play() async {
    if (!isPlaying) {
      isPlaying = true;
      update();
      while (isPlaying) {
        if (time.value == track.duration.inSeconds)
          next();
        else {
          time.value++;
        }
        await Future.delayed(Duration(seconds: 1));
      }
    }
  }

  void pause() async {
    isPlaying = false;
    update();
  }

  void next() {
    time.value = 0;
    track = playlists[0].tracks[++trackIndex];
    play();
    update();
  }

  void previous() {
    time.value = 0;
    track = playlists[0].tracks[--trackIndex];
    play();
    update();
  }
}
