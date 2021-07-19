import 'package:get/get.dart';
import 'package:spotify_clone/models/playlist.dart';
import 'package:spotify_clone/models/track.dart';
import 'package:spotify_clone/models/user.dart';

class UserController extends GetxController {
  User user = User(0, 'frost768');
  List<Playlist> get playlists => user.playlists;
  List<Track> get favorites => user.favorites;
  void addToFavorites(Track track) {
    bool inList = user.favorites.contains(track);
    if (!inList) {
      user.favorites.add(track);
    }
  }

  void removeFromFavorites(int trackId) {
    user.favorites.removeWhere((element) => element.id == trackId);
  }

  void createPlaylist(String name, {List<Track> tracks = const []}) {
    Playlist playlist = Playlist(1, name, tracks: tracks, createdBy: user);
    user.playlists.add(playlist);
  }
}
