import 'package:spotify_clone/models/album.dart';
import 'package:spotify_clone/models/artist.dart';
import 'package:spotify_clone/models/base_model.dart';
import 'package:spotify_clone/models/playlist.dart';
import 'package:spotify_clone/models/track.dart';

class User extends BaseModel {
  List<Track> favorites = [];
  List<Artist> favoriteArtists = [];
  List<Album> favoriteAlbums = [];
  List<Playlist> playlists = [];

  User(
    int id,
    String name,
  ) : super(id: id, name: name);
}
