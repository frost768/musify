import 'dart:async';
import 'dart:math';
import 'package:get/get.dart';
import 'package:spotify_clone/controllers/user_controller.dart';
import 'package:spotify_clone/data/playlists.dart';
import 'package:spotify_clone/models/playlist.dart';
import 'package:spotify_clone/models/track.dart';

class PlayerController extends GetxController {
  bool isShuffleOpen = false;
  bool isRepeated = false;
  UserController user = Get.find<UserController>();
  int trackIndex = 0;
  Track track = playlists[0].tracks[0];
  Playlist playlist = playlists[0];
  bool isPlaying = false;
  String get elapsedTimeString =>
      DateTime.fromMillisecondsSinceEpoch(time.value.toInt() * 1000)
          .toIso8601String()
          .split('T')[1]
          .split('.')[0]
          .substring(4);
  String get trackDurationString =>
      DateTime.fromMillisecondsSinceEpoch(track.duration.inMilliseconds)
          .toIso8601String()
          .split('T')[1]
          .split('.')[0]
          .substring(4);
  var time = 0.obs;
  void togglePlay() {
    if (!isPlaying)
      play();
    else
      pause();
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

  void toggleShuffle() {
    isShuffleOpen = !isShuffleOpen;
    update();
  }

  void toggleRepetition() {
    isRepeated = !isRepeated;
    update();
  }

  void setTrack(int index) {
    time.value = 0;
    trackIndex = index;
    track = playlist.tracks[index];
    update();
    play();
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
    var hasNext = trackIndex < playlist.tracks.length - 1;
    time.value = 0;
    if (hasNext) {
      trackIndex++;
      track = isShuffleOpen
          ? playlist.tracks[Random().nextInt(playlist.tracks.length)]
          : playlist.tracks[trackIndex];
      play();
    } else {
      trackIndex = 0;
      track = playlist.tracks[0];
      if (!isRepeated) pause();
    }
    update();
  }

  void previous() {
    if (trackIndex > 0) {
      time.value = 0;
      track = playlist.tracks[--trackIndex];
      play();
      update();
    }
  }
}
