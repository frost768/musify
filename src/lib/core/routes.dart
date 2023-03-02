import 'package:flutter/cupertino.dart';

import 'package:spotify_clone/views/views.dart';

Map<String, Widget Function(BuildContext)> routes = {
  'Home': (_) => Home(),
  // 'CreatePlaylist': (_) => CreatePlaylist(),
  'PlayerFull': (_) => PlayerFull(),
  // 'LikedSongs': (_) => LikedSongs(),
  'AlbumView': (_) => AlbumView(),
};
