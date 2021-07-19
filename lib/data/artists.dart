import 'package:spotify_clone/data/albums.dart';
import 'package:spotify_clone/models/artist.dart';

final Artist spofityArtist = Artist(0, 'Spotify', 4324324324);
final Artist eminem = Artist(1, 'Eminem', 540022);
final Artist logic = Artist(2, 'Logic', 540022);
final hansZimmer = Artist(3, 'Hans Zimmer', 93721);
final hopsin = Artist(5, 'Hopsin', 686886);
final List<Artist> artists = [spofityArtist, logic, eminem, hansZimmer, hopsin];
void initAlbums() {
  eminem.albums = [kamikaze, eminemShow, revival, mtmb];
  logic.albums = [noPressure];
}
