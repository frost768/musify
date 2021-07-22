import 'package:spotify_clone/data/albums.dart';
import 'package:spotify_clone/data/artists.dart';
import 'package:spotify_clone/models/playlist.dart';
import 'package:spotify_clone/models/track.dart';

List<Playlist> playlists = [
  Playlist(0, 'Motive'),
  Playlist(1, 'Workout'),
  Playlist(2, 'LP'),
  Playlist(3, 'frost768 favs'),
  Playlist(3, 'rap'),
];
void initPlaylist() {
  playlists[0].tracks = [
    Track(1, 'Believe', eminem.id, revival.id),
    Track(2, 'Without Me', eminem.id, eminemShow.id),
    Track(3, 'Stepdad', eminem.id, mtmb.id),
    Track(4, 'Kamikaze', eminem.id, kamikaze.id, isExplicit: true),
  ];
}
