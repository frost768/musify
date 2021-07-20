import 'package:spotify_clone/models/base_model.dart';
import 'package:spotify_clone/models/track.dart';
import 'package:spotify_clone/models/user.dart';

class Playlist extends BaseModel {
  bool following;
  User? createdBy;
  List<Track> tracks;
  Duration get totalDuration => tracks.map((t) => t.duration).reduce((value,
          element) =>
      Duration(milliseconds: value.inMilliseconds + element.inMilliseconds));
  Playlist(
    int id,
    String name, {
    this.following = false,
    this.tracks = const [],
    this.createdBy,
  }) : super(id: id, name: name);
}
