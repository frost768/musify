import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:spotify_clone/models/models.dart';

import 'package:spotify_clone/services/api_service.dart';
import 'package:spotify_clone/services/lyrics_service.dart';

class PlayListNotifier extends Notifier<List<Track>> {
  PlayListNotifier() : super();

  void addToPlaylist(Track track) {
    state = [...state, track];
  }

  void setPlaylist(List<Track> tracks) {
    state = tracks;
  }

  void playFromAlbum(AlbumDetail album) {
    state = album.trackList;
  }

  @override
  List<Track> build() {
    return [];
  }
}

class PositionNotifier extends StateNotifier<Duration> {
  PositionNotifier() : super(Duration(seconds: 0));
  set(int pos) {
    return state = Duration(seconds: pos);
  }

  String get elapsedTimeString =>
      DateTime.fromMillisecondsSinceEpoch(state.inMilliseconds)
          .toIso8601String()
          .split('T')[1]
          .split('.')[0]
          .substring(4);
}

final apiProvider = Provider<ApiService>((ref) => ApiService());

final audioPlayerProvider = Provider<AudioPlayer>((ref) {
  var audioPlayer = AudioPlayer();
  return audioPlayer;
});

var currentTrackProvider = Provider<Track?>((ref) {
  var playlist = ref.watch(playListProvider);
  if (playlist.isEmpty) {
    return null;
  }
  return playlist[ref.watch(indexProvider)];
});

final lyricsProvider = FutureProvider.family<String, Track>((ref, track) =>
    LyricsifyLyricsFinder().getLrc(track.title, track.artist.name));
final albumDetailsProvider = FutureProvider.family<AlbumDetail, int>(
    (ref, albumId) => ApiService().albumDetails(albumId));

final libraryFiltreredListProvider = Provider<List>((ref) {
  final filter = ref.read(libraryPageFilterProvider);
  return ref.read(libraryListProvider).where((e) => e.type == filter).toList();
});

final libraryPageFilterProvider =
    StateNotifierProvider<FilterNotifier, String>((ref) {
  return FilterNotifier();
});

final libraryListProvider = StateNotifierProvider<LibraryNotifier, List>((ref) {
  return LibraryNotifier();
});

class LibraryNotifier extends StateNotifier<List> {
  LibraryNotifier() : super([]);
}

final playListProvider =
    NotifierProvider<PlayListNotifier, List<Track>>(() => PlayListNotifier());

final indexProvider =
    StateNotifierProvider<IndexNotifier, int>((ref) => IndexNotifier(ref));

class IndexNotifier extends StateNotifier<int> {
  StateNotifierProviderRef<IndexNotifier, int> ref;
  IndexNotifier(this.ref) : super(0);
  void set(int i) {
    if (ref.read(playListProvider).length == 0) {
      state = 0;
    } else {
      state = i % ref.read(playListProvider).length;
    }
  }
}

final genreProvider = FutureProvider<List<Genre>>(
    (ref) async => ref.read(apiProvider).getGenres());

final searchListProvider = FutureProviderFamily<SearchResult, String>(
    (ref, query) async => ref.read(apiProvider).search(query));

final searchPageFilterProvider =
    StateNotifierProvider<FilterNotifier, String>((ref) {
  return FilterNotifier();
});

class FilterNotifier extends StateNotifier<String> {
  FilterNotifier() : super('');
  set(String f) {
    state = f;
  }
}
