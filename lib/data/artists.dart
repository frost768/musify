import 'package:spotify_clone/models/artist.dart';

final Artist spofityArtist = Artist(0, 'Spotify', 4324324324);
final Artist eminem = Artist(0, 'Eminem', 540022);

final Artist logic = Artist(0, 'Logic', 540022);
final List<Artist> artists = List.generate(
    4,
    (index) => Artist(
          index,
          'Artist $index',
          index * 5,
        ));
