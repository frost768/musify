import 'package:spotify_clone/models/base_model.dart';
import 'package:spotify_clone/models/playlist.dart';
import 'package:spotify_clone/models/track.dart';

class User extends BaseModel {
  List<Track> favorites = [];
  List<Track> favoriteArtists = [];
  List<Playlist> playlists = [];

  User(
    id,
    name,
  ) : super(id: id, name: name);
}
