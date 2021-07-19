import 'package:spotify_clone/models/artist.dart';
import 'package:spotify_clone/models/base_model.dart';

class Track extends BaseModel {
  String album;
  Duration duration;
  String albumArtUrl;
  Artist artist;
  bool liked;

  Track(id, name, this.artist, this.album, this.albumArtUrl,
      {this.liked = false,
      this.duration = const Duration(minutes: 2, seconds: 20)})
      : super(id: id, name: name);
}
