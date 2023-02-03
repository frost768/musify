import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone/models/search_result.dart';
import 'package:spotify_clone/models/track.dart';
import 'package:spotify_clone/models/genre.dart';
import 'package:spotify_clone/services/api_service.dart';
import 'package:spotify_clone/services/lyrics_service.dart';

class PlayListNotifier extends Notifier<List<Track>> {
  PlayListNotifier() : super();
  void addToPlaylist(Track track) {
    state = [...state, track];
  }

  @override
  List<Track> build() {
    return [];
  }
}

class CurrentTrackNotifier extends Notifier<Track?> {
  CurrentTrackNotifier() : super();
  void set(Track track) {
    final index = ref.read(playListProvider).indexOf(track);
    if (index >= 0) {
      ref.read(indexProvider.notifier).set(index);
    } else {
      ref.read(playListProvider.notifier).addToPlaylist(track);
      var i = ref.read(playListProvider).length - 1;
      ref.read(indexProvider.notifier).set(i);
    }
    state = track;
  }

  @override
  Track? build() {
    if (ref.read(playListProvider).isEmpty) {
      return null;
    }
    return ref.read(playListProvider)[ref.read(indexProvider)];
  }

  void toggleLike() {
    ref.read(playListProvider)[ref.read(indexProvider)] = ref
        .read(playListProvider)[ref.read(indexProvider)]
        .copyWith(liked: !state!.liked);
    state = ref.read(playListProvider)[ref.read(indexProvider)];
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

final currentTrackProvider = NotifierProvider<CurrentTrackNotifier, Track?>(
    () => CurrentTrackNotifier());

final lyricsProvider = FutureProvider.family<String, Track>((ref, track) =>
    LyricsifyLyricsFinder().getLrc(track.title, track.artist.name));

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
  void set(int i) => state = i % ref.read(playListProvider).length;
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
