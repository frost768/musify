import 'package:spotify_clone/data/artists.dart';
import 'package:spotify_clone/models/artist.dart';
import 'package:spotify_clone/models/base_model.dart';
import 'package:spotify_clone/models/track.dart';

class Album extends BaseModel {
  Artist? artist = spofityArtist;
  List<Track> tracks = const [];

  Album(int id, String name, {this.artist}) : super() {
    this.id = id;
    this.name = name;
  }
}
