import 'package:spotify_clone/data/albums.dart';
import 'package:spotify_clone/data/artists.dart';
import 'package:spotify_clone/models/album.dart';
import 'package:spotify_clone/models/artist.dart';
import 'package:spotify_clone/models/base_model.dart';

class Track extends BaseModel {
  int albumId;
  int artistId;
  Album get album => albums.firstWhere((album) => album.id == albumId);
  Artist get artist => artists.firstWhere((artist) => artist.id == artistId);
  Duration duration;
  bool liked;

  Track(int id, String name, this.artistId, this.albumId,
      {this.liked = false,
      this.duration = const Duration(minutes: 2, seconds: 20)})
      : super(id: id, name: name);
}
