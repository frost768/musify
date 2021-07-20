import 'package:spotify_clone/data/artists.dart';
import 'package:spotify_clone/data/strings.dart';
import 'package:spotify_clone/models/album.dart';
import 'package:spotify_clone/models/track.dart';

final kamikaze = Album(234, 'Kamikaze',
    artistId: eminem.id,
    copyrightText: '$copyright $soundRecordCompany 2016 WEB Entertaiment');
final noPressure = Album(42, 'No Pressure', artistId: logic.id);
final eminemShow = Album(4232, 'The Eminem Show', artistId: eminem.id);
final revival = Album(993, 'Revival', artistId: eminem.id);
final mtmb = Album(313, 'Music To Be Murdered By', artistId: eminem.id);
final List<Album> albums = [
  ...logic.albums,
  ...eminem.albums,
];
void initTracks() {
  noPressure.tracks = [
    Track(893, '5 A.M.', logic.id, noPressure.id),
    Track(1431, 'Perfect', logic.id, noPressure.id)
  ];
  eminemShow.tracks = [Track(2, 'Without Me', eminem.id, eminemShow.id)];
  revival.tracks = [Track(1, 'Believe', eminem.id, revival.id)];
  kamikaze.tracks = [
    Track(4, 'Kamikaze', eminem.id, kamikaze.id, isExplicit: true)
  ];
  mtmb.tracks = [Track(3, 'Stepdad', eminem.id, mtmb.id)];
}
