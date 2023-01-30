import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spotify_clone/controllers/user_controller.dart';
import 'package:spotify_clone/models/playlist.dart';
import 'package:spotify_clone/models/track.dart';
import 'package:spotify_clone/services/api_service.dart';
import 'package:spotify_clone/services/cache_service.dart';

class PlayerController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getApplicationDocumentsDirectory().then((value) {
      final now = File(value.path + '/now_playing.json');
      if (now.existsSync()) {
        track = Track.fromMap(jsonDecode(now.readAsStringSync()));
        playlist.tracks.add(track!);
      }
    });
    update();
  }

  int get timeInMilliseconds => Duration(seconds: time.toInt()).inMilliseconds;
  final playerScrollerPageController = PageController();
  AudioPlayer _audioPlayer = AudioPlayer();
  bool isShuffleOpen = false;
  bool isRepeated = false;
  UserController user = Get.find<UserController>();
  int trackIndex = 0;
  Track? track;
  Playlist playlist = Playlist(0, 'd');
  bool isPlaying = false;
  Function()? onPositionChanged;
  PlayerController() {
    _audioPlayer.onPositionChanged.listen((event) {
      time.value = event.inSeconds;
      update();
    });
    _audioPlayer.onPlayerStateChanged.listen((event) {
      switch (event) {
        case PlayerState.stopped:
          isPlaying = false;
          break;
        case PlayerState.playing:
          isPlaying = true;
          break;
        case PlayerState.paused:
          isPlaying = false;
          break;
        case PlayerState.completed:
          next();
          break;
      }
      update();
    });
  }
  String get elapsedTimeString =>
      DateTime.fromMillisecondsSinceEpoch(time.value.toInt() * 1000)
          .toIso8601String()
          .split('T')[1]
          .split('.')[0]
          .substring(4);
  String get trackDurationString =>
      DateTime.fromMillisecondsSinceEpoch(track!.pDuration.inMilliseconds)
          .toIso8601String()
          .split('T')[1]
          .split('.')[0]
          .substring(4);
  var time = 0.obs;
  void togglePlay() {
    if (!isPlaying) {
      if (_audioPlayer.source != null) {
        _audioPlayer.resume();
      } else {
        play();
      }
    } else
      pause();
  }

  void toggleLike() {
    track!.liked = !track!.liked;
    if (track!.liked)
      user.addToFavorites(track!);
    else
      user.removeFromFavorites(track!.id);
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

  void _playUrl(String url) async {
    _audioPlayer.play(UrlSource(url),
        position: Duration(seconds: 0),
        volume: 1,
        mode: PlayerMode.mediaPlayer);
  }

  void _playFile(String path) async {
    _audioPlayer.play(DeviceFileSource(path),
        position: Duration(seconds: 0),
        volume: 1,
        mode: PlayerMode.mediaPlayer);
  }

  void playTrack(Track trackToBePlayed) async {
    time.value = 0;
    playlist.tracks = [trackToBePlayed];
    setTrack(0);
    play();

    update();
  }

  void play() async {
    final cacheEntry = await ApiService().searchOnYoutubeAndGetUrl(track!);
    if (cacheEntry.path.isURL) {
      track!.url = cacheEntry.path;
      track!.duration = cacheEntry.trackDuration.inSeconds;
      _playUrl(cacheEntry.path);
    } else {
      track!.duration = cacheEntry.trackDuration.inSeconds;
      _playFile(cacheEntry.path);
    }
    CacheService().setPlaying(track!.toJson());
    update();
  }

  void pause() async {
    _audioPlayer.pause();
  }

  void next() {
    var hasNext = trackIndex < playlist.tracks.length - 1;
    seek(0);
    if (hasNext) {
      trackIndex++;

      // track = isShuffleOpen
      //     ? playlist.tracks[Random().nextInt(playlist.tracks.length)]
      //     : playlist.tracks[trackIndex];
      setTrack(trackIndex);
      play();
    } else {
      trackIndex = 0;
      // track = playlist.tracks[0];
      setTrack(trackIndex);
      if (!isRepeated)
        pause();
      else
        play();
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

  void seek(int seconds) {
    _audioPlayer.seek(Duration(seconds: seconds));
  }

  void addToPlaylist(Track tr) {
    bool hasIt = playlist.tracks.any((element) => element.id == tr.id);
    if (!hasIt) playlist.tracks.add(tr);
    if (playlist.tracks.length == 1) track = tr;
    update();
  }

  void setTrack(int index) {
    track = playlist.tracks[index % playlist.tracks.length];
    update();
  }

  @override
  void onClose() {
    super.onClose();
    _audioPlayer.release();
  }

  void onPageChanged(int value) {
    final index = value % playlist.tracks.length;
    print(index);
    if (index > trackIndex) {
      next();
    } else {
      previous();
    }
  }
}
