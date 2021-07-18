import 'dart:async';

import 'package:get/get.dart';
import 'package:spotify_clone/data/playlists.dart';
import 'package:spotify_clone/models/track.dart';

class PlayerController extends GetxController {
  int trackIndex = 0;
  Track track = rap[0];
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
  var time = 0.0.obs;
  void togglePlay() async {
    if (!isPlaying)
      play();
    else
      pause();
  }

  void setTrack(int index) {
    trackIndex = index;
    track = rap[index];
    play();
    update();
  }

  void toggleLike() {
    track.liked = !track.liked;
    update();
  }

  void play() async {
    if (!isPlaying) {
      isPlaying = true;
      update();
      while (isPlaying) {
        if (time.value >= track.duration.inSeconds - 2)
          next();
        else {
          time.value++;
          await Future.delayed(Duration(seconds: 1));
        }
      }
    }
  }

  void pause() async {
    isPlaying = false;
    update();
  }

  void next() {
    time.value = 0;
    track = rap[++trackIndex];
    play();
    update();
  }

  void previous() {
    time.value = 0;
    track = rap[--trackIndex];
    play();
    update();
  }
}
