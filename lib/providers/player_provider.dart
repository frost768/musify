import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spotify_clone/models/models.dart';

import 'package:spotify_clone/providers/playlist_provider.dart';
import 'package:spotify_clone/services/cache_service.dart';

class Player {
  bool isPlaying = false;
  bool shuffleEnabled = false;
  bool repeatEnabled = false;
  Duration position;
  Player({
    this.isPlaying = false,
    this.shuffleEnabled = false,
    this.repeatEnabled = false,
    this.position = const Duration(),
  });

  Player copyWith({
    bool? isPlaying,
    bool? shuffleEnabled,
    bool? repeatEnabled,
    Duration? position,
  }) {
    return Player(
      isPlaying: isPlaying ?? this.isPlaying,
      shuffleEnabled: shuffleEnabled ?? this.shuffleEnabled,
      repeatEnabled: repeatEnabled ?? this.repeatEnabled,
      position: position ?? this.position,
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
            .read(playListProvider.notifier)
            .setPlaylist([Track.fromMap(jsonDecode(now.readAsStringSync()))]);
      }
    });
    ref.read(audioPlayerProvider).onPlayerComplete.listen((event) => next());
    ref
        .read(audioPlayerProvider)
        .onPositionChanged
        .listen((position) => state.position = position);
  }
  void play(
      {Track? track,
      List<Track>? playlist,
      AlbumDetail? albumDetail,
      PlayerSource source = PlayerSource.track}) async {
    if (state.isPlaying) {
      await ref.read(audioPlayerProvider).pause();
      state = state.copyWith(isPlaying: false);
    }
    switch (source) {
      case PlayerSource.track:
        if (track != null) {
          ref.read(indexProvider.notifier).set(0);
          ref.read(playListProvider.notifier).setPlaylist([track]);
        }
        break;
      case PlayerSource.playlist:
        if (playlist != null) {
          ref.read(playListProvider.notifier).setPlaylist(playlist);
          ref.read(indexProvider.notifier).set(0);
          if (track != null) {
            final indexOfTrack = ref.read(playListProvider).indexOf(track);
            ref.read(indexProvider.notifier).set(indexOfTrack);
          } else {
            ref.read(indexProvider.notifier).set(0);
          }
        }
        break;
      case PlayerSource.album:
        if (albumDetail != null) {
          ref
              .read(playListProvider.notifier)
              .setPlaylist(albumDetail.trackList);
          if (track != null) {
            final indexOfTrack = ref.read(playListProvider).indexOf(track);
            ref.read(indexProvider.notifier).set(indexOfTrack);
          } else {
            ref.read(indexProvider.notifier).set(0);
          }
        }
        break;
    }

    var track2 = ref.read(currentTrackProvider)!;
    var cacheEntry =
        await ref.read(apiProvider).searchOnYoutubeAndGetUrl(track2);
    ref.read(audioPlayerProvider).play(UrlSource(cacheEntry.path));

    state = state.copyWith(isPlaying: true);
    CacheService().setPlaying(ref.read(currentTrackProvider)!.toJson());
  }

  void resume() {
    ref.read(audioPlayerProvider).resume();
    state = state.copyWith(isPlaying: true);
  }

  void togglePlay() {
    if (state.isPlaying) {
      pause();
    } else {
      if (ref.read(audioPlayerProvider).source == null) {
        play(track: ref.read(currentTrackProvider));
      } else {
        resume();
      }
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
      play();
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
    final playlistLength = ref.read(playListProvider).length;
    var hasPrev = prevIndex >= 0;
    if (hasPrev) {
      final index =
          state.shuffleEnabled ? Random().nextInt(playlistLength) : prevIndex;
      ref.read(indexProvider.notifier).set(index);
      play();
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

enum PlayerSource { track, playlist, album }
