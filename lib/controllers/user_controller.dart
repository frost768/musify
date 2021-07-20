import 'package:get/get.dart';
import 'package:spotify_clone/data/strings.dart';
import 'package:spotify_clone/models/album.dart';
import 'package:spotify_clone/models/artist.dart';
import 'package:spotify_clone/models/playlist.dart';
import 'package:spotify_clone/models/track.dart';
import 'package:spotify_clone/models/user.dart';

class UserController extends GetxController {
  User user = User(0, 'frost768');
  String createPlaylistName = '';
  List<Playlist> get playlists => user.playlists;
  List<Track> get favorites => user.favorites;
  List<Artist> get favoriteArtists => user.favoriteArtists;
  List<Album> get favoriteAlbums => user.favoriteAlbums;
  void addToFavorites(Track track) {
    bool inList = user.favorites.contains(track);
    if (!inList) {
      user.favorites.add(track);
      update();
    }
  }

  void removeFromFavorites(int trackId) {
    user.favorites.removeWhere((element) => element.id == trackId);
    update();
  }

  void createPlaylist({String? name, List<Track> tracks = const []}) {
    if (createPlaylistName.isEmpty)
      name = '$kPlaylistGenericName ${user.playlists.length + 1}';
    else {
      name = createPlaylistName;
    }

    Playlist playlist = Playlist(1, name, createdBy: user);
    playlist.tracks = tracks;
    user.playlists.add(playlist);
    update();
  }
}
