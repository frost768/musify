import 'package:flutter/cupertino.dart';
import 'package:spotify_clone/views/views.dart';

Map<String, Widget Function(BuildContext)> routes = {
  'CreatePlaylist': (_) => CreatePlaylist(),
};
