import 'package:spotify_clone/data/artists.dart';
import 'package:spotify_clone/models/album.dart';

final List<Album> albums = List.generate(
    20, (index) => Album(index, 'Album $index', artist: spofityArtist));
