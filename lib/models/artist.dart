import 'package:spotify_clone/models/album.dart';
import 'package:spotify_clone/models/base_model.dart';

class Artist extends BaseModel {
  int listenerCount;
  bool isFollowing;
  List<Album> albums;
  Artist(int id, String name, this.listenerCount,
      {this.isFollowing = false, this.albums = const []})
      : super(id: id, name: name);
}
