import 'package:spotify_clone/data/artists.dart';
import 'package:spotify_clone/models/artist.dart';
import 'package:spotify_clone/models/base_model.dart';
import 'package:spotify_clone/models/track.dart';

class Album extends BaseModel {
  String albumArtUrl;
  String copyrightText;
  int artistId;
  bool isFavorite = false;
  Duration get duration => tracks.map((e) => e.duration).reduce((prev, curr) =>
      Duration(milliseconds: prev.inMilliseconds + curr.inMilliseconds));
  Artist get artist => artists.firstWhere((artist) => artist.id == artistId);
  List<Track> tracks;

  Album(int id, String name,
      {this.artistId = 0,
      this.tracks = const [],
      this.albumArtUrl = '',
      this.copyrightText = ''})
      : super(id: id, name: name);
}
