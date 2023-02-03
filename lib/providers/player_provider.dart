import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

import 'package:spotify_clone/models/track.dart';
import 'package:spotify_clone/providers/playlist_provider.dart';
import 'package:spotify_clone/services/cache_service.dart';

class Player {
  bool isPlaying = false;
  bool shuffleEnabled = false;
  bool repeatEnabled = false;
  Player({
    this.isPlaying = false,
    this.shuffleEnabled = false,
    this.repeatEnabled = false,
  });

  Player copyWith({
    bool? isPlaying,
    bool? shuffleEnabled,
    bool? repeatEnabled,
  }) {
    return Player(
      isPlaying: isPlaying ?? this.isPlaying,
      shuffleEnabled: shuffleEnabled ?? this.shuffleEnabled,
      repeatEnabled: repeatEnabled ?? this.repeatEnabled,
    );
  }
}

final playerStateProvider =
    StateNotifierProvider<PlayerNotifier, Player>((ref) => PlayerNotifier(ref));
final scrollerControllerProvider = Provider<PageController>((ref) {
  return PageController(initialPage: ref.read(indexProvider));
});

class PlayerNotifier extends StateNotifier<Player> {
  final Ref ref;
  PlayerNotifier(this.ref) : super(Player()) {
    getApplicationDocumentsDirectory().then((value) {
      final now = File(value.path + '/now_playing.json');
      if (now.existsSync()) {
        ref
            .read(currentTrackProvider.notifier)
            .set(Track.fromMap(jsonDecode(now.readAsStringSync())));
      }
    });
    ref.read(audioPlayerProvider).onPlayerComplete.listen((event) => next());
  }

  void play({Track? track, bool fromSearch = true}) async {
    if (fromSearch) {
      // ref.read(playListProvider).clear();
      ref.read(currentTrackProvider.notifier).set(track!);
    }
    if (track != null) {
      var cacheEntry =
          await ref.read(apiProvider).searchOnYoutubeAndGetUrl(track);
      ref.read(audioPlayerProvider).play(UrlSource(cacheEntry.path));
    } else {
      ref.read(audioPlayerProvider).resume();
    }
    state = state.copyWith(isPlaying: true);
    CacheService().setPlaying(track!.toJson());
  }

  void togglePlay() {
    if (state.isPlaying) {
      pause();
    } else {
      play(track: ref.read(currentTrackProvider));
    }
  }

  void pause() {
    ref.read(audioPlayerProvider).pause();
    state = state.copyWith(isPlaying: false);
  }

  void next() {
    resetPos();
    final trackIndex = ref.read(indexProvider);
    final playlist = ref.read(playListProvider);
    final hasNext = trackIndex < playlist.length - 1;
    var nextInt = state.shuffleEnabled
        ? Random().nextInt(playlist.length)
        : trackIndex + 1;
    if (!hasNext) nextInt = 0;
    ref.read(indexProvider.notifier).set(nextInt);
    if (hasNext) {
      final track = playlist[nextInt];
      play(track: track);
    } else {
      if (!state.repeatEnabled)
        pause();
      else
        play();
    }
  }

  void previous() {
    resetPos();
    final trackIndex = ref.read(indexProvider);
    final prevIndex = trackIndex - 1;
    final playlist = ref.read(playListProvider);
    var hasPrev = prevIndex >= 0;
    if (hasPrev) {
      final track = state.shuffleEnabled
          ? playlist[Random().nextInt(playlist.length)]
          : playlist[prevIndex];
      play(track: track);
    } else {
      ref.read(indexProvider.notifier).set(0);
      if (!state.repeatEnabled)
        pause();
      else
        play();
    }
  }

  void resetPos() {
    ref.read(audioPlayerProvider).seek(Duration(seconds: 0));
    ref.read(audioPlayerProvider).pause();
  }

  void toggleShuffle() {
    state.shuffleEnabled = !state.shuffleEnabled;
    state = state.copyWith(shuffleEnabled: state.shuffleEnabled);
  }

  void toggleRepetition() {
    state.repeatEnabled = !state.repeatEnabled;
    state = state.copyWith(repeatEnabled: state.repeatEnabled);
  }
}
