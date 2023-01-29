import 'package:flutter/cupertino.dart';
import 'package:spotify_clone/core/album_view.dart';
import 'package:spotify_clone/views/views.dart';

Map<String, Widget Function(BuildContext)> routes = {
  'CreatePlaylist': (_) => CreatePlaylist(),
  'PlayerFull': (_) => PlayerFull(),
  'LikedSongs': (_) => LikedSongs(),
  'AlbumView': (_) => AlbumView(),
};
